import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker_profile.freezed.dart';
part 'worker_profile.g.dart';

@freezed
class WorkerProfile with _$WorkerProfile {
  const factory WorkerProfile({
    int? id,
    String? firstname,
    String? lastname,
    String? gender,
    String? phoneNumber,
    String? email,
    String? username,
    String? assignmentCode,
    String? status,
    String? createdBy,
  }) = _WorkerProfile;

  factory WorkerProfile.fromJson(Map<String, dynamic> json) =>
      _$WorkerProfileFromJson(json);
}
