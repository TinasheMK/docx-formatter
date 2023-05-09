// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Role _$_$_RoleFromJson(Map<String, dynamic> json) {
  return _$_Role(
    id: json['id'] as int?,
    name: json['name'] as String?,
    permissions: (json['permissions'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : Permission.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_RoleToJson(_$_Role instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'permissions': instance.permissions,
    };
