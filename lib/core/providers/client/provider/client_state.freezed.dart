// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'client_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ClientStateTearOff {
  const _$ClientStateTearOff();

  _ClientStateInitial initial() {
    return _ClientStateInitial();
  }

  _ClientStateLoading loading() {
    return _ClientStateLoading();
  }

  _ClientStateData data({required Client client}) {
    return _ClientStateData(
      client: client,
    );
  }

  _ClientStateLoaded loaded([dynamic data = 0]) {
    return _ClientStateLoaded(
      data,
    );
  }

  _ClientStateError error([String? error]) {
    return _ClientStateError(
      error,
    );
  }
}

/// @nodoc
const $ClientState = _$ClientStateTearOff();

/// @nodoc
mixin _$ClientState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Client client) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Client client)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ClientStateInitial value) initial,
    required TResult Function(_ClientStateLoading value) loading,
    required TResult Function(_ClientStateData value) data,
    required TResult Function(_ClientStateLoaded value) loaded,
    required TResult Function(_ClientStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClientStateInitial value)? initial,
    TResult Function(_ClientStateLoading value)? loading,
    TResult Function(_ClientStateData value)? data,
    TResult Function(_ClientStateLoaded value)? loaded,
    TResult Function(_ClientStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientStateCopyWith<$Res> {
  factory $ClientStateCopyWith(
          ClientState value, $Res Function(ClientState) then) =
      _$ClientStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ClientStateCopyWithImpl<$Res> implements $ClientStateCopyWith<$Res> {
  _$ClientStateCopyWithImpl(this._value, this._then);

  final ClientState _value;
  // ignore: unused_field
  final $Res Function(ClientState) _then;
}

/// @nodoc
abstract class _$ClientStateInitialCopyWith<$Res> {
  factory _$ClientStateInitialCopyWith(_ClientStateInitial value,
          $Res Function(_ClientStateInitial) then) =
      __$ClientStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$ClientStateInitialCopyWithImpl<$Res>
    extends _$ClientStateCopyWithImpl<$Res>
    implements _$ClientStateInitialCopyWith<$Res> {
  __$ClientStateInitialCopyWithImpl(
      _ClientStateInitial _value, $Res Function(_ClientStateInitial) _then)
      : super(_value, (v) => _then(v as _ClientStateInitial));

  @override
  _ClientStateInitial get _value => super._value as _ClientStateInitial;
}

/// @nodoc

class _$_ClientStateInitial implements _ClientStateInitial {
  _$_ClientStateInitial();

  @override
  String toString() {
    return 'ClientState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _ClientStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Client client) data,
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
    TResult Function(Client client)? data,
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
    required TResult Function(_ClientStateInitial value) initial,
    required TResult Function(_ClientStateLoading value) loading,
    required TResult Function(_ClientStateData value) data,
    required TResult Function(_ClientStateLoaded value) loaded,
    required TResult Function(_ClientStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClientStateInitial value)? initial,
    TResult Function(_ClientStateLoading value)? loading,
    TResult Function(_ClientStateData value)? data,
    TResult Function(_ClientStateLoaded value)? loaded,
    TResult Function(_ClientStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ClientStateInitial implements ClientState {
  factory _ClientStateInitial() = _$_ClientStateInitial;
}

/// @nodoc
abstract class _$ClientStateLoadingCopyWith<$Res> {
  factory _$ClientStateLoadingCopyWith(_ClientStateLoading value,
          $Res Function(_ClientStateLoading) then) =
      __$ClientStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$ClientStateLoadingCopyWithImpl<$Res>
    extends _$ClientStateCopyWithImpl<$Res>
    implements _$ClientStateLoadingCopyWith<$Res> {
  __$ClientStateLoadingCopyWithImpl(
      _ClientStateLoading _value, $Res Function(_ClientStateLoading) _then)
      : super(_value, (v) => _then(v as _ClientStateLoading));

  @override
  _ClientStateLoading get _value => super._value as _ClientStateLoading;
}

/// @nodoc

class _$_ClientStateLoading implements _ClientStateLoading {
  _$_ClientStateLoading();

  @override
  String toString() {
    return 'ClientState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _ClientStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Client client) data,
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
    TResult Function(Client client)? data,
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
    required TResult Function(_ClientStateInitial value) initial,
    required TResult Function(_ClientStateLoading value) loading,
    required TResult Function(_ClientStateData value) data,
    required TResult Function(_ClientStateLoaded value) loaded,
    required TResult Function(_ClientStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClientStateInitial value)? initial,
    TResult Function(_ClientStateLoading value)? loading,
    TResult Function(_ClientStateData value)? data,
    TResult Function(_ClientStateLoaded value)? loaded,
    TResult Function(_ClientStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ClientStateLoading implements ClientState {
  factory _ClientStateLoading() = _$_ClientStateLoading;
}

/// @nodoc
abstract class _$ClientStateDataCopyWith<$Res> {
  factory _$ClientStateDataCopyWith(
          _ClientStateData value, $Res Function(_ClientStateData) then) =
      __$ClientStateDataCopyWithImpl<$Res>;
  $Res call({Client client});
}

/// @nodoc
class __$ClientStateDataCopyWithImpl<$Res>
    extends _$ClientStateCopyWithImpl<$Res>
    implements _$ClientStateDataCopyWith<$Res> {
  __$ClientStateDataCopyWithImpl(
      _ClientStateData _value, $Res Function(_ClientStateData) _then)
      : super(_value, (v) => _then(v as _ClientStateData));

  @override
  _ClientStateData get _value => super._value as _ClientStateData;

  @override
  $Res call({
    Object? client = freezed,
  }) {
    return _then(_ClientStateData(
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as Client,
    ));
  }
}

/// @nodoc

class _$_ClientStateData implements _ClientStateData {
  _$_ClientStateData({required this.client});

  @override
  final Client client;

  @override
  String toString() {
    return 'ClientState.data(client: $client)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ClientStateData &&
            (identical(other.client, client) ||
                const DeepCollectionEquality().equals(other.client, client)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(client);

  @JsonKey(ignore: true)
  @override
  _$ClientStateDataCopyWith<_ClientStateData> get copyWith =>
      __$ClientStateDataCopyWithImpl<_ClientStateData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Client client) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) {
    return data(client);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Client client)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(client);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ClientStateInitial value) initial,
    required TResult Function(_ClientStateLoading value) loading,
    required TResult Function(_ClientStateData value) data,
    required TResult Function(_ClientStateLoaded value) loaded,
    required TResult Function(_ClientStateError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClientStateInitial value)? initial,
    TResult Function(_ClientStateLoading value)? loading,
    TResult Function(_ClientStateData value)? data,
    TResult Function(_ClientStateLoaded value)? loaded,
    TResult Function(_ClientStateError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _ClientStateData implements ClientState {
  factory _ClientStateData({required Client client}) = _$_ClientStateData;

  Client get client => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ClientStateDataCopyWith<_ClientStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ClientStateLoadedCopyWith<$Res> {
  factory _$ClientStateLoadedCopyWith(
          _ClientStateLoaded value, $Res Function(_ClientStateLoaded) then) =
      __$ClientStateLoadedCopyWithImpl<$Res>;
  $Res call({dynamic data});
}

/// @nodoc
class __$ClientStateLoadedCopyWithImpl<$Res>
    extends _$ClientStateCopyWithImpl<$Res>
    implements _$ClientStateLoadedCopyWith<$Res> {
  __$ClientStateLoadedCopyWithImpl(
      _ClientStateLoaded _value, $Res Function(_ClientStateLoaded) _then)
      : super(_value, (v) => _then(v as _ClientStateLoaded));

  @override
  _ClientStateLoaded get _value => super._value as _ClientStateLoaded;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_ClientStateLoaded(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_ClientStateLoaded implements _ClientStateLoaded {
  _$_ClientStateLoaded([this.data = 0]);

  @JsonKey(defaultValue: 0)
  @override
  final dynamic data;

  @override
  String toString() {
    return 'ClientState.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ClientStateLoaded &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$ClientStateLoadedCopyWith<_ClientStateLoaded> get copyWith =>
      __$ClientStateLoadedCopyWithImpl<_ClientStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Client client) data,
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
    TResult Function(Client client)? data,
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
    required TResult Function(_ClientStateInitial value) initial,
    required TResult Function(_ClientStateLoading value) loading,
    required TResult Function(_ClientStateData value) data,
    required TResult Function(_ClientStateLoaded value) loaded,
    required TResult Function(_ClientStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClientStateInitial value)? initial,
    TResult Function(_ClientStateLoading value)? loading,
    TResult Function(_ClientStateData value)? data,
    TResult Function(_ClientStateLoaded value)? loaded,
    TResult Function(_ClientStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _ClientStateLoaded implements ClientState {
  factory _ClientStateLoaded([dynamic data]) = _$_ClientStateLoaded;

  dynamic get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ClientStateLoadedCopyWith<_ClientStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ClientStateErrorCopyWith<$Res> {
  factory _$ClientStateErrorCopyWith(
          _ClientStateError value, $Res Function(_ClientStateError) then) =
      __$ClientStateErrorCopyWithImpl<$Res>;
  $Res call({String? error});
}

/// @nodoc
class __$ClientStateErrorCopyWithImpl<$Res>
    extends _$ClientStateCopyWithImpl<$Res>
    implements _$ClientStateErrorCopyWith<$Res> {
  __$ClientStateErrorCopyWithImpl(
      _ClientStateError _value, $Res Function(_ClientStateError) _then)
      : super(_value, (v) => _then(v as _ClientStateError));

  @override
  _ClientStateError get _value => super._value as _ClientStateError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_ClientStateError(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ClientStateError implements _ClientStateError {
  _$_ClientStateError([this.error]);

  @override
  final String? error;

  @override
  String toString() {
    return 'ClientState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ClientStateError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$ClientStateErrorCopyWith<_ClientStateError> get copyWith =>
      __$ClientStateErrorCopyWithImpl<_ClientStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Client client) data,
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
    TResult Function(Client client)? data,
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
    required TResult Function(_ClientStateInitial value) initial,
    required TResult Function(_ClientStateLoading value) loading,
    required TResult Function(_ClientStateData value) data,
    required TResult Function(_ClientStateLoaded value) loaded,
    required TResult Function(_ClientStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClientStateInitial value)? initial,
    TResult Function(_ClientStateLoading value)? loading,
    TResult Function(_ClientStateData value)? data,
    TResult Function(_ClientStateLoaded value)? loaded,
    TResult Function(_ClientStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ClientStateError implements ClientState {
  factory _ClientStateError([String? error]) = _$_ClientStateError;

  String? get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ClientStateErrorCopyWith<_ClientStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
