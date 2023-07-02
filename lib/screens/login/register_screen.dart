import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/widgets/app_button_widget.dart';
import 'package:smart_admin_dashboard/core/widgets/input_widget.dart';
import 'package:smart_admin_dashboard/screens/home/home_screen.dart';
import 'package:smart_admin_dashboard/screens/login/components/slider_widget.dart';
import 'package:smart_admin_dashboard/screens/generator/data_store.dart';

import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/screens/login/login_screen.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/utils/UserPreference.dart';
import '../../core/providers/auth/provider/auth_provider.dart';
import '../../core/providers/profile/worker_profile.dart';
import '../../core/utils/responsive.dart';
import '../../core/providers/services/shared_pref_service.dart';
import '../generator/databaseHelper.dart';
import '../generator/register_download_screen.dart';

// final dbHelper = DatabaseHelper();
class Register extends StatefulWidget {
  Register({required this.title});
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> with SingleTickerProviderStateMixin {
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
                                        RegisterListener(),
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

class _registerScreen extends ConsumerWidget {
  // _registerScreen({
  //   required this.slideCallback
  // });
  //
  // final Function() slideCallback;
  String? email;
  String? firstName;
  String? lastName;

  String? password;

  bool isChecked = false;
  bool rememberme = false;



  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authProvider = watch(authNotifierProvider);
    final sharedPref = watch(sharedPreferencesServiceProvider);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 0.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8.0),
            InputWidget(
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              onChanged: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
                firstName = value;
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },

              topLabel: "First Name",

              hintText: "Enter E-mail",
              // prefixIcon: FlutterIcons.chevron_left_fea,
            ),
            SizedBox(height: 8.0),
            InputWidget(
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              onChanged: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
                lastName = value;
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },

              topLabel: "Last Name",

              hintText: "Enter E-mail",
              // prefixIcon: FlutterIcons.chevron_left_fea,
            ),
            SizedBox(height: 8.0),
            InputWidget(
              keyboardType: TextInputType.emailAddress,
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              onChanged: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
                print("hello");
                print(value);
                email = value;
              },
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
              text: "Sign Up",
              onPressed: () async {



                final payload = {
                  "email": email,
                  "firstName": firstName,
                  "lastName": lastName,
                  "password":password
                };

                if (!authProvider.isLoading) {
                  await context
                      .read(authNotifierProvider.notifier)
                      .registerUser(
                      payload
                  );
                }

              },
            ),
            SizedBox(height: 24.0),
            Center(
              child: Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login(title: 'Register',)),
                      );
                    },
                    child: Text("Sign In",
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

class RegisterListener extends ConsumerWidget {
  // RegisterListener({
  //   required this.slideCallback
  // });
  //
  // final Function() slideCallback;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authProvider = watch(authNotifierProvider);

    return SizedBox(
      // flex: 5,
      child: authProvider.when(
        initial: () => _registerScreen(),
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
              content: Text("Registration Successful"),
            ));
          });


          SchedulerBinding.instance!
              .addPostFrameCallback((_) {
            Navigator.pop(context, true);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login(title: "login screen10")),
            );
          });





          return _registerScreen();
        },

        loaded: (loaded) => Text(loaded.toString()),
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


          return _registerScreen();
        },
      ),
    );

  }




}

