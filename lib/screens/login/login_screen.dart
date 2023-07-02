import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/widgets/app_button_widget.dart';
import 'package:smart_admin_dashboard/core/widgets/input_widget.dart';
import 'package:smart_admin_dashboard/screens/dashboard/home_screen.dart';
import 'package:smart_admin_dashboard/screens/login/components/slider_widget.dart';

import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/screens/login/register_screen.dart';

import '../../core/utils/UserPreference.dart';
import '../../core/providers/auth/provider/auth_provider.dart';
import '../../core/providers/profile/worker_profile.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/shared_pref_service.dart';

// final dbHelper = DatabaseHelper();
class Login extends StatefulWidget {
  Login({required this.title});
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;

  var _isMoved = false;

  bool isChecked = false;

  String? email;
  bool? rememberme;
  String? password;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("this is login the state");
    slideCallback(){
      if (_isMoved) {
        _animationController!.reverse();
      } else {
        _animationController!.forward();
      }
      _isMoved = !_isMoved;
    }



    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (!Responsive.isMobile(context))
                Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.white,
                child: SliderWidget(),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: Responsive.isMobile(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width /2 ,
                color: bgColor,
                child: Center(
                  child: Card(
                    //elevation: 5,
                    color: bgColor,
                    child: Container(
                      padding: EdgeInsets.all(42),
                      width: Responsive.isMobile(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width / 2.5 ,
                      height: Responsive.isMobile(context) ? MediaQuery.of(context).size.height / 1 : MediaQuery.of(context).size.height / 1.2,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: Responsive.isMobile(context) ? 0:40,
                          ),
                          if(!Responsive.isMobile(context))Image.asset("assets/logo/logo_icon.png", scale: 3),
                          SizedBox(height: Responsive.isMobile(context) ? 0:24.0),
                          Flexible(
                            child: Stack(
                              children: [
                                SlideTransition(
                                  position:
                                  _animationController!.drive(tweenRight),
                                  child: Stack(
                                      fit: StackFit.loose,
                                      clipBehavior: Clip.none,
                                      children: [
                                        LoginListener(),
                                      ]),
                                )
                              ],
                            ),
                          ),

                          //Flexible(
                          //  child: SlideTransition(
                          //    position: _animationController!.drive(tweenLeft),
                          //    child: Stack(
                          //        fit: StackFit.loose,
                          //        clipBehavior: Clip.none,
                          //        children: [
                          //          _registerScreen(context),
                          //        ]),
                          //  ),
                          //),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }



}


class _loginScreen extends ConsumerWidget {
  // _loginScreen({
  //   required this.slideCallback
  // });
  //
  // final Function() slideCallback;

  String? email;

  String? password;

  var isChecked;

  var rememberme = true;




  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authProvider = watch(authNotifierProvider);
    final sharedPref = watch(sharedPreferencesServiceProvider);


    return SingleChildScrollView(
      // width: double.infinity,
      // constraints: BoxConstraints(
      //   minHeight: MediaQuery.of(context).size.height - 0.0,
      // ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/6),
            InputWidget(
              keyboardType: TextInputType.emailAddress,
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              onChanged: (String? value) {email = value; },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },

              topLabel: "Email",

              hintText: "Enter E-mail",
              // prefixIcon: FlutterIcons.chevron_left_fea,
            ),
            SizedBox(height: 8.0),
            InputWidget(
              topLabel: "Password",
              obscureText: true,
              hintText: "Enter Password",
              onSaved: (String? uPassword) {},
              onChanged: (String? value) {password = value;},
              validator: (String? value) {},
            ),
            SizedBox(height: 24.0),
            AppButton(
              type: ButtonType.PRIMARY,
              text: "Sign In",
              onPressed: () async {
                final payload = {
                  "username": email,
                  "password":password
                };

                if (!authProvider.isLoading) {
                  await context
                      .read(authNotifierProvider.notifier)
                      .loginUser(
                    payload,
                    rememberMe: rememberme,
                  );
                }

              },
            ),

            SizedBox(height: 24.0),
            Center( child:GestureDetector(
              onTap: () {
                // _insert();
                showDialog(
                    context: context,
                    builder: (_) {
                      return  Padding(
                          padding: const EdgeInsets.only(bottom: defaultPadding*15),
                          child:Dialog(
                        // width: double.infinity,
                        // constraints: BoxConstraints(
                        //   minHeight: MediaQuery.of(context).size.height - 0.0,
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.all( defaultPadding),

                          child: Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InputWidget(
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (String? value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  onChanged: (String? value) {email = value; },
                                  validator: (String? value) {
                                    return (value != null && value.contains('@'))
                                        ? 'Do not use the @ char.'
                                        : null;
                                  },

                                  topLabel: "Email",

                                  hintText: "Enter E-mail",
                                  // prefixIcon: FlutterIcons.chevron_left_fea,
                                ),
                                SizedBox(height: 24.0),
                                AppButton(
                                  type: ButtonType.PRIMARY,
                                  text: "Reset password",
                                  onPressed: () async {
                                    final payload = {
                                      "email": email
                                    };

                                    if (!authProvider.isLoading) {
                                      await context
                                          .read(authNotifierProvider.notifier)
                                          .resetPwd(email?? "");
                                    }

                                  },
                                ),

                                SizedBox(height: 24.0),

                              ],
                            ),
                          ),
                        ),
                      ));
                    });
              },
              child: Text(
                "Forgot Password?",
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: greenColor),
              ),
            ),),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Checkbox(
                    //   value: isChecked,
                    //   onChanged: (bool? value) {
                    //     // setState(() {
                    //     //   isChecked = value!;
                    //     //   rememberme = value!;
                    //     // });
                    //   },
                    // ),
                    Text("Remember Me")
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    // _insert();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool(UserPreference.skip,
                        true);


