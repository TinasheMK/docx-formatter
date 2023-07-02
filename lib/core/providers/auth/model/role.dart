import 'package:freezed_annotation/freezed_annotation.dart';

import 'permission.dart';

part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class Role with _$Role {
  const factory Role({
    int? id,
    String? name,
    List<Permission?>? permissions,
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}
