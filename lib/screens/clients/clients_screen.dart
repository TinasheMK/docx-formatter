
import 'package:docxform/screens/clients/components/client_list.dart';

import '../../core/constants/color_constants.dart';
import '../../core/utils/responsive.dart';
import '../dashboard/components/header.dart';
import '../dashboard/components/user_details_widget.dart';
import './components/mini_information_card.dart';
import 'package:flutter/material.dart';


class ClientsScreen extends StatelessWidget {





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
                        ClientList(),
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
