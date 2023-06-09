// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return _LoginResponse.fromJson(json);
}

/// @nodoc
class _$LoginResponseTearOff {
  const _$LoginResponseTearOff();

  _LoginResponse call(
      {int? agentId,
      int? clientId,
      int? userId,
      List<Role?>? roles,
      int? id,
      String? firstName,
      String? lastName,
      @JsonKey(name: "access_token") String? accessToken,
      @JsonKey(name: "token_type") String? tokenType,
      @JsonKey(name: "refresh_token") String? refreshToken,
      String? scope,
      @JsonKey(name: "expires_in") String? expiresIn}) {
    return _LoginResponse(
      agentId: agentId,
      clientId: clientId,
      userId: userId,
      roles: roles,
      id: id,
      firstName: firstName,
      lastName: lastName,
      accessToken: accessToken,
      tokenType: tokenType,
      refreshToken: refreshToken,
      scope: scope,
      expiresIn: expiresIn,
    );
  }

  LoginResponse fromJson(Map<String, Object> json) {
    return LoginResponse.fromJson(json);
  }
}

/// @nodoc
const $LoginResponse = _$LoginResponseTearOff();

/// @nodoc
mixin _$LoginResponse {
  int? get agentId => throw _privateConstructorUsedError;
  int? get clientId => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;
  List<Role?>? get roles => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: "access_token")
  String? get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: "token_type")
  String? get tokenType => throw _privateConstructorUsedError;
  @JsonKey(name: "refresh_token")
  String? get refreshToken => throw _privateConstructorUsedError;
  String? get scope => throw _privateConstructorUsedError;
  @JsonKey(name: "expires_in")
  String? get expiresIn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginResponseCopyWith<LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseCopyWith<$Res> {
  factory $LoginResponseCopyWith(
          LoginResponse value, $Res Function(LoginResponse) then) =
      _$LoginResponseCopyWithImpl<$Res>;
  $Res call(
      {int? agentId,
      int? clientId,
      int? userId,
      List<Role?>? roles,
      int? id,
      String? firstName,
      String? lastName,
      @JsonKey(name: "access_token") String? accessToken,
      @JsonKey(name: "token_type") String? tokenType,
      @JsonKey(name: "refresh_token") String? refreshToken,
      String? scope,
      @JsonKey(name: "expires_in") String? expiresIn});
}

