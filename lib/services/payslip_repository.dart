// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:work_link/src/app_providers.dart';
// import 'package:work_link/src/constants.dart';
// import 'package:work_link/src/features/shift-filter/data/filter_model.dart';
// import 'package:work_link/src/models/filter-shift/filtered_shift.dart';
//
// import '../models/payslip/payslip_response.dart';
// // import '../models/worker_notifications_response.dart';
// import 'index.dart';
//
// class PayslipRepository {
//   Dio _dioClient;
//
//   final Reader _reader;
//
//   PayslipRepository(this._reader) : _dioClient = _reader(dioProvider);
//
//   /// get all worker payslips
//   Future<PayslipResponse?> getPayslips() async {
//     final options = _reader(accessKeyOptionsProvider).state;
//     final _worker = _reader(loginResponseProvider).state;
//
//     int workerId = _worker?.workerId ?? 1;
//     try {
//       final result = await _dioClient.get(
//           '$dataService/api/v1/worker-payslips/$workerId/0/100?workerId=$workerId',
//           options: options);
//
//       log(result, 'd');
//       if (result.statusCode == 200) {
//         print('Getting worker payslips');
//         var res = PayslipResponse.fromJson(result.data);
//         print('Getting worker payslips');
//         return res;
//       }
//       // throw error
//       else {
//         throw Exception('Error getting available payslips. Try again later');
//       }
//     } catch (e) {
//       log(e, 'e');
//       print(e);
//       throw exceptionHandler(e, 'worker payslips');
//     }
//   }
// }
