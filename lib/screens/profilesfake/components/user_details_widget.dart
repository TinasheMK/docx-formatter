import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import '../../clients/components/calendart_widget.dart';
import 'calendart_widget.dart';
import 'user_details_mini_card.dart';
import 'package:flutter/material.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarWidget(),

        ],
      ),
    );
  }
}