/// @nodoc
class _$LoginResponseCopyWithImpl<$Res>
    implements $LoginResponseCopyWith<$Res> {
  _$LoginResponseCopyWithImpl(this._value, this._then);

  final LoginResponse _value;
  // ignore: unused_field
  final $Res Function(LoginResponse) _then;

  @override
  $Res call({
    Object? agentId = freezed,
    Object? clientId = freezed,
    Object? userId = freezed,
    Object? roles = freezed,
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? accessToken = freezed,
    Object? tokenType = freezed,
    Object? refreshToken = freezed,
    Object? scope = freezed,
    Object? expiresIn = freezed,
  }) {
    return _then(_value.copyWith(
      agentId: agentId == freezed
          ? _value.agentId
          : agentId // ignore: cast_nullable_to_non_nullable
              as int?,
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      roles: roles == freezed
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Role?>?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: accessToken == freezed
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: tokenType == freezed
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      scope: scope == freezed
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: expiresIn == freezed
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$LoginResponseCopyWith<$Res>
    implements $LoginResponseCopyWith<$Res> {
  factory _$LoginResponseCopyWith(
          _LoginResponse value, $Res Function(_LoginResponse) then) =
      __$LoginResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? agentId,
      int? clientId,
      int? userId,
      List<Role?>? roles,
      int? id,
      String? firstName,
      String? lastName,
      @JsonKey(name: "access_token") String? accessToken,
      @JsonKey(name: "token_type") String? tokenType,
      @JsonKey(name: "refresh_token") String? refreshToken,
      String? scope,
      @JsonKey(name: "expires_in") String? expiresIn});
}

/// @nodoc
class __$LoginResponseCopyWithImpl<$Res>
    extends _$LoginResponseCopyWithImpl<$Res>
    implements _$LoginResponseCopyWith<$Res> {
  __$LoginResponseCopyWithImpl(
      _LoginResponse _value, $Res Function(_LoginResponse) _then)
      : super(_value, (v) => _then(v as _LoginResponse));

  @override
  _LoginResponse get _value => super._value as _LoginResponse;

  @override
  $Res call({
    Object? agentId = freezed,
    Object? clientId = freezed,
    Object? userId = freezed,
    Object? roles = freezed,
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? accessToken = freezed,
    Object? tokenType = freezed,
    Object? refreshToken = freezed,
    Object? scope = freezed,
    Object? expiresIn = freezed,
  }) {
    return _then(_LoginResponse(
      agentId: agentId == freezed
          ? _value.agentId
          : agentId // ignore: cast_nullable_to_non_nullable
              as int?,
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      roles: roles == freezed
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Role?>?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: accessToken == freezed
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: tokenType == freezed
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      scope: scope == freezed
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: expiresIn == freezed
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LoginResponse implements _LoginResponse {
  const _$_LoginResponse(
      {this.agentId,
      this.clientId,
      this.userId,
      this.roles,
      this.id,
      this.firstName,
      this.lastName,
      @JsonKey(name: "access_token") this.accessToken,
      @JsonKey(name: "token_type") this.tokenType,
      @JsonKey(name: "refresh_token") this.refreshToken,
      this.scope,
      @JsonKey(name: "expires_in") this.expiresIn});

  factory _$_LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$_$_LoginResponseFromJson(json);

  @override
  final int? agentId;
  @override
  final int? clientId;
  @override
  final int? userId;
  @override
  final List<Role?>? roles;
  @override
  final int? id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  @JsonKey(name: "access_token")
  final String? accessToken;
  @override
  @JsonKey(name: "token_type")
  final String? tokenType;
  @override
  @JsonKey(name: "refresh_token")
  final String? refreshToken;
  @override
  final String? scope;
  @override
  @JsonKey(name: "expires_in")
  final String? expiresIn;

  @override
  String toString() {
    return 'LoginResponse(agentId: $agentId, clientId: $clientId, userId: $userId, roles: $roles, id: $id, firstName: $firstName, lastName: $lastName, accessToken: $accessToken, tokenType: $tokenType, refreshToken: $refreshToken, scope: $scope, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoginResponse &&
            (identical(other.agentId, agentId) ||
                const DeepCollectionEquality()
                    .equals(other.agentId, agentId)) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality()
                    .equals(other.userId, userId)) &&
            (identical(other.roles, roles) ||
                const DeepCollectionEquality().equals(other.roles, roles)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality()
                    .equals(other.accessToken, accessToken)) &&
            (identical(other.tokenType, tokenType) ||
                const DeepCollectionEquality()
                    .equals(other.tokenType, tokenType)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.expiresIn, expiresIn) ||
                const DeepCollectionEquality()
                    .equals(other.expiresIn, expiresIn)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(agentId) ^
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(roles) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(tokenType) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(scope) ^
      const DeepCollectionEquality().hash(expiresIn);

  @JsonKey(ignore: true)
  @override
  _$LoginResponseCopyWith<_LoginResponse> get copyWith =>
      __$LoginResponseCopyWithImpl<_LoginResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LoginResponseToJson(this);
  }
}

abstract class _LoginResponse implements LoginResponse {
  const factory _LoginResponse(
      {int? agentId,
      int? clientId,
      int? userId,
      List<Role?>? roles,
      int? id,
      String? firstName,
      String? lastName,
      @JsonKey(name: "access_token") String? accessToken,
      @JsonKey(name: "token_type") String? tokenType,
      @JsonKey(name: "refresh_token") String? refreshToken,
      String? scope,
      @JsonKey(name: "expires_in") String? expiresIn}) = _$_LoginResponse;

  factory _LoginResponse.fromJson(Map<String, dynamic> json) =
      _$_LoginResponse.fromJson;

  @override
  int? get agentId => throw _privateConstructorUsedError;
  @override
  int? get clientId => throw _privateConstructorUsedError;
  @override
  int? get userId => throw _privateConstructorUsedError;
  @override
  List<Role?>? get roles => throw _privateConstructorUsedError;
  @override
  int? get id => throw _privateConstructorUsedError;
  @override
  String? get firstName => throw _privateConstructorUsedError;
  @override
  String? get lastName => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "access_token")
  String? get accessToken => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "token_type")
  String? get tokenType => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "refresh_token")
  String? get refreshToken => throw _privateConstructorUsedError;
  @override
  String? get scope => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "expires_in")
  String? get expiresIn => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoginResponseCopyWith<_LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
