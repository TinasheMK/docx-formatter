import 'package:docxform/core/constants/color_constants.dart';
import 'package:docxform/core/widgets/calendar_item.dart';

import 'package:flutter/material.dart';

import '../../../core/models/data.dart';

class ListCalendarData extends StatelessWidget {
  final List<CalendarData> calendarData;

  const ListCalendarData({Key? key, required this.calendarData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: calendarData
          .asMap()
          .entries
          .map(
            (data) => Padding(
              padding: EdgeInsets.only(
                  bottom:
                      data.key != calendarData.length - 1 ? defaultPadding : 0),
              child: Text("Wii"),
            ),
          )
          .toList(),
    );
  }
}
