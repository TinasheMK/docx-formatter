// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'invoices_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InvoicesResponse _$InvoicesResponseFromJson(Map<String, dynamic> json) {
  return _InvoicesResponse.fromJson(json);
}

/// @nodoc
class _$InvoicesResponseTearOff {
  const _$InvoicesResponseTearOff();

  _InvoicesResponse call({int? synced}) {
    return _InvoicesResponse(
      synced: synced,
    );
  }

  InvoicesResponse fromJson(Map<String, Object> json) {
    return InvoicesResponse.fromJson(json);
  }
}

/// @nodoc
const $InvoicesResponse = _$InvoicesResponseTearOff();

/// @nodoc
mixin _$InvoicesResponse {
  int? get synced => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoicesResponseCopyWith<InvoicesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoicesResponseCopyWith<$Res> {
  factory $InvoicesResponseCopyWith(
          InvoicesResponse value, $Res Function(InvoicesResponse) then) =
      _$InvoicesResponseCopyWithImpl<$Res>;
  $Res call({int? synced});
}

/// @nodoc
class _$InvoicesResponseCopyWithImpl<$Res>
    implements $InvoicesResponseCopyWith<$Res> {
  _$InvoicesResponseCopyWithImpl(this._value, this._then);

  final InvoicesResponse _value;
  // ignore: unused_field
  final $Res Function(InvoicesResponse) _then;

  @override
  $Res call({
    Object? synced = freezed,
  }) {
    return _then(_value.copyWith(
      synced: synced == freezed
          ? _value.synced
          : synced // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$InvoicesResponseCopyWith<$Res>
    implements $InvoicesResponseCopyWith<$Res> {
  factory _$InvoicesResponseCopyWith(
          _InvoicesResponse value, $Res Function(_InvoicesResponse) then) =
      __$InvoicesResponseCopyWithImpl<$Res>;
  @override
  $Res call({int? synced});
}

/// @nodoc
class __$InvoicesResponseCopyWithImpl<$Res>
    extends _$InvoicesResponseCopyWithImpl<$Res>
    implements _$InvoicesResponseCopyWith<$Res> {
  __$InvoicesResponseCopyWithImpl(
      _InvoicesResponse _value, $Res Function(_InvoicesResponse) _then)
      : super(_value, (v) => _then(v as _InvoicesResponse));

  @override
  _InvoicesResponse get _value => super._value as _InvoicesResponse;

  @override
  $Res call({
    Object? synced = freezed,
  }) {
    return _then(_InvoicesResponse(
      synced: synced == freezed
          ? _value.synced
          : synced // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InvoicesResponse implements _InvoicesResponse {
  const _$_InvoicesResponse({this.synced});

  factory _$_InvoicesResponse.fromJson(Map<String, dynamic> json) =>
      _$_$_InvoicesResponseFromJson(json);

  @override
  final int? synced;

  @override
  String toString() {
    return 'InvoicesResponse(synced: $synced)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InvoicesResponse &&
            (identical(other.synced, synced) ||
                const DeepCollectionEquality().equals(other.synced, synced)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(synced);

  @JsonKey(ignore: true)
  @override
  _$InvoicesResponseCopyWith<_InvoicesResponse> get copyWith =>
      __$InvoicesResponseCopyWithImpl<_InvoicesResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_InvoicesResponseToJson(this);
  }
}

abstract class _InvoicesResponse implements InvoicesResponse {
  const factory _InvoicesResponse({int? synced}) = _$_InvoicesResponse;

  factory _InvoicesResponse.fromJson(Map<String, dynamic> json) =
      _$_InvoicesResponse.fromJson;

  @override
  int? get synced => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InvoicesResponseCopyWith<_InvoicesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
