

import '../../core/constants/color_constants.dart';
import '../../core/utils/responsive.dart';
import '../dashboard/components/header.dart';
import '../dashboard/components/user_details_widget.dart';
import 'package:flutter/material.dart';

import 'components/zimras_header.dart';
import 'components/zimras_list.dart';


class ZimrasScreen extends StatelessWidget {
  final String title;

  const ZimrasScreen({Key? key, required this.title}) : super(key: key);

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
              ZimrasHeader(title: title),
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
                        ZimrasList(title: title),
                        SizedBox(height: defaultPadding),
                        // RecentDiscussions(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) UserDetailsWidget(),
                      ],
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
