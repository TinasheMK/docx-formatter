// import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../providers/auth/provider/auth_provider.dart';
import '../../providers/profile/worker_profile.dart';
import '../../services/shared_pref_service.dart';
import '../home/home_screen.dart';

final rememberMeProvider = StateProvider<bool>((_) => false);

class LoginView extends ConsumerWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authProvider = watch(authNotifierProvider);
    final sharedPref = watch(sharedPreferencesServiceProvider);

    return SafeArea(
      child: Scaffold(
        body: RelativeBuilder(builder: (context, height, width, sy, sx) {
          return Container(
            height: height,
            width: width,
            child: FutureBuilder(
              future: watch(authRepositoryProvider)
                  .login(sharedPref.getCachedUserCredentials()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final wp = snapshot.data;

                  if (wp is WorkerProfile) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        Text('Failed to login'),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () async {
                              await sharedPref.resetUserCredentials();

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            },
                            child: Text('Retry')),
                      ],
                    ),
                  );
                }

                return Center(
                    child: Container(child: CircularProgressIndicator()));
              },
            )
          );
        }),
      ),
    );
  }
}




