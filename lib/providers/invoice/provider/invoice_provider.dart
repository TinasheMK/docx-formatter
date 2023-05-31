import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/invoice_repository.dart';
import 'invoice_state.dart';
import 'invoice_state_notifier.dart';
export 'invoice_state.dart';

/// dependency injection

// logic
final invoicesNotifierProvider =
    StateNotifierProvider.autoDispose<InvoiceNotifier, InvoiceState>(
  (ref) => InvoiceNotifier(
    invoiceRepository: ref.watch(invoiceRepositoryProvider),
  ),
);

// repository
final invoiceRepositoryProvider = Provider.autoDispose<IInvoiceRepository>(
  (ref) => InvoiceRepository(ref.read),
);
