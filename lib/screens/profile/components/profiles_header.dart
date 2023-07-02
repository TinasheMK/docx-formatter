import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/types/daily_info_model.dart';

import 'package:smart_admin_dashboard/core/utils/responsive.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/mini_information_widget.dart';
 import 'package:flutter/material.dart';


class ProfilesHeader extends StatelessWidget {
  const ProfilesHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text( "Profile", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),),

          ],
        ),
        SizedBox(height: defaultPadding),
        // Responsive(
        //   mobile: InformationCard(
        //     crossAxisCount: _size.width < 650 ? 2 : 4,
        //     childAspectRatio: _size.width < 650 ? 1.2 : 1,
        //   ),
        //   tablet: InformationCard(),
        //   desktop: InformationCard(
        //     childAspectRatio: _size.width < 1400 ? 1.2 : 1.4,
        //   ),
        // ),
      ],
    );
  }
}
