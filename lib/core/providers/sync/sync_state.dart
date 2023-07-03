import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_admin_dashboard/core/models/Sync.dart';


part 'sync_state.freezed.dart';

// extension method for easy comparison
extension SyncGetters on SyncState {
  bool get isLoading => this is _SyncStateLoading;
  bool get isError=> this is _SyncStateError;
}

@freezed
class SyncState with _$SyncState {
  /// initial
  factory SyncState.initial() = _SyncStateInitial;

  /// loading
  factory SyncState.loading() = _SyncStateLoading;

  /// data
  factory SyncState.data({required Sync sync}) =
      _SyncStateData;

  /// other data different from sync
  factory SyncState.loaded([@Default(0) dynamic data]) = _SyncStateLoaded;

  /// Error
  factory SyncState.error([String? error]) = _SyncStateError;
}
