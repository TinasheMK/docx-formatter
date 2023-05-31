/// connect to backend for syncing data
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_providers.dart';
import '../../../common/UserPreference.dart';
import '../../../constants.dart';
import '../../../services/exception_handler.dart';

abstract class IInvoiceRepository {
  Future invoices();
}

class InvoiceRepository implements IInvoiceRepository {
  Dio _dioClient;

  final url = '';

  final Reader _reader;

  InvoiceRepository(this._reader) : _dioClient = _reader(dioProvider);

  @override
  Future invoices() async {
    try {
      final result = await _dioClient.post(
        '$invoicerService/api/v1/invoices',
        data: "data",
      );

      log("Invoices sync response +++" + result.toString());

      if (result.statusCode == 200) {
        print(result);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(UserPreference.postSynced, true);

        return true;
      }

      // throw error
      else {
        throw Exception(
            'There was a problem syncing invoices. Please try again later');
      }
    }
    catch (e) {
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
