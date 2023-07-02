/// connect to backend for logging in user / provider
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_providers.dart';
import '../../../utils/UserPreference.dart';
import '../../../constants/constants.dart';
import '../../services/exception_handler.dart';
import '../../services/shared_pref_service.dart';
import '../../profile/worker_profile.dart';
import '../model/login_response.dart';
// import 'package:work_link/src/app_providers.dart';
// import 'package:work_link/src/constants.dart';
// import 'package:work_link/src/models/auth/login_response.dart';
// import 'package:work_link/src/models/profile/worker_profile.dart';
// import 'package:work_link/src/services/index.dart';
// import 'package:work_link/src/common/UserPreference.dart';

abstract class IAuthRepository {
  Future login(Map<String, dynamic>? credentials, {bool rememberMe: false});

  Future forgotPaswd(String email);

  Future register(Map? payload);

  Future getTokenPair(Map<String, String>? credentials);

  Future getWorkerProfile(int id);

  Future refreshTokenPair();
}

class AuthRepository implements IAuthRepository {
  Dio _dioClient;

  final url = '';

  final Reader _reader;

  AuthRepository(this._reader) : _dioClient = _reader(dioProvider);

  @override
  Future getWorkerProfile(int id) async {
    final options = _reader(accessKeyOptionsProvider).state;

    print("worker data+++"+ '$invoicerService/api/v1/worker/$id');
    log(options.toString());

    // https: //api-test.myworklink.uk/$dataService/api/v1/agencies/0/100

    try {
      final result = await _dioClient.get(
        '$invoicerService/api/v1/employee/$id',
        options: options,
      );

      log(result.toString());

      if (result.statusCode == 200) {
        return WorkerProfile.fromJson(result.data);
      }

      // throw error
      else {
        throw Exception(
            'There was a problem getting profile. Please try again later');
      }
    }

    //
    catch (e) {
      log(e.toString());
      throw exceptionHandler(e, 'profile request');
    }
  }

  @override
  Future login(Map<String, dynamic>? credentials,
      {bool rememberMe: false}) async {
    // https://api-test.myworklink.uk/$authService/api/v1/user-permission/login
    try {
      final result = await _dioClient.post(
        '$authService/api/v1/user-permission/login',
        data: credentials,
      );

      log("login responsew++++" + result.toString());

      if (result.statusCode == 200) {
        // save access token in response header
        final LoginResponse resp = LoginResponse.fromJson(result.data);

        log(resp.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if(resp.userId == null)prefs.setString(UserPreference.userId, resp.userId.toString());
        prefs.setString(UserPreference.agentId,
            resp.agentId == null ? "":resp.agentId.toString());
        prefs.setString(UserPreference.clientId,
            resp.clientId == null ? "":resp.clientId.toString());
        prefs.setString(UserPreference.firstName, resp.firstName.toString());
        prefs.setString(UserPreference.lastName, resp.lastName.toString());
        prefs.setString(UserPreference.accessToken, resp.accessToken!);
        prefs.setString(UserPreference.id, resp.id.toString());


        _reader(authKeyProvider).state = resp.accessToken!;

        _reader(loginResponseProvider).state = resp;

        final WorkerProfile wp = new WorkerProfile(
          firstname: resp.firstName
        );
        prefs.setString(
            UserPreference.assignmentCodeId, resp.userId.toString());
        log(resp.toString());

        _reader(workerProfileProvider).state = wp;

        if (rememberMe) {
          await _reader(sharedPreferencesServiceProvider)
              .cacheUserCredentials(credentials!);
        }

        return wp;
      }

      // throw error
      else {
        throw Exception(
            'There was a problem logging in. Please try again later');
      }
    }

    //
    catch (e) {
      log(e.toString());
      throw exceptionHandler(e, 'login request');
    }
  }

  @override
  Future register(Map? data) async {
    try {
      print("Register employee data: "+ data.toString());

      final result = await _dioClient.post('$invoicerService/api/v1/employee', data: data);

        print("Register employee result: "+ result.data.toString());
      if (result.statusCode == 200) {
        return WorkerProfile.fromJson(result.data);
      }
      // throw error
      else {
        throw Exception('Failed to register. Please try again later');
      }
    }

    //
    catch (e) {
      networkErrorHandler(e, 'Network connection error');
    }
  }

  @override
  Future getTokenPair(Map<String, String>? credentials) async {
    try {
      final result = await _dioClient.post('users/login/', data: credentials);

      //print(result.data);

      if (result.statusCode == 200) {
        // all good
        Map<String?, String?> token = Map<String?, String?>.from(result.data);

        print(token);

        return credentials;
      }

      // throw error
      else {
        throw Exception('Failed to get access. Please try again later');
      }
    }

    //
    catch (e) {
      networkErrorHandler(e, 'login user');
    }
  }

  @override
  Future refreshTokenPair() async {
    try {
      final result = await _dioClient.post('auth/users/');

      if (result.statusCode == 201) {
        // all good
        return WorkerProfile.fromJson(result.data);
      }

      // throw error
      else {
        throw Exception('Failed to register. Please try again later');
      }
    }

    //
    catch (e) {
      networkErrorHandler(e, 'register user');
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

    // else
    else {
      throw Exception('Failed to $status. Please try again later');
    }
  }

  @override

  /// {}
  Future forgotPaswd(String email) async {
    try {
      // final result = await _dioClient.get(url);
      final postUrl = "$userService/api/v1/user-management/user/resetPassword?email=$email";
      final result = await _dioClient.post(postUrl);


      if (result.statusCode == 200) {
        // all good
        print('Password reset success: ${(result.data)}');

        Map<String?, String?> message = Map<String?, String?>.from(result.data);

        return message;
      }

      // throw error
      else {
        print('Password reset failed: ${(result.data)}');
        print('Status code: ${result.statusCode}');

        throw Exception('Failed to reset password. Please try again later');
      }

      // throw error
      // else {
      //   throw Exception();
      // }
    }

    //
    catch (e) {
      throw Exception();
    }
  }
}
