/// connect to backend for syncing data
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/providers/invoice/provider/invoice_state_notifier.dart';
import 'package:smart_admin_dashboard/providers/registration/Invoice.dart';

import '../../../app_providers.dart';
import '../../../common/UserPreference.dart';
import '../../../constants.dart';
import '../../../services/exception_handler.dart';
import '../model/syncresult.dart';

abstract class IInvoiceRepository {
  Future postSyncInvoices();
  Future<InvoiceSyncResult> getSyncInvoices();
}

class InvoiceRepository implements IInvoiceRepository {
  Dio _dioClient;

  final url = '';

  final Reader _reader;

  InvoiceRepository(this._reader) : _dioClient = _reader(dioProvider);

  @override
  Future postSyncInvoices() async {
    InvoiceSyncResult syncres = new InvoiceSyncResult();
    var invoices = await getInvoices('desc');
    // var invoices = await getPostSyncInvoices();
    List allInvoices = invoices.map((item) => item.toJson()).toList();
    print(allInvoices);

    if (allInvoices.isEmpty) {
      syncres.success = true;
      syncres.message = "Nothing to sync";
      return syncres;
    }

    // try {
      final result = await _dioClient.post(
        '$invoicerService/api/v1/invoices',
        data: allInvoices,
      );

      // log("Invoices sync response +++" + result.toString());
      // print("Invoices sync response +++" + result.toString());

    if (result.statusCode == 200) {
      var res = result as List;

      //log(res, 'd');

      if (res.isEmpty) {
        syncres.success = false;
        syncres.message = "Server failed to sync";
        return syncres;
      }

      final List<Map<String, dynamic>> invoicesr = List.from(res);

      // log(invoicesr, 'd');

      List<Invoice> invoices = invoicesr.map((e) => Invoice.fromJson(e)).toList();
      List confirmInvoices = [];
      for(int i =0; i<invoices.length; i++){

        Invoice localInvoice = await getInvoice(invoices[i].originId);
        localInvoice.universalId = invoices[i].universalId;
        localInvoice.originId = invoices[i].originId;
        localInvoice.isSynced = true;
        localInvoice.isChanged = false;
        localInvoice.isOptimised = true;
        localInvoice.save();

        confirmInvoices.add(localInvoice.toJson());
      }
      final confirmed = await _dioClient.post(
        '$invoicerService/api/v1/invoices',
        data: allInvoices,
      );

      if (confirmed.statusCode == 200) {
        syncres.success = true;
        return syncres;
      }


    }

      // throw error
      else {
        throw Exception(
            'There was a problem syncing invoices. Please try again later');
      }
    // }
    // catch (e) {
    //   log(e.toString());
    //   throw exceptionHandler(e, 'invoices request');
    // }
  }


  @override
  Future<InvoiceSyncResult> getSyncInvoices() async {
    InvoiceSyncResult syncres = new InvoiceSyncResult();
    var prefs = await SharedPreferences.getInstance();
    var lastSyncDate = (await prefs!.getString(UserPreference.lastSyncDate))?? "";
    var userId = (await prefs!.getString(UserPreference.userId))?? "";

    try {
      final result = await _dioClient.get(
        '$invoicerService/api/v1/invoices/${userId}/${lastSyncDate}',
      );

      // log("Invoices sync response +++" + result.toString());
      // print("Invoices sync response +++" + result.toString());

    if (result.statusCode == 200) {
      var res = result as List;

      //log(res, 'd');

      if (res.isEmpty) {
        syncres.success = true;
        return syncres;
      }

      final List<Map<String, dynamic>> invoicesr = List.from(res);

      // log(invoicesr, 'd');

      List<Invoice> invoices = invoicesr.map((e) => Invoice.fromJson(e)).toList();


      for(int i =0; i<invoices.length; i++){
        Invoice localInvoice = await getInvoice(invoices[i].id);
        // TO DO make get by universal id
        if(localInvoice.isChanged==null || localInvoice!.isChanged ==false){
          invoices[i].id = localInvoice.id;
          invoices[i].save();
        }else if(localInvoice!.isChanged ==true){
          if(await invoices[i].compare()){
            invoices[i].id = localInvoice.id;
            invoices[i].save();

          }else{
            syncres.success = false;
            syncres.invoice =  invoices[i];
            return syncres;
          }
        }

      }

      syncres.success = true;

      return syncres;
    }


      // throw error
      else {
        throw Exception(
            'There was a problem syncing invoices. Please try again later');
      }
    }
    catch (e) {
      syncres.success = false;
      syncres.invoice =  await getInvoice(1);
      print( syncres.success);
      print("I am kings?");


      return syncres;

      log(e.toString());
      throw exceptionHandler(e, 'invoices request');
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



