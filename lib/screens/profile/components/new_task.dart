import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/screens/forms/components/add_new_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/daily_info_model.dart';


class NewTask extends StatefulWidget {
  const NewTask({
    Key? key,
    required this.dailyData,
  }) : super(key: key);

  final DailyInfoModel dailyData;

  @override
  _NewTaskState createState() => _NewTaskState();


}

class _NewTaskState extends State<NewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      body: SingleChildScrollView(
        child: Card(
          color: bgColor,
          elevation: 5,
          margin: EdgeInsets.fromLTRB(32, 32, 64, 32),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Center(
                      child: Text("What do you want to add? Select from below."),
                    ),
                    SelectionSection(tasks: billings),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
