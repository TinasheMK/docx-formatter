
import 'package:flutter/services.dart';
import '../../../core/models/Stage.dart';
import '../../../core/models/Employee.dart';
import '../../../core/models/Memo.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../core/utils/responsive.dart';

import '../../dashboard/components/header.dart';
import '../stages_home_screen.dart';
import 'components/stage_mini_information_card.dart';

import 'package:flutter/material.dart';


class NewStageScreen extends StatefulWidget {
  NewStageScreen({required this.title, required this.code, this.clientId});
  final String title;
  final String code;
  int? clientId;

  @override
  _NewStageScreenState createState() => _NewStageScreenState(clientId);
}

// class NewStageScreen extends StatefulWidget {
class _NewStageScreenState extends State<NewStageScreen> with SingleTickerProviderStateMixin {
  _NewStageScreenState(int? this.clientId);
  int? clientId;



  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;




  TextEditingController txtQuery = new TextEditingController();


  List<String> memoItems = [];


  late int crossAxisCount;
  late double childAspectRatio;
  late List<Memo> memosSet = [];

  Stage? client =  new Stage.fromJson({});
  TextEditingController titleCon = TextEditingController();
  TextEditingController numCon = TextEditingController();
  TextEditingController descCon = TextEditingController();

  Future<void> _initclient() async {
    if(clientId!=null) {
      client = await getStage(clientId!);
      numCon.text = client?.number??"";
      titleCon.text = client?.name??"";
      descCon.text = client?.description??"";

    }
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    _initclient();


  }


  @override
  Widget build(BuildContext context) {
    print(client!.toJson().toString());
    print(widget.code);

    // print(widget.code);
    final Size _size = MediaQuery.of(context).size;
    crossAxisCount= _size.width < 650 ? 2 : 4;
    childAspectRatio= _size.width < 650 ? 3 : 3;

    memosSet = memoInits;

    for( int i = 0 ; i < memos.length; i++ ) {
      if(memos[i].set!="set"){
        memosSet.removeWhere((element) => element.code == memos[i].code);
        print(i);
      }else if(memos.length==0){
        memosSet.add(memos[1]);
      }
    }

    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              StageMiniInformation(title: client?.name??"",),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(height: 16.0),
                                Padding(
                                  padding: EdgeInsets.only( bottom: 10),
                                  child: TextButton(
                                    child: Text("Stage Type: "+(client?.type??"") , style: TextStyle(color: Colors.green, fontSize:20)),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                                title: Center(
                                                  child: Column(
                                                    children: [
                                                      Icon(Icons.lightbulb,
                                                          size: 36, color: Colors.green),
                                                      SizedBox(height: 20),
                                                      Text("Select Type Of Stage"),
                                                    ],
                                                  ),
                                                ),
                                                content: Container(
                                                  color: secondaryColor,
                                                  height: 70,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          ElevatedButton.icon(
                                                              icon: Icon(
                                                                Icons.accessibility_sharp,
                                                                size: 14,
                                                              ),
                                                              style: ElevatedButton.styleFrom(
                                                                  primary: Colors.purple),
                                                              onPressed: () {
                                                                client!.type = "praz";
                                                                Navigator.of(context).pop();
                                                                setState(() {

                                                                });
                                                              },
                                                              label: Text("Praz")),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          ElevatedButton.icon(
                                                              icon: Icon(
                                                                Icons.house,
                                                                size: 14,
                                                              ),
                                                              style: ElevatedButton.styleFrom(
                                                                  primary: Colors.red),
                                                              onPressed: () {
                                                                client!.type = "zimra";
                                                                Navigator.of(context).pop();
                                                                setState(() {

                                                                });
                                                              },
                                                              label: Text("ZIMRA"))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ));
                                          });
                                    },
                                    // Delete
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right:5),
                                  child: InputWidget(
                                    topLabel: "Stage Number",
                                    keyboardType: TextInputType.number,
                                    kinputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
                                    ],
                                    kController: numCon,

                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    onChanged: (String? value) {
                                      print(client!.toJson());
                                      client!.number = value;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter company name.';
                                      }
                                      return null;
                                    },



                                    // prefixIcon: FlutterIcons.chevron_left_fea,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right:5),
                                  child: InputWidget(
                                    topLabel: "Stage Title",
                                    keyboardType: TextInputType.text,
                                    kController: titleCon,

                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    onChanged: (String? value) {
                                      print(client!.toJson());
                                      client!.name = value;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter company name.';
                                      }
                                      return null;
                                    },



                                    // prefixIcon: FlutterIcons.chevron_left_fea,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right:5),
                                  child: InputWidget(
                                    topLabel: "Description",
                                    kController: descCon,
                                    keyboardType: TextInputType.multiline,
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    onChanged: (String? value) {
                                      client!.description = value;
                                    },


                                    // prefixIcon: FlutterIcons.chevron_left_fea,
                                  ),
                                ),


                                SizedBox(height: 25,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    ElevatedButton.icon(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding * 1.5,
                                          vertical:
                                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          print(client!.toJson());
                                          print(widget.code);
                                          try {

                                              client!.save();


                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Stage saved successfully"),
                                            ));

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => StagesHomeScreen()),
                                            );
                                          }catch(e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("An error occured. Check all fields"),
                                            ));
                                          };



                                        }

                                      },
                                      icon: Icon(Icons.save),
                                      label: Text(
                                        "Save Stage",
                                      ),
                                    ),
                                  ],
                                ),

                                // _listView(persons),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  // if (!Responsive.isMobile(context))
                    //z Expanded(
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




