import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/screens/forms/components/add_new_widget.dart';
import 'package:flutter/material.dart';

import '../../providers/daily_info_model.dart';

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
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Center(
                      child: Text("What do you want to add today? Select from below."),
                    ),
                    widget.dailyData.title=="DEEDS"?SelectionSection(tasks: billings,):
                    widget.dailyData.title=="ZIMRA"?SelectionSection(tasks: zimras,):
                    widget.dailyData.title=="PRAZ"?SelectionSection(tasks: prazs,):
                    widget.dailyData.title=="CLIENT"?SelectionSection(tasks: clients,):
                    SelectionSection(tasks: billings),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
