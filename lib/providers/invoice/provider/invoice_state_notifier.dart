//part of 'invoice_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:work_link/src/features/invoice/data/invoice_repository.dart';
// import 'package:work_link/src/models/custom_exception.dart';
// import 'package:work_link/src/models/profile/worker_profile.dart';

import '../../custom_exception.dart';
import '../../profile/worker_profile.dart';
import '../data/invoice_repository.dart';
import 'invoice_state.dart';

class InvoiceNotifier extends StateNotifier<InvoiceState> {
  InvoiceNotifier({
    required IInvoiceRepository invoiceRepository,
  })  : _invoiceRepository = invoiceRepository,
        super(InvoiceState.initial());

  final IInvoiceRepository _invoiceRepository;

  void resetState() {
    state = InvoiceState.initial();
  }

  Future<void> syncInvoices(Map<String, dynamic>? credentials, {bool rememberMe: false}) async {
    state = InvoiceState.loading();

    try {
      final resp = await _invoiceRepository.invoices();

      state = InvoiceState.loaded();
    }

    // error
    catch (e) {
      if (e is CustomException) {
        state = InvoiceState.error(e.message);
      } else
        state = InvoiceState.error(e.toString());
    }
  }
}
