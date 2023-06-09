// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginResponse _$_$_LoginResponseFromJson(Map<String, dynamic> json) {
  return _$_LoginResponse(
    agentId: json['agentId'] as int?,
    clientId: json['clientId'] as int?,
    userId: json['userId'] as int?,
    roles: (json['roles'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : Role.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as int?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    accessToken: json['access_token'] as String?,
    tokenType: json['token_type'] as String?,
    refreshToken: json['refresh_token'] as String?,
    scope: json['scope'] as String?,
    expiresIn: json['expires_in'] as String?,
  );
}

Map<String, dynamic> _$_$_LoginResponseToJson(_$_LoginResponse instance) =>
    <String, dynamic>{
      'agentId': instance.agentId,
      'clientId': instance.clientId,
      'userId': instance.userId,
      'roles': instance.roles,
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'refresh_token': instance.refreshToken,
      'scope': instance.scope,
      'expires_in': instance.expiresIn,
    };
