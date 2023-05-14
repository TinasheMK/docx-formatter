import 'package:flutter/scheduler.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/providers/daily_info_model.dart';

import '../../../providers/Memo.dart';
import '../../../providers/registration/Company.dart';
import '../../../responsive.dart';
import '../new/new_profile_home_screen.dart';
import 'memos_widget.dart';


class MemoListMaterial extends StatefulWidget {
  @override
  _MemoListMaterialState createState() => _MemoListMaterialState();

  MemoListMaterial({
    Key? key,
    required this.callback

  }) : super(key: key);

  final Function(String, String) callback;





}





class _MemoListMaterialState extends State<MemoListMaterial> {

  List<Company> clients = [];

  Future<void> _initCompanys() async {
    clients = await getCompanys();
    setState(() {});

  }

  @override
  void initState() {

    _initCompanys();
  }


  @override
  Widget build(BuildContext context) {
    print(clients);
    print("clients");
    return Card(
      color: bgColor,
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 16.0, horizontal: 16.0),
            child: Column(
              children: [


                SizedBox(height: 10,),

                Center(
                  child: Text("Your Business Profiles"),
                ),
                clients.length == 0 ? ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: darkgreenColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    clients = [Company.fromJson({})];
                    setState(() {

                    });

                    Navigator.pop(context);

                    SchedulerBinding.instance!
                        .addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NewProfileHome(title: 'New Invoice', code: 'invoice',)),
                      );
                    });




                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    "Add Business Profile",
                  ),
                ) : SizedBox(),
                MemoSelectionSection(memos: memos,callback: widget.callback),
              ],
            )),
      ),
    );
  }
}
