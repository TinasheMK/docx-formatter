import '../../core/constants/color_constants.dart';
import '../../core/utils/responsive.dart';

import '../dashboard/components/header.dart';
import './components/registration_page_header.dart';

import './components/client_list_registration.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget {
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
              SizedBox(height: defaultPadding),
              MiniInformation(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        //MyFiels(),
                        //SizedBox(height: defaultPadding),
                        // RecentDiscussions(),

                        RecentUsers(),
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
