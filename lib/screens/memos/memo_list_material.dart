import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import './components/memos_widget.dart';
import 'package:flutter/material.dart';

import '../../models/Memo.dart';

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
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( "Search Existing Clients", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          // controller: "txtQuery",
                          // onChanged: search,
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            prefixIcon: Icon(Icons.search, color: greenColor),
                            fillColor: secondaryColor,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear, color: greenColor),

                              onPressed: () {
                                // txtQuery.text = '';
                                // search(txtQuery.text);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    Center(
                      child: Text("Select a client."),
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
