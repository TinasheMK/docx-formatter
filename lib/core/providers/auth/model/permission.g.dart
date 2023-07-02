// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Permission _$_$_PermissionFromJson(Map<String, dynamic> json) {
  return _$_Permission(
    id: json['id'] as int?,
    authority: json['authority'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$_$_PermissionToJson(_$_Permission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authority': instance.authority,
      'description': instance.description,
    };
