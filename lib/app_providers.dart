import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'core/constants/constants.dart';
import 'core/providers/auth/model/login_response.dart';
import 'core/exceptions/custom_exception.dart';
import 'core/providers/profile/worker_profile.dart';


final requestStateProvider = StateProvider((_) => RequestState.None);

final loaderStateProvider = StateProvider<Loader?>((ref) {
  return Loader.None;
});

/// for toggling anything that needs true / false
final toggleProvider = StateProvider<bool?>((ref) {
  return false;
});

/// signup individual or comoany
final accTypeProvider = StateProvider<bool>((ref) {
  return true;
});

final loaderMessageProvider = StateProvider<String>((ref) {
  return 'loading..';
});

final loggerProvider = Provider<Logger>(
  (ref) => Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      printEmojis: false,
    ),
  ),
);

final customExceptionProvider = StateProvider<CustomException?>((ref) {
  return CustomException();
});

/// user token provider map with refresh & access token
final authKeyProvider = StateProvider<String>((ref) => '');

final workerProfileProvider = StateProvider<WorkerProfile?>((ref) => null);

final loginResponseProvider = StateProvider<LoginResponse?>((_) => null);

final accessKeyOptionsProvider = StateProvider<Options?>((ref) {
  final authKey = ref.watch(authKeyProvider).state;

  return Options(headers: {"Authorization": "Bearer $authKey"});
});

/// dio base provider
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 50),
    ),
  );
});
