import 'package:docxform/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../auth/login_screen.dart';
import '../../clients/clients_home_screen.dart';
import '../../praz/prazs_home_screen.dart';
import '../../register/register_home_screen.dart';
import '../../register/register_screen.dart';
import '../../zimra/zimras_home_screen.dart';
import '../home_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: defaultPadding * 3,
                ),
                Image.asset(
                  "assets/logo/logo_icon.png",
                  scale: 5,
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text("Tapmub Consultancy")
              ],
            )),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            DrawerListTile(
              title: "DEEDS",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                );
              },
            ),
            DrawerListTile(
              title: "ZIMRA",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ZimrasHomeScreen(title:"ZIMRA")),
                );
              },
            ),
            DrawerListTile(
              title: "PRAZ",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ZimrasHomeScreen(title: 'PRAZ',)),
                );
              },
            ),
            // DrawerListTile(
            //   title: "OTHER",
            //   svgSrc: "assets/icons/menu_notification.svg",
            //   press: () {},
            // ),
            // DrawerListTile(
            //   title: "Objectives",
            //   svgSrc: "assets/icons/menu_doc.svg",
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
            //     );
            //   },
            // ),
            DrawerListTile(
              title: "Clients",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
                );
              },
            ),
            DrawerListTile(
              title: "Logout",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login(title: "You logged out.")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
