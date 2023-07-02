import 'package:freezed_annotation/freezed_annotation.dart';

import '../../profile/worker_profile.dart';

part 'prefs_state.freezed.dart';

// extension method for easy comparison
extension PrefsGetters on PrefsState {
  bool get isLoading => this is _PrefsStateLoading;
}

@freezed
class PrefsState with _$PrefsState {
  /// initial
  factory PrefsState.initial() = _PrefsStateInitial;

  /// loading
  factory PrefsState.loading() = _PrefsStateLoading;

  /// data
  factory PrefsState.data({required WorkerProfile workerProfile}) =
      _PrefsStateData;

  /// other data different from user
  factory PrefsState.loaded([@Default(0) dynamic data]) = _PrefsStateLoaded;

  /// Error
  factory PrefsState.error([String? error]) = _PrefsStateError;
}