                    // Navigator.pop(context, true);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(source: "login screen1")),
                    );
                  },
                  child: Text(
                    "Skip",
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: greenColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Center(
              child: Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "No account yet?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Register(title: 'Register',)),
                      );
                    },
                    child: Text("Sign up",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400, color: greenColor)),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class LoginListener extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print("this is login listener");

    final authProvider = watch(authNotifierProvider);
    final sharedPref = watch(sharedPreferencesServiceProvider);

    return sharedPref.getCachedUserCredentials() != null ? FutureBuilder(
      future: watch(authRepositoryProvider)
          .login(sharedPref.getCachedUserCredentials()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final wp = snapshot.data;

          if (wp is WorkerProfile) {



            SchedulerBinding.instance!.addPostFrameCallback((_) {
              // Navigator.pop(context, true);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(source: "login screen3")),
              );
            });


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

                      SchedulerBinding.instance!
                          .addPostFrameCallback((_) {
                        // Navigator.pop(context, true);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen(source: "login screen4")),
                        );
                      });
                    },
                    child: Text('Retry')),
              ],
            ),
          );
        }

        return Center(
            child: Container(child: CircularProgressIndicator()));
      },
    ): sharedPref.skipSignIn() == true ? FutureBuilder(
      builder: (context, snapshot) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          // Navigator.pop(context, true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(source: "login screen5")),
          );
        });

        return Center(
            child: Container(child: CircularProgressIndicator()));
      },
    ) : SizedBox(child: authProvider.when(
      initial: () => _loginScreen(),
      loading: () =>
          Center(child: CircularProgressIndicator()),
      data: (data) {
        print(data);




        SchedulerBinding.instance!
            .addPostFrameCallback((_) {
          context
              .read(authNotifierProvider.notifier)
              .resetState();

        });

        SchedulerBinding.instance!
            .addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login Successful"),
          ));
        });


        SchedulerBinding.instance!
            .addPostFrameCallback((_) {
          // Navigator.pop(context, true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(source: "login screen6")),
          );
        });





        return _loginScreen();
      },

      loaded: (loaded) {
        Navigator.of(context).pop();

        SchedulerBinding.instance!
            .addPostFrameCallback((_) {
          context
              .read(authNotifierProvider.notifier)
              .resetState();

        });

        SchedulerBinding.instance!
            .addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(loaded.toString()),
          ));
        });

        // resetState();


        return _loginScreen();
      },
      error: (e) {

        SchedulerBinding.instance!
            .addPostFrameCallback((_) {
          context
              .read(authNotifierProvider.notifier)
              .resetState();

        });

        SchedulerBinding.instance!
            .addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
        });

        // resetState();

        return _loginScreen();
      },
    ),

    );

  }




}
