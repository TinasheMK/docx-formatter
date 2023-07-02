// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:async/async.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:http_parser/http_parser.dart';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:work_link/src/app_providers.dart';
// import 'package:work_link/src/constants.dart';
// import 'package:work_link/src/models/agencies-worker/agencies_worker.dart';
// import 'package:work_link/src/models/profile/worker_profile.dart';
// import 'package:work_link/src/models/shift_location_agency.dart';
// import 'package:work_link/src/models/worker-agencies/worker_agency.dart';
//
// import '../common/ApiCallingWithoutProgressIndicator.dart';
// import '../common/CustomProgressDialog.dart';
// import '../features/clients/model/ClientModel.dart';
// import 'index.dart';
//
// class DataRepository {
//   Dio _dioClient;
//
//   final Reader _reader;
//
//   DataRepository(this._reader) : _dioClient = _reader(dioProvider);
//
//   /// update worker
//   Future updateWorker(WorkerProfile profile) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//
//     print("profile json+++"+profile.toJson().toString());
//
//     try {
//       final result = await _dioClient.put('$dataService/api/v1/worker',
//           data: profile.toJson(), options: options);
//
//       // log(result, 'd');
//
//       if (result.statusCode == 200 || result.statusCode == 201) {
//         return true;
//       }
//
//       // throw error
//       else {
//         throw Exception('Error updating profile. Try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       log(e, 'e');
//       return exceptionHandler(e, 'worker profile update');
//     }
//   }
//
//   /// get worker agencies only
//   Future getWorkerAgencies() async {
//     final options = _reader(accessKeyOptionsProvider).state;
//     final _worker = _reader(workerProfileProvider).state;
//
//     try {
//       final result = await _dioClient.get(
//         '$dataService/api/v1/worker-agency/${_worker?.id}/0/300',
//         options: options,
//       );
//
//       if (result.statusCode == 200) {
//         return workerAgencyFromJson(result.toString());
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem getting available agencies. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       throw exceptionHandler(e, 'worker agencies');
//     }
//   }
//
//   /// get worker clients (has address) field
//   ///
//   /// default worker clients
//   Future getWorkerClients() async {
//     final options = _reader(accessKeyOptionsProvider).state;
//     final _worker = _reader(workerProfileProvider).state;
//
//     try {
//       final result = await _dioClient.get(
//         '$dataService/api/v1/worker-clients/${_worker?.id}/0/300',
//         options: options,
//       );
// print("worker====="+'$dataService/api/v1/worker-clients/${_worker?.id}/0/300');
//       if (result.statusCode == 200) {
//         log(result.data);
//         return AgenciesWorker.fromJson(result.data);
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem getting available clients. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       throw exceptionHandler(e, 'worker clients');
//     }
//   }
//
//
//   Future getProfileData(context) async {
//     try {
//       final _worker = _reader(workerProfileProvider).state;
//       CustomProgressLoader.showLoader(context);
//       Response? response = await ApiCalling()
//           .apiCall(context, "$dataService/api/v1/worker-clients/76/0/300", "get");
//       CustomProgressLoader.cancelLoader(context);
//       print("response++" + response.toString());
//       if (response != null) {
//         if (response.statusCode == 200) {
//          return ClientModel.fromJson(response.data);
//
//         }
//       }
//     } catch (e) {
//
//       return null;
//     }
//   }
//
//
//   Future getWorkerProfile() async {
//     final options = _reader(accessKeyOptionsProvider).state;
//     final _worker = _reader(workerProfileProvider).state;
//
//     try {
//       final result = await _dioClient.get(
//         '$dataService/api/v1/worker/${_worker?.id}',
//         options: options,
//       );
//
//       log(result.toString());
//
//       if (result.statusCode == 200) {
//         return WorkerProfile.fromJson(result.data);
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem getting profile. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       log(e, 'e');
//       throw exceptionHandler(e, 'profile request');
//     }
//   }
//
//   /// get clients by agencyId
//   Future getAgencyWorkerClients(int agentId) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//
//     try {
//       final result = await _dioClient.get(
//         '$dataService/api/v1/agency-clients/$agentId/0/300',
//         options: options,
//       );
//
//       if (result.statusCode == 200) {
//         log(result.data);
//         return AgenciesWorker.fromJson(result.data);
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem getting available clients. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       throw exceptionHandler(e, 'worker clients');
//     }
//   }
//
//   /// get shift locations by agency id
//   Future getShiftLocations() async {
//     final options = _reader(accessKeyOptionsProvider).state;
//     final _worker = _reader(loginResponseProvider).state;
//
//     try {
//       var id = _worker?.workerId;
//
//       final result = await _dioClient.get(
//         '$dataService/api/v1/shift-location-worker/$id',
//         options: options,
//       );
//
//       if (result.statusCode == 200) {
//         List data = result.data as List;
//
//         return data.map((e) => ShiftLocationAgency.fromJson(e)).toList();
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem getting available locations. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       throw exceptionHandler(e, 'worker locations');
//     }
//   }
//
//   /// get shift locations by client id
//   Future getMappedClientShiftLocations(int clientId) async {
//     final options = _reader(accessKeyOptionsProvider).state;
//
//     try {
//       final result = await _dioClient.get(
//         '$dataService/api/v1/shift-location-client/$clientId',
//         options: options,
//       );
//
//       if (result.statusCode == 200) {
//         List data = result.data as List;
//
//         return data.map((e) => ShiftLocationAgency.fromJson(e)).toList();
//       }
//
//       // throw error
//       else {
//         throw Exception(
//             'There was a problem getting available locations. Please try again later');
//       }
//     }
//
//     //
//     catch (e) {
//       throw exceptionHandler(e, 'worker locations');
//     }
//   }
//
//
// }
//
// upload(XFile imageFile, int workerId) async {
//
//
//
//
//
//
//   var dio = Dio();
//
//   var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//   var length = await imageFile.length();
//
//   print(imageFile.name);
//
//   final formData = FormData.fromMap({
//     'file': await MultipartFile.fromBytes(await imageFile.readAsBytes(), filename:imageFile.name),
//     "workerId": workerId,
//   });
//
//
//   try {
//     var res = await dio.post(
//       '$baseUrl' + 'worklink-api/api/v1/worker/profile-image',
//       // 'http://localhost:8300/api/v1/worker/profile-image',
//       data: formData,
//       options: Options(
//         sendTimeout: Duration(seconds: 120),
//         receiveTimeout: Duration(seconds: 120),
//       ),
//       onSendProgress: (a, b) => print('send ${a / b}'),
//       onReceiveProgress: (a, b) => print('received ${a / b}'),
//     ).then((r) {
//       print("Succesfuly uploaded");
//     });
//
//     if(res == null){
//       print(res);
//       return true;
//     }
//
//   } catch(e){
//     print(e);
//     return "An error occured";
//   }
//
//
//   //
//  // var url = Uri.parse('$baseUrl' + 'worklink-api/api/v1/worker/profile-image');
//  //
//  // // var bytes = await rootBundle.load(imageFile.path);
//  // var bytes = await imageFile.readAsBytes();
//  //
//  // var buffer = bytes.buffer;
//  // var imageBytes = buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//  //
//  // var base64Image = base64Encode(imageBytes);
//  //
//  //  var request = new http.MultipartRequest("POST", url);
//  //  request.fields['workerId'] = workerId.toString();
//  //  // request.fields['file'] = "1";
//  //  request.files.add(
//  //      await http.MultipartFile.fromBytes(
//  //    'file',
//  //          await imageFile.readAsBytes(),
//  //  )
//  //  );
//  //
//  //  var res = await request.send().then((response) {
//  //    if (response.statusCode == 204) print("Uploaded!");
//  //  });
//  //
//  //
//  //    if(res == null){
//  //      print(res);
//  //      return true;
//  //    }else{
//  //      return null;
//  //    }
//  //
//
//
//
//
//
//
//
// }