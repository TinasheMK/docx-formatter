// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WorkerProfile _$_$_WorkerProfileFromJson(Map<String, dynamic> json) {
  return _$_WorkerProfile(
    id: json['id'] as int?,
    firstname: json['firstname'] as String?,
    lastname: json['lastname'] as String?,
    gender: json['gender'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    email: json['email'] as String?,
    username: json['username'] as String?,
    assignmentCode: json['assignmentCode'] as String?,
    status: json['status'] as String?,
    createdBy: json['createdBy'] as String?,
  );
}

Map<String, dynamic> _$_$_WorkerProfileToJson(_$_WorkerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'username': instance.username,
      'assignmentCode': instance.assignmentCode,
      'status': instance.status,
      'createdBy': instance.createdBy,
    };
