import 'package:dio/dio.dart';

import 'custom_exception.dart';


CustomException exceptionHandler(Object? e, String? topic) {
  CustomException _exception = CustomException();

  if (e is DioError) {
    final DioError err = e;

    switch (err.type) {
      case DioErrorType.badResponse:

        try {
          final errorData = err.response?.data as Map;
          _exception.message = errorData["message"];
        } catch (e) {
          _exception.message = err.message;
        }
        break;

      case DioErrorType.connectionTimeout:
        _exception.message = 'Connection Timeout. Try again';
        break;

      case DioErrorType.receiveTimeout:
        _exception.message =
            'Connection Timeout while loading, please try again to reload';
        break;

      case DioErrorType.sendTimeout:
        _exception.message = 'Connection Timeout. Try again';
        break;

      default:
        _exception.message = 'Failed to get $topic. Please try again';
    }
  }

  // else
  else {
    // log(e);
    _exception.message =
        'There was a problem processing $topic. Please try again';
  }

  //log(_exception);
  _exception.message = _exception.message!.isEmpty
      ? 'Failed to process $topic. Please try again later'
      : _exception.message;

  return _exception;
}
