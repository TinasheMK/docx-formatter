import 'package:smart_admin_dashboard/screens/quote/components/quotes_header.dart';
import 'package:smart_admin_dashboard/screens/quote/components/quotes_list.dart';

import '../../core/constants/color_constants.dart';
import '../../core/utils/responsive.dart';

import '../dashboard/components/header.dart';
  import 'package:flutter/material.dart';

import 'components/receipts_header.dart';
import 'components/receipts_list.dart';


class ReceiptsScreen extends StatelessWidget {
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
              ReceiptsHeader(),
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
                        ReceiptList(),

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
