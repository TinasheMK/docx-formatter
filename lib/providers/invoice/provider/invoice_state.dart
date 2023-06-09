import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_admin_dashboard/providers/registration/Invoice.dart';


part 'invoice_state.freezed.dart';

// extension method for easy comparison
extension InvoiceGetters on InvoiceState {
  bool get isLoading => this is _InvoiceStateLoading;
  bool get isError=> this is _InvoiceStateError;
}

@freezed
class InvoiceState with _$InvoiceState {
  /// initial
  factory InvoiceState.initial() = _InvoiceStateInitial;

  /// loading
  factory InvoiceState.loading() = _InvoiceStateLoading;

  /// data
  factory InvoiceState.data({required Invoice invoice}) =
      _InvoiceStateData;

  /// other data different from invoice
  factory InvoiceState.loaded([@Default(0) dynamic data]) = _InvoiceStateLoaded;

  /// Error
  factory InvoiceState.error([String? error]) = _InvoiceStateError;
}
