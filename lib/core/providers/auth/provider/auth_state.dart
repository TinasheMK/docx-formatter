import 'package:freezed_annotation/freezed_annotation.dart';

import '../../profile/worker_profile.dart';

part 'auth_state.freezed.dart';

// extension method for easy comparison
extension AuthGetters on AuthState {
  bool get isLoading => this is _AuthStateLoading;
}

@freezed
class AuthState with _$AuthState {
  /// initial
  factory AuthState.initial() = _AuthStateInitial;

  /// loading
  factory AuthState.loading() = _AuthStateLoading;

  /// data
  factory AuthState.data({required WorkerProfile workerProfile}) =
      _AuthStateData;

  /// other data different from user
  factory AuthState.loaded([@Default(0) dynamic data]) = _AuthStateLoaded;

  /// Error
  factory AuthState.error([String? error]) = _AuthStateError;
}
