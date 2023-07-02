// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$InvoiceStateTearOff {
  const _$InvoiceStateTearOff();

  _InvoiceStateInitial initial() {
    return _InvoiceStateInitial();
  }

  _InvoiceStateLoading loading() {
    return _InvoiceStateLoading();
  }

  _InvoiceStateData data({required Invoice invoice}) {
    return _InvoiceStateData(
      invoice: invoice,
    );
  }

  _InvoiceStateLoaded loaded([dynamic data = 0]) {
    return _InvoiceStateLoaded(
      data,
    );
  }

  _InvoiceStateError error([String? error]) {
    return _InvoiceStateError(
      error,
    );
  }
}

/// @nodoc
const $InvoiceState = _$InvoiceStateTearOff();

/// @nodoc
mixin _$InvoiceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Invoice invoice) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Invoice invoice)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InvoiceStateInitial value) initial,
    required TResult Function(_InvoiceStateLoading value) loading,
    required TResult Function(_InvoiceStateData value) data,
    required TResult Function(_InvoiceStateLoaded value) loaded,
    required TResult Function(_InvoiceStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InvoiceStateInitial value)? initial,
    TResult Function(_InvoiceStateLoading value)? loading,
    TResult Function(_InvoiceStateData value)? data,
    TResult Function(_InvoiceStateLoaded value)? loaded,
    TResult Function(_InvoiceStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceStateCopyWith<$Res> {
  factory $InvoiceStateCopyWith(
          InvoiceState value, $Res Function(InvoiceState) then) =
      _$InvoiceStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$InvoiceStateCopyWithImpl<$Res> implements $InvoiceStateCopyWith<$Res> {
  _$InvoiceStateCopyWithImpl(this._value, this._then);

  final InvoiceState _value;
  // ignore: unused_field
  final $Res Function(InvoiceState) _then;
}

/// @nodoc
abstract class _$InvoiceStateInitialCopyWith<$Res> {
  factory _$InvoiceStateInitialCopyWith(_InvoiceStateInitial value,
          $Res Function(_InvoiceStateInitial) then) =
      __$InvoiceStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InvoiceStateInitialCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res>
    implements _$InvoiceStateInitialCopyWith<$Res> {
  __$InvoiceStateInitialCopyWithImpl(
      _InvoiceStateInitial _value, $Res Function(_InvoiceStateInitial) _then)
      : super(_value, (v) => _then(v as _InvoiceStateInitial));

  @override
  _InvoiceStateInitial get _value => super._value as _InvoiceStateInitial;
}

/// @nodoc

class _$_InvoiceStateInitial implements _InvoiceStateInitial {
  _$_InvoiceStateInitial();

  @override
  String toString() {
    return 'InvoiceState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _InvoiceStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Invoice invoice) data,
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
    TResult Function(Invoice invoice)? data,
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
    required TResult Function(_InvoiceStateInitial value) initial,
    required TResult Function(_InvoiceStateLoading value) loading,
    required TResult Function(_InvoiceStateData value) data,
    required TResult Function(_InvoiceStateLoaded value) loaded,
    required TResult Function(_InvoiceStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InvoiceStateInitial value)? initial,
    TResult Function(_InvoiceStateLoading value)? loading,
    TResult Function(_InvoiceStateData value)? data,
    TResult Function(_InvoiceStateLoaded value)? loaded,
    TResult Function(_InvoiceStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InvoiceStateInitial implements InvoiceState {
  factory _InvoiceStateInitial() = _$_InvoiceStateInitial;
}

/// @nodoc
abstract class _$InvoiceStateLoadingCopyWith<$Res> {
  factory _$InvoiceStateLoadingCopyWith(_InvoiceStateLoading value,
          $Res Function(_InvoiceStateLoading) then) =
      __$InvoiceStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$InvoiceStateLoadingCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res>
    implements _$InvoiceStateLoadingCopyWith<$Res> {
  __$InvoiceStateLoadingCopyWithImpl(
      _InvoiceStateLoading _value, $Res Function(_InvoiceStateLoading) _then)
      : super(_value, (v) => _then(v as _InvoiceStateLoading));

  @override
  _InvoiceStateLoading get _value => super._value as _InvoiceStateLoading;
}

/// @nodoc

class _$_InvoiceStateLoading implements _InvoiceStateLoading {
  _$_InvoiceStateLoading();

  @override
  String toString() {
    return 'InvoiceState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _InvoiceStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Invoice invoice) data,
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
    TResult Function(Invoice invoice)? data,
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
    required TResult Function(_InvoiceStateInitial value) initial,
    required TResult Function(_InvoiceStateLoading value) loading,
    required TResult Function(_InvoiceStateData value) data,
    required TResult Function(_InvoiceStateLoaded value) loaded,
    required TResult Function(_InvoiceStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InvoiceStateInitial value)? initial,
    TResult Function(_InvoiceStateLoading value)? loading,
    TResult Function(_InvoiceStateData value)? data,
    TResult Function(_InvoiceStateLoaded value)? loaded,
    TResult Function(_InvoiceStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _InvoiceStateLoading implements InvoiceState {
  factory _InvoiceStateLoading() = _$_InvoiceStateLoading;
}

/// @nodoc
abstract class _$InvoiceStateDataCopyWith<$Res> {
  factory _$InvoiceStateDataCopyWith(
          _InvoiceStateData value, $Res Function(_InvoiceStateData) then) =
      __$InvoiceStateDataCopyWithImpl<$Res>;
  $Res call({Invoice invoice});
}

/// @nodoc
class __$InvoiceStateDataCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res>
    implements _$InvoiceStateDataCopyWith<$Res> {
  __$InvoiceStateDataCopyWithImpl(
      _InvoiceStateData _value, $Res Function(_InvoiceStateData) _then)
      : super(_value, (v) => _then(v as _InvoiceStateData));

  @override
  _InvoiceStateData get _value => super._value as _InvoiceStateData;

  @override
  $Res call({
    Object? invoice = freezed,
  }) {
    return _then(_InvoiceStateData(
      invoice: invoice == freezed
          ? _value.invoice
          : invoice // ignore: cast_nullable_to_non_nullable
              as Invoice,
    ));
  }
}

/// @nodoc

class _$_InvoiceStateData implements _InvoiceStateData {
  _$_InvoiceStateData({required this.invoice});

  @override
  final Invoice invoice;

  @override
  String toString() {
    return 'InvoiceState.data(invoice: $invoice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InvoiceStateData &&
            (identical(other.invoice, invoice) ||
                const DeepCollectionEquality().equals(other.invoice, invoice)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(invoice);

  @JsonKey(ignore: true)
  @override
  _$InvoiceStateDataCopyWith<_InvoiceStateData> get copyWith =>
      __$InvoiceStateDataCopyWithImpl<_InvoiceStateData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Invoice invoice) data,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String? error) error,
  }) {
    return data(invoice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Invoice invoice)? data,
    TResult Function(dynamic data)? loaded,
    TResult Function(String? error)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(invoice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InvoiceStateInitial value) initial,
    required TResult Function(_InvoiceStateLoading value) loading,
    required TResult Function(_InvoiceStateData value) data,
    required TResult Function(_InvoiceStateLoaded value) loaded,
    required TResult Function(_InvoiceStateError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InvoiceStateInitial value)? initial,
    TResult Function(_InvoiceStateLoading value)? loading,
    TResult Function(_InvoiceStateData value)? data,
    TResult Function(_InvoiceStateLoaded value)? loaded,
    TResult Function(_InvoiceStateError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _InvoiceStateData implements InvoiceState {
  factory _InvoiceStateData({required Invoice invoice}) = _$_InvoiceStateData;

  Invoice get invoice => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$InvoiceStateDataCopyWith<_InvoiceStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$InvoiceStateLoadedCopyWith<$Res> {
  factory _$InvoiceStateLoadedCopyWith(
          _InvoiceStateLoaded value, $Res Function(_InvoiceStateLoaded) then) =
      __$InvoiceStateLoadedCopyWithImpl<$Res>;
  $Res call({dynamic data});
}

/// @nodoc
class __$InvoiceStateLoadedCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res>
    implements _$InvoiceStateLoadedCopyWith<$Res> {
  __$InvoiceStateLoadedCopyWithImpl(
      _InvoiceStateLoaded _value, $Res Function(_InvoiceStateLoaded) _then)
      : super(_value, (v) => _then(v as _InvoiceStateLoaded));

  @override
  _InvoiceStateLoaded get _value => super._value as _InvoiceStateLoaded;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_InvoiceStateLoaded(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_InvoiceStateLoaded implements _InvoiceStateLoaded {
  _$_InvoiceStateLoaded([this.data = 0]);

  @JsonKey(defaultValue: 0)
  @override
  final dynamic data;

  @override
  String toString() {
    return 'InvoiceState.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InvoiceStateLoaded &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$InvoiceStateLoadedCopyWith<_InvoiceStateLoaded> get copyWith =>
      __$InvoiceStateLoadedCopyWithImpl<_InvoiceStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Invoice invoice) data,
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
    TResult Function(Invoice invoice)? data,
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
    required TResult Function(_InvoiceStateInitial value) initial,
    required TResult Function(_InvoiceStateLoading value) loading,
    required TResult Function(_InvoiceStateData value) data,
    required TResult Function(_InvoiceStateLoaded value) loaded,
    required TResult Function(_InvoiceStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InvoiceStateInitial value)? initial,
    TResult Function(_InvoiceStateLoading value)? loading,
    TResult Function(_InvoiceStateData value)? data,
    TResult Function(_InvoiceStateLoaded value)? loaded,
    TResult Function(_InvoiceStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _InvoiceStateLoaded implements InvoiceState {
  factory _InvoiceStateLoaded([dynamic data]) = _$_InvoiceStateLoaded;

  dynamic get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$InvoiceStateLoadedCopyWith<_InvoiceStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$InvoiceStateErrorCopyWith<$Res> {
  factory _$InvoiceStateErrorCopyWith(
          _InvoiceStateError value, $Res Function(_InvoiceStateError) then) =
      __$InvoiceStateErrorCopyWithImpl<$Res>;
  $Res call({String? error});
}

/// @nodoc
class __$InvoiceStateErrorCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res>
    implements _$InvoiceStateErrorCopyWith<$Res> {
  __$InvoiceStateErrorCopyWithImpl(
      _InvoiceStateError _value, $Res Function(_InvoiceStateError) _then)
      : super(_value, (v) => _then(v as _InvoiceStateError));

  @override
  _InvoiceStateError get _value => super._value as _InvoiceStateError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_InvoiceStateError(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_InvoiceStateError implements _InvoiceStateError {
  _$_InvoiceStateError([this.error]);

  @override
  final String? error;

  @override
  String toString() {
    return 'InvoiceState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InvoiceStateError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$InvoiceStateErrorCopyWith<_InvoiceStateError> get copyWith =>
      __$InvoiceStateErrorCopyWithImpl<_InvoiceStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Invoice invoice) data,
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
    TResult Function(Invoice invoice)? data,
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
    required TResult Function(_InvoiceStateInitial value) initial,
    required TResult Function(_InvoiceStateLoading value) loading,
    required TResult Function(_InvoiceStateData value) data,
    required TResult Function(_InvoiceStateLoaded value) loaded,
    required TResult Function(_InvoiceStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InvoiceStateInitial value)? initial,
    TResult Function(_InvoiceStateLoading value)? loading,
    TResult Function(_InvoiceStateData value)? data,
    TResult Function(_InvoiceStateLoaded value)? loaded,
    TResult Function(_InvoiceStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _InvoiceStateError implements InvoiceState {
  factory _InvoiceStateError([String? error]) = _$_InvoiceStateError;

  String? get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$InvoiceStateErrorCopyWith<_InvoiceStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
