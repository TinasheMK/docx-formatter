/// connect to backend for syncing data
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../init/app_providers.dart';
import '../../../utils/UserPreference.dart';
import '../../../constants/constants.dart';
import '../../../exceptions/exception_handler.dart';
import '../../../types/compare_res.dart';
import '../../../models/Business.dart';
import '../../../types/syncresult.dart';

abstract class IBusinessRepository {
  Future<SyncResult> postSyncBusinesss();
  Future<SyncResult> getSyncBusinesss();
}

class BusinessRepository implements IBusinessRepository {
  Dio _dioBusiness;

  final url = '';

  final Reader _reader;

  BusinessRepository(this._reader) : _dioBusiness = _reader(dioProvider);


  @override
  Future<SyncResult> getSyncBusinesss() async {
    SyncResult syncres = new SyncResult();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    var prefs = await SharedPreferences.getInstance();
    var lastSyncDate =  dateFormat.format(DateTime.now().subtract(Duration(days: 15)));
    // var lastSyncDate = (await prefs!.getString(UserPreference.lastSyncDate))?? dateFormat.format(DateTime.now().subtract(Duration(days: 15)));
    var userId = (await prefs!.getString(UserPreference.userId));

    if(userId==null){
      syncres.success = false;
      syncres.code = 1; // login required
      syncres.message = 'Login required';
      return syncres;
    }

    var url = '$invoicerService/api/v1/businesses/1/${lastSyncDate}';

    Response result = await _dioBusiness.get(
        url
    );

    if (result.statusCode == 200) {
      print("Received get sync businesss: "+result.data.toString());
      var res = result.data as List;

      if (res.isEmpty) {
        syncres.success = true;
        syncres.message = 'No business updates from server';
        return syncres;
      }

      final List<Map<String, dynamic>> businesssr = List.from(res);

      List<Business> businesss = businesssr.map((e) => Business.fromSyncJson(e)).toList();

      for(int i =0; i<businesss.length; i++){
        Business? localBusiness = await getBusinessByUni(businesss[i].universalId!);

        if(localBusiness != null) {

          // Skip if both local and server objects have no changes (on same version)
          if(businesss[i].version == localBusiness.version) continue;

          //Save incoming if local has no changes (isSync still true)
          if (localBusiness!.isSynced == true) {
            businesss[i].isSynced = true;
            businesss[i].id = localBusiness.id;
            businesss[i].updateSynced();
          }

          //
          else if (localBusiness!.isSynced == false) {
            List<CompareRes> comps = await businesss[i].compare();
            if (comps.isEmpty) {businesss[i].isSynced = true;
            businesss[i].id = localBusiness.id;
            businesss[i].updateSynced();
            } else {
              syncres.success = false;
              syncres.message = "There are some conflicts";
              syncres.object = businesss[i];
              return syncres;
            }
          }


        }
        else{
          businesss[i].isSynced = true;
          businesss[i].id = null;
          businesss[i].saveSynced();
        }

      }
      syncres.success = true;
      prefs!.setString(UserPreference.lastSyncDate, dateFormat.format(DateTime.now()).toString());
      return syncres;
    }else {
      throw Exception(
          'There was a problem syncing businesss. Please try again later');
    }
  }

  @override
  Future<SyncResult> postSyncBusinesss() async {

    try {
      SyncResult syncresp = new SyncResult();
      List<Business> syncBusinesssp = await getBusinessesForSync();
      List syncReadyCliesp = syncBusinesssp.map((item) => item.toSyncJson()).toList();
      print(syncReadyCliesp);

      if (syncReadyCliesp.isEmpty) {
        print("No businesss to post sync");
        syncresp.success = true;
        syncresp.message = "Nothing to sync";
        return syncresp;
      }

      final syncRes = await _dioBusiness.post(
        '$invoicerService/api/v1/businesses',
        data: syncReadyCliesp,
      );

      if (syncRes.statusCode == 200) {
        var res = syncRes.data as List;
        final List<Map<String, dynamic>> incomingCliesJsonp = List.from(res);
        List<Business> incomingCliesp = incomingCliesJsonp.map((e) =>
            Business.fromSyncJson(e)).toList();

        //Save incoming businesss first stage of sync
        incomingCliesp.forEach((i) {
          i.updateSynced();
          i.isConfirmed = true;
          i.isSynced = true;
        });


        //Confirm changes to server
        List confirmReadyClies = incomingCliesp.map((item) => item.toSyncJson())
            .toList();
        print(confirmReadyClies.toString());
        final confirmRes = await _dioBusiness.post(
          '$invoicerService/api/v1/businesses',
          data: confirmReadyClies,
        );

        //Save objects with confirm true
        if (confirmRes.statusCode == 200) {
          var res = confirmRes.data as List;
          final List<Map<String, dynamic>> incomingCliesJson = List.from(res);

          List<Business> incomingClies = incomingCliesJson.map((e) =>
              Business.fromSyncJson(e)).toList();

          //Save incoming data
          incomingClies.forEach((i) {
            i.isSynced = true;
            i.updateSynced();
          });
        }

        //Successfull sync response
        syncresp.success = true;
        syncresp.message = "Businesss synced";
        return syncresp;
      } else {
        throw Exception(
            'There was a problem syncing businesses. Please try again later');
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



