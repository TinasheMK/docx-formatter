import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPreferencesService {

  Future<void> setOnboardingComplete();

  Future<void> cacheUserCredentials(Map<String, dynamic> auth);

  Future<void> resetUserCredentials();

  Map<String, dynamic>? getCachedUserCredentials();

  bool isOnboardingComplete();

}

class SharedPreferencesService implements ISharedPreferencesService{
  SharedPreferencesService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const onboardingCompleteKey = 'onboardingComplete';
  static const kUserPwdKey = 'kUserPwdKey';

  @override
  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  @override
  Future<void> cacheUserCredentials(Map<String, dynamic> auth) async {
    await sharedPreferences.setString(kUserPwdKey, json.encode(auth));
  }

  @override
  Future<void> resetUserCredentials() async {
    await sharedPreferences.remove(kUserPwdKey);
  }

  @override
  Map<String, dynamic>? getCachedUserCredentials() {
    final res = sharedPreferences.getString(kUserPwdKey);

    if (res != null) {
      return json.decode(res) as Map<String, dynamic>;
    }

    return null;
  }

  @override
  bool isOnboardingComplete() =>
      sharedPreferences.getBool(onboardingCompleteKey) ?? false;
}
