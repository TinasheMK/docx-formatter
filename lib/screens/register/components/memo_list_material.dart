import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import '../../../core/models/Memo.dart';
import 'package:flutter/material.dart';

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
                      child: Text("Select company objectives from below."),
                    ),
                    MemoSelectionSection(memos: memos,callback: widget.callback),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
