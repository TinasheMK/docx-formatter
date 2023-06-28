import 'package:smart_admin_dashboard/core/utils/responsive.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/screens/register/register_screen.dart';

import '../dashboard/components/side_menu.dart';

class RegisterHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: RegisterScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
