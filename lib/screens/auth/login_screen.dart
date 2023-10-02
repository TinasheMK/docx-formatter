import 'package:docxform/core/constants/color_constants.dart';
import 'package:docxform/core/widgets/app_button_widget.dart';
import 'package:docxform/core/widgets/input_widget.dart';
import 'package:docxform/screens/dashboard/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/databaseHelper.dart';
import '../register/new/components/slider_widget.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.white,
                child: SliderWidget(),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                color: bgColor,
                child: Center(
                  child: Card(
                    //elevation: 5,
                    color: bgColor,
                    child: Container(
                      padding: EdgeInsets.all(42),
                      width: MediaQuery.of(context).size.width / 3.6,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          Image.asset("assets/logo/logo_icon.png", scale: 3),
                          SizedBox(height: 24.0),
                          //Flexible(
                          //  child: _loginScreen(context),
                          //),
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
                                        _loginScreen(context),
                                      ]),
                                ),
                                SlideTransition(
                                  position:
                                      _animationController!.drive(tweenLeft),
                                  child: Stack(
                                      fit: StackFit.loose,
                                      clipBehavior: Clip.none,
                                      children: [
                                        _registerScreen(context),
                                      ]),
                                ),

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

  Container _registerScreen(BuildContext context) {
    return Container(
      // width: double.infinity,
      // constraints: BoxConstraints(
      //   minHeight: MediaQuery.of(context).size.height - 0.0,
      // ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputWidget(
              keyboardType: TextInputType.emailAddress,
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              onChanged: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },

              topLabel: "Name",

              hintText: "Enter Name",
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
              onChanged: (String? value) {},
              validator: (String? value) {},
            ),
            SizedBox(height: 24.0),
            AppButton(
              type: ButtonType.PRIMARY,
              text: "Sign Up",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text("Remember Me")
                  ],
                ),
              ],
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
                    onPressed: () {
                      if (_isMoved) {
                        _animationController!.reverse();
                      } else {
                        _animationController!.forward();
                      }
                      _isMoved = !_isMoved;
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

  Container _loginScreen(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 0.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // InputWidget(
            //   keyboardType: TextInputType.emailAddress,
            //   onSaved: (String? value) {
            //     // This optional block of code can be used to run
            //     // code when the user saves the form.
            //   },
            //   onChanged: (String? value) {
            //     // This optional block of code can be used to run
            //     // code when the user saves the form.
            //   },
            //   validator: (String? value) {
            //     return (value != null && value.contains('@'))
            //         ? 'Do not use the @ char.'
            //         : null;
            //   },
            //
            //   topLabel: "Email",
            //
            //   hintText: "Enter E-mail",
            //   // prefixIcon: FlutterIcons.chevron_left_fea,
            // ),
            SizedBox(height: 8.0),
            // InputWidget(
            //   topLabel: "Password",
            //   obscureText: true,
            //   hintText: "Enter Password",
            //   onSaved: (String? uPassword) {},
            //   onChanged: (String? value) {},
            //   validator: (String? value) {},
            // ),
            SizedBox(height: 24.0),
            GestureDetector(
              child: AppButton(
                type: ButtonType.PRIMARY,
                text: "Continue",
                onPressed: () {

                },
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),

            SizedBox(height: 24.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Row(
            //       children: <Widget>[
            //         Checkbox(
            //           value: isChecked,
            //           onChanged: (bool? value) {
            //             setState(() {
            //               isChecked = value!;
            //             });
            //           },
            //         ),
            //         Text("Remember Me")
            //       ],
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         // _insert();
            //       },
            //       child: Text(
            //         "Forgot Password?",
            //         textAlign: TextAlign.right,
            //         style: Theme.of(context)
            //             .textTheme
            //             .bodyText2!
            //             .copyWith(color: greenColor),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 24.0),
            // Center(
            //   child: Wrap(
            //     runAlignment: WrapAlignment.center,
            //     crossAxisAlignment: WrapCrossAlignment.center,
            //     children: [
            //       Text(
            //         "Don't have an account yet?",
            //         style: Theme.of(context)
            //             .textTheme
            //             .bodyText1!
            //             .copyWith(fontWeight: FontWeight.w300),
            //       ),
            //       SizedBox(
            //         width: 8,
            //       ),
            //       TextButton(
            //         onPressed: () {
            //           if (_isMoved) {
            //             _animationController!.reverse();
            //           } else {
            //             _animationController!.forward();
            //           }
            //           _isMoved = !_isMoved;
            //         },
            //         child: Text("Sign up",
            //             style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //                 fontWeight: FontWeight.w400, color: greenColor)),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(height: 24.0),
            GestureDetector(
              child: Text(
                "©Kanjan Solutions",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w200, fontSize: 9, color: Colors.blue),
              ),
              onTap: () async {
                final Uri url = Uri.parse("https://zimbosoft.co.zw");
                if (!await launchUrl(url)) {
                throw Exception('Could not launch Kanjan');
                }
                // launchUrl();
              },
            )


          ],
        ),
      ),
    );
  }
}


