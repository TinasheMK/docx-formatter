/// connect to backend for syncing data
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/providers/invoice/provider/invoice_state_notifier.dart';
import 'package:smart_admin_dashboard/providers/registration/Invoice.dart';

import '../../../app_providers.dart';
import '../../../common/UserPreference.dart';
import '../../../constants.dart';
import '../../../services/exception_handler.dart';
import '../../compare_res.dart';
import '../model/syncresult.dart';

abstract class IInvoiceRepository {
  Future<InvoiceSyncResult> postSyncInvoices();
  Future<InvoiceSyncResult> getSyncInvoices();
}

class InvoiceRepository implements IInvoiceRepository {
  Dio _dioClient;

  final url = '';

  final Reader _reader;

  InvoiceRepository(this._reader) : _dioClient = _reader(dioProvider);


  @override
  Future<InvoiceSyncResult> getSyncInvoices() async {
    InvoiceSyncResult syncres = new InvoiceSyncResult();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    var prefs = await SharedPreferences.getInstance();
    var lastSyncDate = (await prefs!.getString(UserPreference.lastSyncDate))?? dateFormat.format(DateTime.now().subtract(Duration(days: 15)));
    var userId = (await prefs!.getString(UserPreference.userId));

    if(userId==null){
      syncres.success = false;
      syncres.code = 1; // login required
      syncres.message = 'Login required';
      return syncres;
    }

    var url = '$invoicerService/api/v1/invoices/1/${lastSyncDate}';
    // var url = '$invoicerService/api/v1/invoices/${userId}/${lastSyncDate}';

      Response result = await _dioClient.get(
        url
      );

      if (result.statusCode == 200) {
        print("Received get sync invoices: "+result.data.toString());
        var res = result.data as List;

        if (res.isEmpty) {
          syncres.success = true;
          syncres.message = 'No invoice updates from server';
          return syncres;
        }

        final List<Map<String, dynamic>> invoicesr = List.from(res);

        List<Invoice> invoices = invoicesr.map((e) => Invoice.fromPostSyncJson(e)).toList();

        for(int i =0; i<invoices.length; i++){
          Invoice? localInvoice = await getInvoiceByUniversalId(invoices[i].universalId!);

          if(localInvoice != null) {
            if(invoices[i].version == localInvoice.version) continue;

            if (localInvoice!.isSynced == true) {invoices[i].isSynced = true;
              invoices[i].id = localInvoice.id;
              invoices[i].save();
            }
            else if (localInvoice!.isSynced == false) {
              List<CompareRes> comps = await invoices[i].compare();
              if (comps.isEmpty) {invoices[i].isSynced = true;
                invoices[i].id = localInvoice.id;
                invoices[i].save();
              } else {
                syncres.success = false;
                syncres.message = "There are some conflicts";
                syncres.invoice = invoices[i];
                return syncres;
              }
            }


          }
          else{
            invoices[i].isSynced = true;
            invoices[i].id = null;
            invoices[i].save();
          }

        }
        syncres.success = true;
        prefs!.setString(UserPreference.lastSyncDate, dateFormat.format(DateTime.now()).toString());
        return syncres;
      }else {
        throw Exception(
            'There was a problem syncing invoices. Please try again later');
      }
  }

  @override
  Future<InvoiceSyncResult> postSyncInvoices() async {

    try {
      InvoiceSyncResult syncres = new InvoiceSyncResult();
      List<Invoice> syncInvoices = await getInvoicesForSync();
      List syncReadyInvs = syncInvoices.map((item) => item.toSyncJson()).toList();
      print(syncReadyInvs);

      if (syncReadyInvs.isEmpty) {
        print("No invoices to post sync");
        syncres.success = true;
        syncres.message = "Nothing to sync";
        return syncres;
      }

      final syncRes = await _dioClient.post(
        '$invoicerService/api/v1/invoices',
        data: syncReadyInvs,
      );

      if (syncRes.statusCode == 200) {
        var res = syncRes.data as List;
        final List<Map<String, dynamic>> incomingInvsJson = List.from(res);
        List<Invoice> incomingInvs = incomingInvsJson.map((e) =>
            Invoice.fromPostSyncJson(e)).toList();

        //Save incoming invoices
        incomingInvs.forEach((i) {
          i.save();
          i.isConfirmed = true;
          i.isSynced = true;
        });


        //Confirm changes to server
        List confirmReadyInvs = incomingInvs.map((item) => item.toSyncJson())
            .toList();
        print(confirmReadyInvs.toString());
        final confirmRes = await _dioClient.post(
          '$invoicerService/api/v1/invoices',
          data: confirmReadyInvs,
        );

        //Save objects with confirm true
        if (confirmRes.statusCode == 200) {
          var res = confirmRes.data as List;
          final List<Map<String, dynamic>> incomingInvsJson = List.from(res);

          List<Invoice> incomingInvs = incomingInvsJson.map((e) =>
              Invoice.fromPostSyncJson(e)).toList();

          //Save incoming data
          incomingInvs.forEach((i) {
            i.isSynced = true;
            i.save();
          });
        }

        //Successfull sync response
        syncres.success = true;
        syncres.message = "Invoices synced";
        return syncres;
      } else {
        throw Exception(
            'There was a problem syncing invoices. Please try again later');
      }
    }
    catch (e) {
      log(e.toString());
      throw exceptionHandler(e, 'Post sync failed');
    }
  }


  void networkErrorHandler(Object e, String status) {
    if (e is DioError) {
      final DioError err = e;

      switch (err.type) {
        case DioErrorType.badResponse:
          final errorData = err.response?.data as Map;
          throw Exception(errorData.values.first.first);

        case DioErrorType.connectionTimeout:
          throw Exception('Connection Timeout. Try again');

        case DioErrorType.receiveTimeout:
          throw Exception(
              'Connection Timeout while loading, please try again to reload');

        case DioErrorType.sendTimeout:
          throw Exception('Connection Timeout. Try again');

        default:
          throw Exception('Failed to $status. Please try again');
      }
    }
    else {
      throw Exception('Failed to $status. Please try again later');
    }
  }

}



