import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) => throw UnimplementedError());


class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const onboardingCompleteKey = 'onboardingComplete';
  static const kUserPwdKey = 'kUserPwdKey';

  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  Future<void> cacheUserCredentials(Map<String, dynamic> auth) async {
    await sharedPreferences.setString(kUserPwdKey, json.encode(auth));
  }

  Future<void> resetUserCredentials() async {
    await sharedPreferences.remove(kUserPwdKey);
  }

  Map<String, dynamic>? getCachedUserCredentials() {
    final res = sharedPreferences.getString(kUserPwdKey);

    if (res != null) {
      return json.decode(res) as Map<String, dynamic>;
    }

    return null;
  }

  bool isOnboardingComplete() =>
      sharedPreferences.getBool(onboardingCompleteKey) ?? false;
}
