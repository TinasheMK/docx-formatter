import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/sync_repository.dart';
import 'sync_state.dart';
import 'sync_state_notifier.dart';
export 'sync_state.dart';

/// dependency injection

// logic
final syncNotifierProvider =
    StateNotifierProvider.autoDispose<SyncNotifier, SyncState>(
  (ref) => SyncNotifier(
    syncRepository: ref.watch(syncRepositoryProvider),
  ),
);

// repository
final syncRepositoryProvider = Provider.autoDispose<ISyncRepository>(
  (ref) => SyncRepository(ref.read),
);
