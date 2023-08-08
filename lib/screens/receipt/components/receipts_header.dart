import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/types/daily_info_model.dart';

import 'package:smart_admin_dashboard/core/utils/responsive.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/mini_information_widget.dart';
 import 'package:flutter/material.dart';

import '../edit/receipt_home_screen.dart';




class ReceiptsHeader extends StatelessWidget {
  const ReceiptsHeader({
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
            Text( "Receipts", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: defaultColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                    defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReceiptHomeScreen(title: 'New To Collect', code: 'invoice',)),
                  );


                },
                icon: Icon(Icons.add),
                label: Text(
                  "Order",
                ),
              ),
              SizedBox(width: 5,),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: defaultColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                    defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReceiptHomeScreen(title: 'New Receipt', code: 'invoice',)),
                  );


                },
                icon: Icon(Icons.add),
                label: Text(
                  "Receipt",
                ),
              ),
            ],)
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
