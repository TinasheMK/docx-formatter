import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/business_repository.dart';
import 'business_state.dart';
import 'business_state_notifier.dart';
export 'business_state.dart';

/// dependency injection

// logic
final businessNotifierProvider =
    StateNotifierProvider.autoDispose<BusinessNotifier, BusinessState>(
  (ref) => BusinessNotifier(
    businessRepository: ref.watch(businessRepositoryProvider),
  ),
);

// repository
final businessRepositoryProvider = Provider.autoDispose<IBusinessRepository>(
  (ref) => BusinessRepository(ref.read),
);
