import '../../core/constants/color_constants.dart';
import '../../core/widgets/app_button_widget.dart';
import '../../core/widgets/input_widget.dart';
import '../../responsive.dart';

import '../invoice/components/header.dart';
import './components/mini_information_card.dart';

import './components/recent_forums.dart';
import './components/recent_users.dart';
import './components/user_details_widget.dart';
import 'package:flutter/material.dart';

import 'components/memo_list_material.dart';


class ProfileScreen extends StatelessWidget {
  callback(mem, action) {

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: 60,),
              MiniInformation(),
              SizedBox(height: 60,),
              Image.asset("assets/logo/logo_icon.png", scale:1),
              SizedBox(height: defaultPadding),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _registerScreen(context),
                        SizedBox(
                          // height: 600,
                            child: MemoListMaterial(
                            callback: callback
                        )
                        ),
                        // RecentUsers(),
                        SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  // if (!Responsive.isMobile(context))
                    //z Expanded(
                    //   flex: 2,
                    //   child: UserDetailsWidget(),
                    // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



Container _registerScreen(BuildContext context) {
  return Container(
    width: double.infinity,
    child: Form(
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

            topLabel: "User Name",

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

            topLabel: "User Email",

            hintText: "Enter E-mail",
            // prefixIcon: FlutterIcons.chevron_left_fea,
          ),
          SizedBox(height: 8.0),
        ],
      ),
    ),
  );
}