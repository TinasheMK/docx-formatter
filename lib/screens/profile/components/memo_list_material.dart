import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../../../models/Memo.dart';
import 'memos_widget.dart';


class MemoListMaterial extends StatefulWidget {
  @override
  _MemoListMaterialState createState() => _MemoListMaterialState();

  const MemoListMaterial({
    Key? key,
    required this.callback

  }) : super(key: key);

  final Function(String, String) callback;


}

class _MemoListMaterialState extends State<MemoListMaterial> {
  @override
  Widget build(BuildContext context) {
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
                MemoSelectionSection(memos: memos,callback: widget.callback),
              ],
            )),
      ),
    );
  }
}
