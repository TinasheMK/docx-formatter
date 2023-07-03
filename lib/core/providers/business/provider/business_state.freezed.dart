// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'business_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BusinessStateTearOff {
  const _$BusinessStateTearOff();

  _BusinessStateInitial initial() {
    return _BusinessStateInitial();
  }

  _BusinessStateLoading loading() {
    return _BusinessStateLoading();
  }

  _BusinessStateData data({required Business business}) {
    return _BusinessStateData(
      business: business,
    );
  }

  _BusinessStateLoaded loaded([dynamic data = 0]) {
    return _BusinessStateLoaded(
      data,
    );
  }

  _BusinessStateError error([String? error]) {
    return _BusinessStateError(
      error,
    );
  }
}

/// @nodoc
const $BusinessState = _$BusinessStateTearOff();

/// @nodoc
mixin _$BusinessState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Business business) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Business business)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BusinessStateInitial value) initial,
    required TResult Function(_BusinessStateLoading value) loading,
    required TResult Function(_BusinessStateData value) data,
    required TResult Function(_BusinessStateLoaded value) loaded,
    required TResult Function(_BusinessStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BusinessStateInitial value)? initial,
    TResult Function(_BusinessStateLoading value)? loading,
    TResult Function(_BusinessStateData value)? data,
    TResult Function(_BusinessStateLoaded value)? loaded,
    TResult Function(_BusinessStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessStateCopyWith<$Res> {
  factory $BusinessStateCopyWith(
          BusinessState value, $Res Function(BusinessState) then) =
      _$BusinessStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$BusinessStateCopyWithImpl<$Res> implements $BusinessStateCopyWith<$Res> {
  _$BusinessStateCopyWithImpl(this._value, this._then);

  final BusinessState _value;
  // ignore: unused_field
  final $Res Function(BusinessState) _then;
}

/// @nodoc
abstract class _$BusinessStateInitialCopyWith<$Res> {
  factory _$BusinessStateInitialCopyWith(_BusinessStateInitial value,
          $Res Function(_BusinessStateInitial) then) =
      __$BusinessStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$BusinessStateInitialCopyWithImpl<$Res>
    extends _$BusinessStateCopyWithImpl<$Res>
    implements _$BusinessStateInitialCopyWith<$Res> {
  __$BusinessStateInitialCopyWithImpl(
      _BusinessStateInitial _value, $Res Function(_BusinessStateInitial) _then)
      : super(_value, (v) => _then(v as _BusinessStateInitial));

  @override
  _BusinessStateInitial get _value => super._value as _BusinessStateInitial;
}

/// @nodoc

class _$_BusinessStateInitial implements _BusinessStateInitial {
  _$_BusinessStateInitial();

  @override
  String toString() {
    return 'BusinessState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _BusinessStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Business business) data,
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
    TResult Function(Business business)? data,
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
    required TResult Function(_BusinessStateInitial value) initial,
    required TResult Function(_BusinessStateLoading value) loading,
    required TResult Function(_BusinessStateData value) data,
    required TResult Function(_BusinessStateLoaded value) loaded,
    required TResult Function(_BusinessStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BusinessStateInitial value)? initial,
    TResult Function(_BusinessStateLoading value)? loading,
    TResult Function(_BusinessStateData value)? data,
    TResult Function(_BusinessStateLoaded value)? loaded,
    TResult Function(_BusinessStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _BusinessStateInitial implements BusinessState {
  factory _BusinessStateInitial() = _$_BusinessStateInitial;
}

/// @nodoc
abstract class _$BusinessStateLoadingCopyWith<$Res> {
  factory _$BusinessStateLoadingCopyWith(_BusinessStateLoading value,
          $Res Function(_BusinessStateLoading) then) =
      __$BusinessStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$BusinessStateLoadingCopyWithImpl<$Res>
    extends _$BusinessStateCopyWithImpl<$Res>
    implements _$BusinessStateLoadingCopyWith<$Res> {
  __$BusinessStateLoadingCopyWithImpl(
      _BusinessStateLoading _value, $Res Function(_BusinessStateLoading) _then)
      : super(_value, (v) => _then(v as _BusinessStateLoading));

  @override
  _BusinessStateLoading get _value => super._value as _BusinessStateLoading;
}

/// @nodoc

class _$_BusinessStateLoading implements _BusinessStateLoading {
  _$_BusinessStateLoading();

  @override
  String toString() {
    return 'BusinessState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _BusinessStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Business business) data,
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
    TResult Function(Business business)? data,
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
    required TResult Function(_BusinessStateInitial value) initial,
    required TResult Function(_BusinessStateLoading value) loading,
    required TResult Function(_BusinessStateData value) data,
    required TResult Function(_BusinessStateLoaded value) loaded,
    required TResult Function(_BusinessStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BusinessStateInitial value)? initial,
    TResult Function(_BusinessStateLoading value)? loading,
    TResult Function(_BusinessStateData value)? data,
    TResult Function(_BusinessStateLoaded value)? loaded,
    TResult Function(_BusinessStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _BusinessStateLoading implements BusinessState {
  factory _BusinessStateLoading() = _$_BusinessStateLoading;
}

/// @nodoc
abstract class _$BusinessStateDataCopyWith<$Res> {
  factory _$BusinessStateDataCopyWith(
          _BusinessStateData value, $Res Function(_BusinessStateData) then) =
      __$BusinessStateDataCopyWithImpl<$Res>;
  $Res call({Business business});
}

/// @nodoc
class __$BusinessStateDataCopyWithImpl<$Res>
    extends _$BusinessStateCopyWithImpl<$Res>
    implements _$BusinessStateDataCopyWith<$Res> {
  __$BusinessStateDataCopyWithImpl(
      _BusinessStateData _value, $Res Function(_BusinessStateData) _then)
      : super(_value, (v) => _then(v as _BusinessStateData));

  @override
  _BusinessStateData get _value => super._value as _BusinessStateData;

  @override
  $Res call({
    Object? business = freezed,
  }) {
    return _then(_BusinessStateData(
      business: business == freezed
          ? _value.business
          : business // ignore: cast_nullable_to_non_nullable
              as Business,
    ));
  }
}

/// @nodoc

class _$_BusinessStateData implements _BusinessStateData {
  _$_BusinessStateData({required this.business});

  @override
  final Business business;

  @override
  String toString() {
    return 'BusinessState.data(business: $business)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusinessStateData &&
            (identical(other.business, business) ||
                const DeepCollectionEquality().equals(other.business, business)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(business);

  @JsonKey(ignore: true)
  @override
  _$BusinessStateDataCopyWith<_BusinessStateData> get copyWith =>
      __$BusinessStateDataCopyWithImpl<_BusinessStateData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Business business) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) {
    return data(business);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Business business)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(business);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BusinessStateInitial value) initial,
    required TResult Function(_BusinessStateLoading value) loading,
    required TResult Function(_BusinessStateData value) data,
    required TResult Function(_BusinessStateLoaded value) loaded,
    required TResult Function(_BusinessStateError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BusinessStateInitial value)? initial,
    TResult Function(_BusinessStateLoading value)? loading,
    TResult Function(_BusinessStateData value)? data,
    TResult Function(_BusinessStateLoaded value)? loaded,
    TResult Function(_BusinessStateError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _BusinessStateData implements BusinessState {
  factory _BusinessStateData({required Business business}) = _$_BusinessStateData;

  Business get business => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$BusinessStateDataCopyWith<_BusinessStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BusinessStateLoadedCopyWith<$Res> {
  factory _$BusinessStateLoadedCopyWith(
          _BusinessStateLoaded value, $Res Function(_BusinessStateLoaded) then) =
      __$BusinessStateLoadedCopyWithImpl<$Res>;
  $Res call({dynamic data});
}

/// @nodoc
class __$BusinessStateLoadedCopyWithImpl<$Res>
    extends _$BusinessStateCopyWithImpl<$Res>
    implements _$BusinessStateLoadedCopyWith<$Res> {
  __$BusinessStateLoadedCopyWithImpl(
      _BusinessStateLoaded _value, $Res Function(_BusinessStateLoaded) _then)
      : super(_value, (v) => _then(v as _BusinessStateLoaded));

  @override
  _BusinessStateLoaded get _value => super._value as _BusinessStateLoaded;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_BusinessStateLoaded(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_BusinessStateLoaded implements _BusinessStateLoaded {
  _$_BusinessStateLoaded([this.data = 0]);

  @JsonKey(defaultValue: 0)
  @override
  final dynamic data;

  @override
  String toString() {
    return 'BusinessState.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusinessStateLoaded &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$BusinessStateLoadedCopyWith<_BusinessStateLoaded> get copyWith =>
      __$BusinessStateLoadedCopyWithImpl<_BusinessStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Business business) data,
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
    TResult Function(Business business)? data,
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
    required TResult Function(_BusinessStateInitial value) initial,
    required TResult Function(_BusinessStateLoading value) loading,
    required TResult Function(_BusinessStateData value) data,
    required TResult Function(_BusinessStateLoaded value) loaded,
    required TResult Function(_BusinessStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BusinessStateInitial value)? initial,
    TResult Function(_BusinessStateLoading value)? loading,
    TResult Function(_BusinessStateData value)? data,
    TResult Function(_BusinessStateLoaded value)? loaded,
    TResult Function(_BusinessStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _BusinessStateLoaded implements BusinessState {
  factory _BusinessStateLoaded([dynamic data]) = _$_BusinessStateLoaded;

  dynamic get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$BusinessStateLoadedCopyWith<_BusinessStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BusinessStateErrorCopyWith<$Res> {
  factory _$BusinessStateErrorCopyWith(
          _BusinessStateError value, $Res Function(_BusinessStateError) then) =
      __$BusinessStateErrorCopyWithImpl<$Res>;
  $Res call({String? error});
}

/// @nodoc
class __$BusinessStateErrorCopyWithImpl<$Res>
    extends _$BusinessStateCopyWithImpl<$Res>
    implements _$BusinessStateErrorCopyWith<$Res> {
  __$BusinessStateErrorCopyWithImpl(
      _BusinessStateError _value, $Res Function(_BusinessStateError) _then)
      : super(_value, (v) => _then(v as _BusinessStateError));

  @override
  _BusinessStateError get _value => super._value as _BusinessStateError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_BusinessStateError(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_BusinessStateError implements _BusinessStateError {
  _$_BusinessStateError([this.error]);

  @override
  final String? error;

  @override
  String toString() {
    return 'BusinessState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusinessStateError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$BusinessStateErrorCopyWith<_BusinessStateError> get copyWith =>
      __$BusinessStateErrorCopyWithImpl<_BusinessStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Business business) data,
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
    TResult Function(Business business)? data,
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
    required TResult Function(_BusinessStateInitial value) initial,
    required TResult Function(_BusinessStateLoading value) loading,
    required TResult Function(_BusinessStateData value) data,
    required TResult Function(_BusinessStateLoaded value) loaded,
    required TResult Function(_BusinessStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BusinessStateInitial value)? initial,
    TResult Function(_BusinessStateLoading value)? loading,
    TResult Function(_BusinessStateData value)? data,
    TResult Function(_BusinessStateLoaded value)? loaded,
    TResult Function(_BusinessStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _BusinessStateError implements BusinessState {
  factory _BusinessStateError([String? error]) = _$_BusinessStateError;

  String? get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$BusinessStateErrorCopyWith<_BusinessStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
