import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoices_response.freezed.dart';
part 'invoices_response.g.dart';

@freezed
class InvoicesResponse with _$InvoicesResponse {
  const factory InvoicesResponse({
    int? synced,
  }) = _InvoicesResponse;

  factory InvoicesResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoicesResponseFromJson(json);
}
