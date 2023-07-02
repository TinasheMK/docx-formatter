// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of '../../../core/providers/auth/provider/prefs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PrefsStateTearOff {
  const _$PrefsStateTearOff();

  _PrefsStateInitial initial() {
    return _PrefsStateInitial();
  }

  _PrefsStateLoading loading() {
    return _PrefsStateLoading();
  }

  _PrefsStateData data({required WorkerProfile workerProfile}) {
    return _PrefsStateData(
      workerProfile: workerProfile,
    );
  }

  _PrefsStateLoaded loaded([dynamic data = 0]) {
    return _PrefsStateLoaded(
      data,
    );
  }

  _PrefsStateError error([String? error]) {
    return _PrefsStateError(
      error,
    );
  }
}

/// @nodoc
const $PrefsState = _$PrefsStateTearOff();

/// @nodoc
mixin _$PrefsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WorkerProfile workerProfile) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WorkerProfile workerProfile)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrefsStateInitial value) initial,
    required TResult Function(_PrefsStateLoading value) loading,
    required TResult Function(_PrefsStateData value) data,
    required TResult Function(_PrefsStateLoaded value) loaded,
    required TResult Function(_PrefsStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrefsStateInitial value)? initial,
    TResult Function(_PrefsStateLoading value)? loading,
    TResult Function(_PrefsStateData value)? data,
    TResult Function(_PrefsStateLoaded value)? loaded,
    TResult Function(_PrefsStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrefsStateCopyWith<$Res> {
  factory $PrefsStateCopyWith(
          PrefsState value, $Res Function(PrefsState) then) =
      _$PrefsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PrefsStateCopyWithImpl<$Res> implements $PrefsStateCopyWith<$Res> {
  _$PrefsStateCopyWithImpl(this._value, this._then);

  final PrefsState _value;
  // ignore: unused_field
  final $Res Function(PrefsState) _then;
}

/// @nodoc
abstract class _$PrefsStateInitialCopyWith<$Res> {
  factory _$PrefsStateInitialCopyWith(
          _PrefsStateInitial value, $Res Function(_PrefsStateInitial) then) =
      __$PrefsStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$PrefsStateInitialCopyWithImpl<$Res>
    extends _$PrefsStateCopyWithImpl<$Res>
    implements _$PrefsStateInitialCopyWith<$Res> {
  __$PrefsStateInitialCopyWithImpl(
      _PrefsStateInitial _value, $Res Function(_PrefsStateInitial) _then)
      : super(_value, (v) => _then(v as _PrefsStateInitial));

  @override
  _PrefsStateInitial get _value => super._value as _PrefsStateInitial;
}

/// @nodoc

class _$_PrefsStateInitial implements _PrefsStateInitial {
  _$_PrefsStateInitial();

  @override
  String toString() {
    return 'PrefsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _PrefsStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WorkerProfile workerProfile) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WorkerProfile workerProfile)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrefsStateInitial value) initial,
    required TResult Function(_PrefsStateLoading value) loading,
    required TResult Function(_PrefsStateData value) data,
    required TResult Function(_PrefsStateLoaded value) loaded,
    required TResult Function(_PrefsStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrefsStateInitial value)? initial,
    TResult Function(_PrefsStateLoading value)? loading,
    TResult Function(_PrefsStateData value)? data,
    TResult Function(_PrefsStateLoaded value)? loaded,
    TResult Function(_PrefsStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _PrefsStateInitial implements PrefsState {
  factory _PrefsStateInitial() = _$_PrefsStateInitial;
}

/// @nodoc
abstract class _$PrefsStateLoadingCopyWith<$Res> {
  factory _$PrefsStateLoadingCopyWith(
          _PrefsStateLoading value, $Res Function(_PrefsStateLoading) then) =
      __$PrefsStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$PrefsStateLoadingCopyWithImpl<$Res>
    extends _$PrefsStateCopyWithImpl<$Res>
    implements _$PrefsStateLoadingCopyWith<$Res> {
  __$PrefsStateLoadingCopyWithImpl(
      _PrefsStateLoading _value, $Res Function(_PrefsStateLoading) _then)
      : super(_value, (v) => _then(v as _PrefsStateLoading));

  @override
  _PrefsStateLoading get _value => super._value as _PrefsStateLoading;
}

/// @nodoc

class _$_PrefsStateLoading implements _PrefsStateLoading {
  _$_PrefsStateLoading();

  @override
  String toString() {
    return 'PrefsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _PrefsStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WorkerProfile workerProfile) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WorkerProfile workerProfile)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrefsStateInitial value) initial,
    required TResult Function(_PrefsStateLoading value) loading,
    required TResult Function(_PrefsStateData value) data,
    required TResult Function(_PrefsStateLoaded value) loaded,
    required TResult Function(_PrefsStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrefsStateInitial value)? initial,
    TResult Function(_PrefsStateLoading value)? loading,
    TResult Function(_PrefsStateData value)? data,
    TResult Function(_PrefsStateLoaded value)? loaded,
    TResult Function(_PrefsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _PrefsStateLoading implements PrefsState {
  factory _PrefsStateLoading() = _$_PrefsStateLoading;
}

/// @nodoc
abstract class _$PrefsStateDataCopyWith<$Res> {
  factory _$PrefsStateDataCopyWith(
          _PrefsStateData value, $Res Function(_PrefsStateData) then) =
      __$PrefsStateDataCopyWithImpl<$Res>;
  $Res call({WorkerProfile workerProfile});

  $WorkerProfileCopyWith<$Res> get workerProfile;
}

/// @nodoc
class __$PrefsStateDataCopyWithImpl<$Res> extends _$PrefsStateCopyWithImpl<$Res>
    implements _$PrefsStateDataCopyWith<$Res> {
  __$PrefsStateDataCopyWithImpl(
      _PrefsStateData _value, $Res Function(_PrefsStateData) _then)
      : super(_value, (v) => _then(v as _PrefsStateData));

  @override
  _PrefsStateData get _value => super._value as _PrefsStateData;

  @override
  $Res call({
    Object? workerProfile = freezed,
  }) {
    return _then(_PrefsStateData(
      workerProfile: workerProfile == freezed
          ? _value.workerProfile
          : workerProfile // ignore: cast_nullable_to_non_nullable
              as WorkerProfile,
    ));
  }

  @override
  $WorkerProfileCopyWith<$Res> get workerProfile {
    return $WorkerProfileCopyWith<$Res>(_value.workerProfile, (value) {
      return _then(_value.copyWith(workerProfile: value));
    });
  }
}

/// @nodoc

class _$_PrefsStateData implements _PrefsStateData {
  _$_PrefsStateData({required this.workerProfile});

  @override
  final WorkerProfile workerProfile;

  @override
  String toString() {
    return 'PrefsState.data(workerProfile: $workerProfile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PrefsStateData &&
            (identical(other.workerProfile, workerProfile) ||
                const DeepCollectionEquality()
                    .equals(other.workerProfile, workerProfile)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(workerProfile);

  @JsonKey(ignore: true)
  @override
  _$PrefsStateDataCopyWith<_PrefsStateData> get copyWith =>
      __$PrefsStateDataCopyWithImpl<_PrefsStateData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WorkerProfile workerProfile) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) {
    return data(workerProfile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WorkerProfile workerProfile)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(workerProfile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrefsStateInitial value) initial,
    required TResult Function(_PrefsStateLoading value) loading,
    required TResult Function(_PrefsStateData value) data,
    required TResult Function(_PrefsStateLoaded value) loaded,
    required TResult Function(_PrefsStateError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrefsStateInitial value)? initial,
    TResult Function(_PrefsStateLoading value)? loading,
    TResult Function(_PrefsStateData value)? data,
    TResult Function(_PrefsStateLoaded value)? loaded,
    TResult Function(_PrefsStateError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _PrefsStateData implements PrefsState {
  factory _PrefsStateData({required WorkerProfile workerProfile}) =
      _$_PrefsStateData;

  WorkerProfile get workerProfile => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$PrefsStateDataCopyWith<_PrefsStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$PrefsStateLoadedCopyWith<$Res> {
  factory _$PrefsStateLoadedCopyWith(
          _PrefsStateLoaded value, $Res Function(_PrefsStateLoaded) then) =
      __$PrefsStateLoadedCopyWithImpl<$Res>;
  $Res call({dynamic data});
}

/// @nodoc
class __$PrefsStateLoadedCopyWithImpl<$Res>
    extends _$PrefsStateCopyWithImpl<$Res>
    implements _$PrefsStateLoadedCopyWith<$Res> {
  __$PrefsStateLoadedCopyWithImpl(
      _PrefsStateLoaded _value, $Res Function(_PrefsStateLoaded) _then)
      : super(_value, (v) => _then(v as _PrefsStateLoaded));

  @override
  _PrefsStateLoaded get _value => super._value as _PrefsStateLoaded;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_PrefsStateLoaded(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_PrefsStateLoaded implements _PrefsStateLoaded {
  _$_PrefsStateLoaded([this.data = 0]);

  @JsonKey(defaultValue: 0)
  @override
  final dynamic data;

  @override
  String toString() {
    return 'PrefsState.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PrefsStateLoaded &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$PrefsStateLoadedCopyWith<_PrefsStateLoaded> get copyWith =>
      __$PrefsStateLoadedCopyWithImpl<_PrefsStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WorkerProfile workerProfile) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) {
    return loaded(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WorkerProfile workerProfile)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrefsStateInitial value) initial,
    required TResult Function(_PrefsStateLoading value) loading,
    required TResult Function(_PrefsStateData value) data,
    required TResult Function(_PrefsStateLoaded value) loaded,
    required TResult Function(_PrefsStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrefsStateInitial value)? initial,
    TResult Function(_PrefsStateLoading value)? loading,
    TResult Function(_PrefsStateData value)? data,
    TResult Function(_PrefsStateLoaded value)? loaded,
    TResult Function(_PrefsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _PrefsStateLoaded implements PrefsState {
  factory _PrefsStateLoaded([dynamic data]) = _$_PrefsStateLoaded;

  dynamic get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$PrefsStateLoadedCopyWith<_PrefsStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$PrefsStateErrorCopyWith<$Res> {
  factory _$PrefsStateErrorCopyWith(
          _PrefsStateError value, $Res Function(_PrefsStateError) then) =
      __$PrefsStateErrorCopyWithImpl<$Res>;
  $Res call({String? error});
}

/// @nodoc
class __$PrefsStateErrorCopyWithImpl<$Res>
    extends _$PrefsStateCopyWithImpl<$Res>
    implements _$PrefsStateErrorCopyWith<$Res> {
  __$PrefsStateErrorCopyWithImpl(
      _PrefsStateError _value, $Res Function(_PrefsStateError) _then)
      : super(_value, (v) => _then(v as _PrefsStateError));

  @override
  _PrefsStateError get _value => super._value as _PrefsStateError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_PrefsStateError(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_PrefsStateError implements _PrefsStateError {
  _$_PrefsStateError([this.error]);

  @override
  final String? error;

  @override
  String toString() {
    return 'PrefsState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PrefsStateError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$PrefsStateErrorCopyWith<_PrefsStateError> get copyWith =>
      __$PrefsStateErrorCopyWithImpl<_PrefsStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WorkerProfile workerProfile) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WorkerProfile workerProfile)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrefsStateInitial value) initial,
    required TResult Function(_PrefsStateLoading value) loading,
    required TResult Function(_PrefsStateData value) data,
    required TResult Function(_PrefsStateLoaded value) loaded,
    required TResult Function(_PrefsStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrefsStateInitial value)? initial,
    TResult Function(_PrefsStateLoading value)? loading,
    TResult Function(_PrefsStateData value)? data,
    TResult Function(_PrefsStateLoaded value)? loaded,
    TResult Function(_PrefsStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _PrefsStateError implements PrefsState {
  factory _PrefsStateError([String? error]) = _$_PrefsStateError;

  String? get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$PrefsStateErrorCopyWith<_PrefsStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
