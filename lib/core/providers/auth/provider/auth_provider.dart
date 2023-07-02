import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import 'auth_state.dart';
import 'auth_state_notifier.dart';
export 'auth_state.dart';

/// dependency injection

// logic
final authNotifierProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

// repository
final authRepositoryProvider = Provider.autoDispose<IAuthRepository>(
  (ref) => AuthRepository(ref.read),
);
