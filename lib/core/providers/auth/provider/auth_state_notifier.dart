//part of 'auth_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:work_link/src/features/auth/data/auth_repository.dart';
// import 'package:work_link/src/models/custom_exception.dart';
// import 'package:work_link/src/models/profile/worker_profile.dart';

import '../../../../providers/custom_exception.dart';
import '../../profile/worker_profile.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthState.initial());

  final IAuthRepository _authRepository;

  void resetState() {
    state = AuthState.initial();
  }

  Future<void> loginUser(Map<String, dynamic>? credentials, {bool rememberMe: false}) async {
    state = AuthState.loading();

    try {
      final _client = await _authRepository.login(credentials, rememberMe: rememberMe);

      state = AuthState.data(workerProfile: _client);
    }

    // error
    catch (e) {
      if (e is CustomException) {
        state = AuthState.error(e.message);
      } else
        state = AuthState.error(e.toString());
    }
  }

  Future<void> registerUser(Map? payload) async {
    state = AuthState.loading();

    print(payload);
    try {
      final WorkerProfile user  = await _authRepository.register(payload);

      Map<String, dynamic>? _creds = {
        "email": payload?['email'],
        "password": payload?['password'],
        "firstName": payload?['firstName'],
        "lastName": payload?['lastName'],
      };

      // final WorkerProfile user = await _authRepository.login(_creds);

      state = AuthState.data(workerProfile: user);
    }

    // error
    catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> resetPwd(String email1) async {
    state = AuthState.loading();

    try {
      final user = await _authRepository.forgotPaswd(email1);
      print(user['message']);

      // added ok

      state = AuthState.loaded(user['message']);
      // return true;
    }

    // error
    catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
