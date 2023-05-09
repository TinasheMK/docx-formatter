// //part of 'prefs_provider.dart';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:work_link/src/features/prefs/data/prefs_repository.dart';
// // import 'package:work_link/src/models/custom_exception.dart';
// // import 'package:work_link/src/models/profile/worker_profile.dart';
//
// import '../../custom_exception.dart';
// import '../../profile/worker_profile.dart';
// import '../data/prefs_repository.dart';
// import 'prefs_state.dart';
//
// class PrefsNotifier extends StateNotifier<PrefsState> {
//   PrefsNotifier({
//     required ISharedPreferencesService prefsRepository,
//   })  : _prefsRepository = prefsRepository,
//         super(PrefsState.initial());
//
//   final ISharedPreferencesService _prefsRepository;
//
//   void resetState() {
//     state = PrefsState.initial();
//   }
//
//   Future<void> loginUser(Map<String, dynamic>? credentials, {bool rememberMe: false}) async {
//     state = PrefsState.loading();
//
//     try {
//       final _client = await _prefsRepository.login(credentials, rememberMe: rememberMe);
//
//       state = PrefsState.data(workerProfile: _client);
//     }
//
//     // error
//     catch (e) {
//       if (e is CustomException) {
//         state = PrefsState.error(e.message);
//       } else
//         state = PrefsState.error(e.toString());
//     }
//   }
//
//   Future<void> registerUser(Map? payload) async {
//     state = PrefsState.loading();
//
//     try {
//       await _prefsRepository.register(payload);
//
//       Map<String, dynamic>? _creds = {
//         "username": payload?['username'],
//         "password": payload?['password'],
//       };
//
//       final WorkerProfile user = await _prefsRepository.login(_creds);
//
//       state = PrefsState.data(workerProfile: user);
//     }
//
//     // error
//     catch (e) {
//       state = PrefsState.error(e.toString());
//     }
//   }
//
//   Future<void> resetPwd(String email1) async {
//     state = PrefsState.loading();
//
//     try {
//       final user = await _prefsRepository.forgotPaswd(email1);
//       print(user['message']);
//
//       // added ok
//
//       state = PrefsState.loaded(user['message']);
//       // return true;
//     }
//
//     // error
//     catch (e) {
//       state = PrefsState.error(e.toString());
//     }
//   }
// }
