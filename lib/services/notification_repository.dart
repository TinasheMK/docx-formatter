// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:work_link/src/app_providers.dart';
// import 'package:work_link/src/constants.dart';
// import 'package:work_link/src/features/shift-filter/data/filter_model.dart';
// import 'package:work_link/src/models/filter-shift/filtered_shift.dart';
//
// import '../models/worker_notifications_response.dart';
// import 'index.dart';
//
// class NotificationRepository {
//   Dio _dioClient;
//
//   final Reader _reader;
//
//    NotificationRepository(this._reader) : _dioClient = _reader(dioProvider);
//
//   /// get all shift by status
//   Future<WorkerNotificationResponse?> getNotifications() async {
//     final options = _reader(accessKeyOptionsProvider).state;
//     final _worker = _reader(loginResponseProvider).state;
//
//     int workerId = _worker?.workerId ?? 1;
//     try {
//       final result = await _dioClient.get(
//           '$dataService/api/v1/notifications/$workerId/0/100',
//           options: options);
//
//       log(result, 'd');
//       if (result.statusCode == 200) {
//         var l = result.data as List;
//         log(l, 'd');
//         if (l.isEmpty) {
//           return WorkerNotificationResponse(content: []);
//         }
//
//         final List<Map<String, dynamic>> shiftsR = List.from(l);
//
//         log(shiftsR, 'd');
//
//         List<Content> shifts = shiftsR.map((e) => Content.fromJson(e)).toList();
//
//
//         return WorkerNotificationResponse(content: shifts);
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'Error getting available notifications. Try again later');
//       }
//     }
//     catch (e) {
//       log(e, 'e');
//       throw exceptionHandler(e, 'worker notifications');
//     }
//   }
//
// }
