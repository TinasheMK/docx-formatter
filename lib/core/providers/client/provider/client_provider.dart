import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/client_repository.dart';
import 'client_state.dart';
import 'client_state_notifier.dart';
export 'client_state.dart';

/// dependency injection

// logic
final clientNotifierProvider =
    StateNotifierProvider.autoDispose<ClientNotifier, ClientState>(
  (ref) => ClientNotifier(
    clientRepository: ref.watch(clientRepositoryProvider),
  ),
);

// repository
final clientRepositoryProvider = Provider.autoDispose<IClientRepository>(
  (ref) => ClientRepository(ref.read),
);
