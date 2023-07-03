import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_admin_dashboard/core/models/Business.dart';


part 'business_state.freezed.dart';

// extension method for easy comparison
extension BusinessGetters on BusinessState {
  bool get isLoading => this is _BusinessStateLoading;
  bool get isError=> this is _BusinessStateError;
}

@freezed
class BusinessState with _$BusinessState {
  /// initial
  factory BusinessState.initial() = _BusinessStateInitial;

  /// loading
  factory BusinessState.loading() = _BusinessStateLoading;

  /// data
  factory BusinessState.data({required Business business}) =
      _BusinessStateData;

  /// other data different from business
  factory BusinessState.loaded([@Default(0) dynamic data]) = _BusinessStateLoaded;

  /// Error
  factory BusinessState.error([String? error]) = _BusinessStateError;
}
