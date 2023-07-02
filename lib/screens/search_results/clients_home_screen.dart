import 'package:smart_admin_dashboard/core/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../../core/models/Client.dart';
import '../dashboard/components/side_menu.dart';
import 'search_results_screen.dart';

class SearchResultsHomeScreen extends StatelessWidget {
  final List<Client> clients;

  const SearchResultsHomeScreen({Key? key, required this.clients}) : super(key: key);

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
              child: SearchResultsScreen(clients: clients),
            ),
          ],
        ),
      ),
    );
  }
}
