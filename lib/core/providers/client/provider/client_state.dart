import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_admin_dashboard/core/models/Client.dart';


part 'client_state.freezed.dart';

// extension method for easy comparison
extension ClientGetters on ClientState {
  bool get isLoading => this is _ClientStateLoading;
  bool get isError=> this is _ClientStateError;
}

@freezed
class ClientState with _$ClientState {
  /// initial
  factory ClientState.initial() = _ClientStateInitial;

  /// loading
  factory ClientState.loading() = _ClientStateLoading;

  /// data
  factory ClientState.data({required Client client}) =
      _ClientStateData;

  /// other data different from client
  factory ClientState.loaded([@Default(0) dynamic data]) = _ClientStateLoaded;

  /// Error
  factory ClientState.error([String? error]) = _ClientStateError;
}
