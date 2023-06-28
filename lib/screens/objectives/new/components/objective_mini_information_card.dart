import 'package:smart_admin_dashboard/core/constants/color_constants.dart';

import 'package:smart_admin_dashboard/core/utils/responsive.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/mini_information_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/daily_info_model.dart';
import '../../objectives_home_screen.dart';

// import '../new/new_register_home_screen.dart';
// import '../new/new_register_screen.dart';

class ObjectiveMiniInformation extends StatelessWidget {


  const ObjectiveMiniInformation({
    Key? key,required this.title
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            Text("Company Objective: "+title, style: TextStyle(fontSize: 35, color: Colors.white) ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ObjectivesHomeScreen()),
                );


              },
              icon: Icon(Icons.cancel),
              label: Text(
                "Cancel",
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),

      ],
    );
  }
}
