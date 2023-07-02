
import '../../core/constants/color_constants.dart';
import '../../core/utils/responsive.dart';
import '../../core/models/Client.dart';
import '../dashboard/components/header.dart';
import '../dashboard/components/recent_users.dart';
import '../invoice/components/header.dart';

import 'package:flutter/material.dart';

import 'components/search_results.dart';


class SearchResultsScreen extends StatelessWidget {

  final List<Client> clients;

  const SearchResultsScreen({Key? key, required this.clients}) : super(key: key);


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
              // MiniInformation(),
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
                        SearchResults(clients: clients),
                        SizedBox(height: defaultPadding),
                        // RecentDiscussions(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        // if (Responsive.isMobile(context)) UserDetailsWidget(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  // if (!Responsive.isMobile(context))
                    // Expanded(
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
