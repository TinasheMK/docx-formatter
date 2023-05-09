// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:work_link/src/app_providers.dart';
// import 'package:work_link/src/constants.dart';
// import 'package:work_link/src/features/shift-filter/data/filter_model.dart';
// import 'package:work_link/src/models/filter-shift/filtered_shift.dart';
// import 'package:work_link/src/models/shift_client_status_response.dart';
//
// import 'index.dart';
//
// class ShiftRepository {
//   Dio _dioClient;
//
//   final Reader _reader;
//
//   ShiftRepository(this._reader) : _dioClient = _reader(dioProvider);
//
//   /// get all shift by status
//   Future<ShiftClientStatusResponse?> getShiftByStatus({
//     int workerId = 1,
//     String status = 'NEW',
//   }) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//
//     bool isApplied = (status == 'APPLIED');
//     String status_ = isApplied ? 'NEW' : status;
//
//     if(isApplied){
//       try {
//         final result = await _dioClient.get(
//             '$dataService/api/v1/worker-applied-shifts/$workerId/0/100',
//             options: options);
//
//         // log(result, 'd');
//         if (result.statusCode == 200) {
//           var l = result.data as List;
//
//           //log(l, 'd');
//
//           if (l.isEmpty) {
//             return ShiftClientStatusResponse(content: []);
//           }
//
//           final List<Map<String, dynamic>> shiftsR = List.from(l);
//
//           // log(shiftsR, 'd');
//
//           List<Content> shifts = shiftsR.map((e) => Content.fromJson(e)).toList();
//
//           var activeShifts = shifts.where((sh) {
//             // log(sh.toJson());
//             if (sh.shiftStatus == null) {
//               return true;
//             }
//
//             // bool aa = (sh.shiftStatus?.toLowerCase() != 'expired' &&
//             //     sh.appliedStatus == null);
//             bool aa = sh.shiftStatus?.toLowerCase() != 'expired';
//
//             return aa;
//           }).toList();
//
//           if (isApplied) {
//             final appliedShifts = activeShifts.where((sh) {
//               return sh.appliedStatus != null;
//             }).toList();
//
//             return ShiftClientStatusResponse(content: appliedShifts);
//           }
//
//           return ShiftClientStatusResponse(content: activeShifts);
//         }
//
//         // throw error
//         else {
//           throw Exception(
//               'Error getting available $status shifts. Try again later');
//         }
//       }
//       catch (e) {
//         log(e, 'e');
//         throw exceptionHandler(e, 'worker $status shifts');
//       }
//     }else{
//             try {
//         final result = await _dioClient.get(
//             '$dataService/api/v1/worker-agency-shift-status/$workerId/0/100/$status_',
//             options: options);
//
//         // log(result, 'd');
//         if (result.statusCode == 200) {
//           var l = result.data as List;
//
//           //log(l, 'd');
//
//           if (l.isEmpty) {
//             return ShiftClientStatusResponse(content: []);
//           }
//
//           final List<Map<String, dynamic>> shiftsR = List.from(l);
//
//           // log(shiftsR, 'd');
//
//           List<Content> shifts = shiftsR.map((e) => Content.fromJson(e)).toList();
//
//           var activeShifts = shifts.where((sh) {
//             // log(sh.toJson());
//             if (sh.shiftStatus == null) {
//               return true;
//             }
//
//             // bool aa = (sh.shiftStatus?.toLowerCase() != 'expired' &&
//             //     sh.appliedStatus == null);
//             bool aa = sh.shiftStatus?.toLowerCase() != 'expired';
//
//             return aa;
//           }).toList();
//
//           if (isApplied) {
//             final appliedShifts = activeShifts.where((sh) {
//               return sh.appliedStatus != null;
//             }).toList();
//
//             return ShiftClientStatusResponse(content: appliedShifts);
//           }
//
//           return ShiftClientStatusResponse(content: activeShifts);
//         }
//
//         // throw error
//         else {
//           throw Exception(
//               'Error getting available $status shifts. Try again later');
//         }
//       }
//       catch (e) {
//         log(e, 'e');
//         throw exceptionHandler(e, 'worker $status shifts');
//       }
//     }
//   }
//
//   /// get all filtered shift by status
//   /// yyyy-mm-dd
//   ///
//   /// return List<FilteredShift> if successful
//   Future getFilteredShiftByStatus(FilterModel filters) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//
//     bool isApplied = filters.status == 'APPLIED';
//     String status_ = isApplied ? 'NEW' : filters.status;
//
//     try {
//       final result = await _dioClient.post(
//         '$dataService/api/v1/shift-filter/${filters.workerId}/0/300?agentId=${filters.agentId}&clientId=${filters.clientId}&endDate=${filters.endDate}&location=${filters.location}&startDate=${filters.startDate}&status=$status_',
//         options: options,
//       );
//
//       if (result.statusCode == 200) {
//         var fData = result.data as List;
//
//         var shifts = fData.map((e) => FilteredShift.fromJson(e)).toList();
//
//         var activeShifts = shifts.where((sh) {
//           // log(sh.toJson());
//           if (sh.shiftStatus == null) {
//             return true;
//           }
//
//           return sh.shiftStatus?.toLowerCase() != 'expired';
//         }).toList();
//
//         if (isApplied) {
//           final appliedShifts = activeShifts.where((sh) {
//             return sh.appliedStatus != null;
//           }).toList();
//
//           return appliedShifts;
//         }
//
//         return activeShifts;
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'Error getting available filtered ${filters.status} shifts. Try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       log('[getFilteredShiftByStatus] $e', 'e');
//       return exceptionHandler(e, 'filtered worker ${filters.status} shifts');
//     }
//   }
//
//   Future registerDevice({required String? fcmToken}) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//     final _worker = _reader(loginResponseProvider).state;
//     // bool isApplied = filters.status == 'APPLIED';
//     // String status_ = isApplied ? 'NEW' : filters.status;
//
//     try {
//       final result = await _dioClient.post(
//         '$dataService/api/v1/device',
//         data: {"workerId": _worker?.workerId ?? 1,
//         "fcmToken": fcmToken},
//         options: options,
//       );
//
//       if (result.statusCode == 200) {
//         print('Succefully registered notifications token');
//
//     }
//
//
//       // throw error
//       else {
//             print('Error registering notifications token');
//       }
//     }
//
//     //
//     catch (e) {
//       log('[getFilteredShiftByStatus] $e', 'e');
//       return exceptionHandler(e, 'filtered workershifts');
//     }
//   }
//
//   /// book a shift
//   Future bookAShift({
//     int agencyId = 1,
//     required int shiftId,
//     required int workerId,
//   }) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//
//     try {
//       final result = await _dioClient.put(
//         '$dataService/api/v1/book-shift/$shiftId/$workerId/$agencyId',
//         options: options,
//       );
//
//       log('[bookShiftResponse] ${result.toString()}', 'd');
//
//       if (result.statusCode == 200) {
//         return true;
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem while booking a shift with id: $shiftId. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       log('[bookShift] ${e.toString()}', 'e');
//       return exceptionHandler(e, 'book shift');
//     }
//   }
//
//   /// book a shift
//   Future releaseShift({
//     required int shiftId
//   }) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//     final _worker = _reader(loginResponseProvider).state;
//     final workerId = _worker?.workerId ?? 1;
//     try {
//       final result = await _dioClient.put(
//         '$dataService/api/v1/release-shift/$shiftId/$workerId',
//         options: options,
//       );
//
//       log('[bookShiftResponse] ${result.toString()}', 'd');
//
//       if (result.statusCode == 200) {
//         return true;
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem while booking a shift with id: $shiftId. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       log('[bookShift] ${e.toString()}', 'e');
//       return exceptionHandler(e, 'book shift');
//     }
//   }
//
//   /// query a shift
//   Future queryAShift({
//     required int shiftId,
//     required int workerId,
//     String reason = 'shift query',
//   }) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//
//     try {
//       final result = await _dioClient.put(
//         '$dataService/api/v1/query-shift/$shiftId/$workerId/$reason',
//         options: options,
//       );
//
//       log(result, 'd');
//
//       if (result.statusCode == 200) {
//         return true;
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem while querying a shift with id: $shiftId. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       log(e, 'e');
//       return exceptionHandler(e, 'query shift');
//     }
//   }
//
//   /// apply a shift
//   Future applyAShift({
//     required int agencyId,
//     required int shiftId,
//     required int workerId,
//   }) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//
//     try {
//       final result = await _dioClient.put(
//         '$dataService/api/v1/apply-shift/$shiftId/$workerId/$agencyId',
//         options: options,
//       );
//
//       log(result, 'd');
//
//       if (result.statusCode == 200) {
//         return true;
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem while applying a shift with id: $shiftId. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       log(e, 'e');
//       return exceptionHandler(e, 'apply shift');
//     }
//   }
//
//   /// cancel a shift
//   Future cancelAShift({
//     required int workerId,
//     required int shiftId,
//     String reason = 'cancel shift reason',
//   }) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//
//     try {
//       final result = await _dioClient.put(
//         '$dataService/api/v1/cancel-shift-by-worker/$shiftId/$workerId/$reason',
//         options: options,
//       );
//
//       log(result, 'd');
//
//       if (result.statusCode == 200) {
//         return true;
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem while cancelling a shift with id: $shiftId. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       log(e, 'e');
//       return exceptionHandler(e, 'cancel shift');
//     }
//   }
// }
