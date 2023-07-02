// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  _AuthStateInitial initial() {
    return _AuthStateInitial();
  }

  _AuthStateLoading loading() {
    return _AuthStateLoading();
  }

  _AuthStateData data({required WorkerProfile workerProfile}) {
    return _AuthStateData(
      workerProfile: workerProfile,
    );
  }

  _AuthStateLoaded loaded([dynamic data = 0]) {
    return _AuthStateLoaded(
      data,
    );
  }

  _AuthStateError error([String? error]) {
    return _AuthStateError(
      error,
    );
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
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
    required TResult Function(_AuthStateInitial value) initial,
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateData value) data,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitial value)? initial,
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateData value)? data,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class _$AuthStateInitialCopyWith<$Res> {
  factory _$AuthStateInitialCopyWith(
          _AuthStateInitial value, $Res Function(_AuthStateInitial) then) =
      __$AuthStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthStateInitialCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateInitialCopyWith<$Res> {
  __$AuthStateInitialCopyWithImpl(
      _AuthStateInitial _value, $Res Function(_AuthStateInitial) _then)
      : super(_value, (v) => _then(v as _AuthStateInitial));

  @override
  _AuthStateInitial get _value => super._value as _AuthStateInitial;
}

/// @nodoc

class _$_AuthStateInitial implements _AuthStateInitial {
  _$_AuthStateInitial();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthStateInitial);
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
    required TResult Function(_AuthStateInitial value) initial,
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateData value) data,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitial value)? initial,
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateData value)? data,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _AuthStateInitial implements AuthState {
  factory _AuthStateInitial() = _$_AuthStateInitial;
}

/// @nodoc
abstract class _$AuthStateLoadingCopyWith<$Res> {
  factory _$AuthStateLoadingCopyWith(
          _AuthStateLoading value, $Res Function(_AuthStateLoading) then) =
      __$AuthStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthStateLoadingCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateLoadingCopyWith<$Res> {
  __$AuthStateLoadingCopyWithImpl(
      _AuthStateLoading _value, $Res Function(_AuthStateLoading) _then)
      : super(_value, (v) => _then(v as _AuthStateLoading));

  @override
  _AuthStateLoading get _value => super._value as _AuthStateLoading;
}

/// @nodoc

class _$_AuthStateLoading implements _AuthStateLoading {
  _$_AuthStateLoading();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthStateLoading);
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
    required TResult Function(_AuthStateInitial value) initial,
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateData value) data,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitial value)? initial,
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateData value)? data,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AuthStateLoading implements AuthState {
  factory _AuthStateLoading() = _$_AuthStateLoading;
}

/// @nodoc
abstract class _$AuthStateDataCopyWith<$Res> {
  factory _$AuthStateDataCopyWith(
          _AuthStateData value, $Res Function(_AuthStateData) then) =
      __$AuthStateDataCopyWithImpl<$Res>;
  $Res call({WorkerProfile workerProfile});

  $WorkerProfileCopyWith<$Res> get workerProfile;
}

/// @nodoc
class __$AuthStateDataCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateDataCopyWith<$Res> {
  __$AuthStateDataCopyWithImpl(
      _AuthStateData _value, $Res Function(_AuthStateData) _then)
      : super(_value, (v) => _then(v as _AuthStateData));

  @override
  _AuthStateData get _value => super._value as _AuthStateData;

  @override
  $Res call({
    Object? workerProfile = freezed,
  }) {
    return _then(_AuthStateData(
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

class _$_AuthStateData implements _AuthStateData {
  _$_AuthStateData({required this.workerProfile});

  @override
  final WorkerProfile workerProfile;

  @override
  String toString() {
    return 'AuthState.data(workerProfile: $workerProfile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthStateData &&
            (identical(other.workerProfile, workerProfile) ||
                const DeepCollectionEquality()
                    .equals(other.workerProfile, workerProfile)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(workerProfile);

  @JsonKey(ignore: true)
  @override
  _$AuthStateDataCopyWith<_AuthStateData> get copyWith =>
      __$AuthStateDataCopyWithImpl<_AuthStateData>(this, _$identity);

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
    required TResult Function(_AuthStateInitial value) initial,
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateData value) data,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitial value)? initial,
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateData value)? data,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _AuthStateData implements AuthState {
  factory _AuthStateData({required WorkerProfile workerProfile}) =
      _$_AuthStateData;

  WorkerProfile get workerProfile => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthStateDataCopyWith<_AuthStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthStateLoadedCopyWith<$Res> {
  factory _$AuthStateLoadedCopyWith(
          _AuthStateLoaded value, $Res Function(_AuthStateLoaded) then) =
      __$AuthStateLoadedCopyWithImpl<$Res>;
  $Res call({dynamic data});
}

/// @nodoc
class __$AuthStateLoadedCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateLoadedCopyWith<$Res> {
  __$AuthStateLoadedCopyWithImpl(
      _AuthStateLoaded _value, $Res Function(_AuthStateLoaded) _then)
      : super(_value, (v) => _then(v as _AuthStateLoaded));

  @override
  _AuthStateLoaded get _value => super._value as _AuthStateLoaded;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_AuthStateLoaded(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_AuthStateLoaded implements _AuthStateLoaded {
  _$_AuthStateLoaded([this.data = 0]);

  @JsonKey(defaultValue: 0)
  @override
  final dynamic data;

  @override
  String toString() {
    return 'AuthState.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthStateLoaded &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$AuthStateLoadedCopyWith<_AuthStateLoaded> get copyWith =>
      __$AuthStateLoadedCopyWithImpl<_AuthStateLoaded>(this, _$identity);

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
    required TResult Function(_AuthStateInitial value) initial,
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateData value) data,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitial value)? initial,
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateData value)? data,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _AuthStateLoaded implements AuthState {
  factory _AuthStateLoaded([dynamic data]) = _$_AuthStateLoaded;

  dynamic get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthStateLoadedCopyWith<_AuthStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthStateErrorCopyWith<$Res> {
  factory _$AuthStateErrorCopyWith(
          _AuthStateError value, $Res Function(_AuthStateError) then) =
      __$AuthStateErrorCopyWithImpl<$Res>;
  $Res call({String? error});
}

/// @nodoc
class __$AuthStateErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateErrorCopyWith<$Res> {
  __$AuthStateErrorCopyWithImpl(
      _AuthStateError _value, $Res Function(_AuthStateError) _then)
      : super(_value, (v) => _then(v as _AuthStateError));

  @override
  _AuthStateError get _value => super._value as _AuthStateError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_AuthStateError(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AuthStateError implements _AuthStateError {
  _$_AuthStateError([this.error]);

  @override
  final String? error;

  @override
  String toString() {
    return 'AuthState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthStateError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$AuthStateErrorCopyWith<_AuthStateError> get copyWith =>
      __$AuthStateErrorCopyWithImpl<_AuthStateError>(this, _$identity);

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
    required TResult Function(_AuthStateInitial value) initial,
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateData value) data,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitial value)? initial,
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateData value)? data,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AuthStateError implements AuthState {
  factory _AuthStateError([String? error]) = _$_AuthStateError;

  String? get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthStateErrorCopyWith<_AuthStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
