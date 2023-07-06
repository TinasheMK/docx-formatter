import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../business/data/business_repository.dart';
import '../../client/data/client_repository.dart';
import '../data/invoice_repository.dart';
import 'invoice_state.dart';
import 'invoice_state_notifier.dart';
export 'invoice_state.dart';

/// dependency injection

// logic
final invoiceNotifierProvider =
    StateNotifierProvider.autoDispose<InvoiceNotifier, InvoiceState>(
  (ref) => InvoiceNotifier(
    invoiceRepository: ref.watch(invoiceRepositoryProvider),
    clientRepository: ref.watch(clientRepositoryProvider),
    businessRepository: ref.watch(businessRepositoryProvider),
  ),
);

// repository
final invoiceRepositoryProvider = Provider.autoDispose<IInvoiceRepository>(
  (ref) => InvoiceRepository(ref.read),
);

final clientRepositoryProvider = Provider.autoDispose<IClientRepository>(
  (ref) => ClientRepository(ref.read),
);

final businessRepositoryProvider = Provider.autoDispose<IBusinessRepository>(
  (ref) => BusinessRepository(ref.read),
);
