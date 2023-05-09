import 'package:freezed_annotation/freezed_annotation.dart';

import 'role.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    int? agentId,
    int? clientId,
    int? workerId,
    List<Role?>? roles,
    int? id,
    String? firstName,
    String? lastName,
    @JsonKey(name: "access_token") String? accessToken,
    @JsonKey(name: "token_type") String? tokenType,
    @JsonKey(name: "refresh_token") String? refreshToken,
    String? scope,
    @JsonKey(name: "expires_in") String? expiresIn,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
