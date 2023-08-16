import 'dart:convert';

import 'package:docxform/core/models/ClientStage.dart';
import 'package:flutter/services.dart';
import '../../../core/models/Client.dart';
import '../../../core/models/Client.dart';
import '../../../core/models/Director.dart';


import '../../../core/constants/color_constants.dart';
import '../../../core/models/Secretary.dart';
import '../../../core/models/Stage.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../core/utils/responsive.dart';

import '../../../core/utils/company_reg_doc_generator.dart';
import '../../dashboard/components/header.dart';

import 'package:flutter/material.dart';

import 'components/zimra_header.dart';



class NewZimraScreen extends StatefulWidget {
  NewZimraScreen({required this.title, required this.code, this.companyId});
  final String title;
  final String code;
  final int? companyId;

  @override
  _NewZimraScreenState createState() => _NewZimraScreenState(companyId);
}

// class NewZimraScreen extends StatefulWidget {
class _NewZimraScreenState extends State<NewZimraScreen> with SingleTickerProviderStateMixin {
  _NewZimraScreenState(this.companyId);

  final int? companyId;
  bool isChecked = false;
  bool secEdited = false;
  int _directors = 2;
  List persons = [];
  List original = [];
  List<Client> clients = [Client.fromJson({})];
  List<Stage> stages = [Stage.fromJson({})];
  TextEditingController txtQuery = new TextEditingController();
  late int crossAxisCount;
  late double childAspectRatio;
  List<Client> memosSet = [];
  final _formKey = GlobalKey<FormState>();
  List<String> memoItems = [];
  Client client = Client.fromJson({});

  void loadData() async {
    client.stages = [];
    clients = await getClients();
    stages = await getTypeStages('zimra');
    if(companyId!=null) {
      client = (await getClient(companyId!))!;
    }
    
    // Match required stages to available stages
    if(client.stages?.length != stages.length){
        stages.forEach((e) {
          var exists = false;
          client.stages!.forEach((s) {
            if(e.id==s.stageId){
              exists = true;
            }
          });

          if(exists==false){
            client.stages!.add(ClientStage.fromJson({
              "client_id": client.id,
              "notes": "",
              "status": "incomplete",
              "type": "zimra",
              "stageId": e.id,
            }));
          }



        });
        

      
 
    }

    // print("done");


    setState(() {});
  }

  void _addDirector() {
    setState(() {
      _directors += 1;
        client.directors!.add(Director.fromJson({}));

    });
  }

  void _removeDirector() {
    setState(() {
      if(_directors>1){
        _directors -= 1;
      }else{
        _directors = 1;
      }
    });
  }


  @override
  void initState() {
    super.initState();

    loadData();



  }



  @override
  Widget build(BuildContext context) {

    // client!.directors!.add(Director.fromJson({}));
    // client!.directors!.add(Director.fromJson({}));
    final Size _size = MediaQuery.of(context).size;
    crossAxisCount= _size.width < 650 ? 2 : 4;
    childAspectRatio= _size.width < 650 ? 3 : 3;


    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              ZimraHeader(title: widget.title,),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        _registerScreen(context),
                        SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _registerScreen(BuildContext context) {

    callback(mem, action) async {
      if(action=="set"){
          var client1 = await getClient(int.parse(mem));
        setState(()  {
          memosSet.removeWhere((e) => e.id ==int.parse(mem));
        });
      }else{
        setState(() {
          memosSet.removeWhere((element) => element.id == int.parse(mem));
        });
      }



    }

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 0.0,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(height: 16.0),
            client.name!=null
                ? Text( (client.name??""), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),)
                : InputWidget(
              keyboardType: TextInputType.text,
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              onChanged: (String? value) {
                client.name = value;

              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },

              topLabel: "Company Name",

              hintText: "Enter Company Name",
              // prefixIcon: FlutterIcons.chevron_left_fea,
            ),


            SizedBox(height: 50.0),

            //First Stage
            Column(
              children: List.generate(
                  (client.stages?.length??0), (i) {

                    var con = TextEditingController(text: client.stages![i].notes);

                    Stage getClientStage(int stageId){
                      Stage stage = Stage.fromJson({});
                      stages.forEach((e) {
                        if(e.id==stageId){
                          stage = e;
                        }
                      });
                      return stage;
                    }


                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text( "Stage "+(getClientStage(client.stages![i].stageId!).number??"")+" : "+(getClientStage(client.stages?[i].stageId ?? 0).name??""), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),),
                                    Text( getClientStage(client.stages?[i].stageId ?? 1).description??"", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[

                                    Text("Completed?"
                                      , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                                    Checkbox(
                                      value:  client!.stages?[i].status=="complete",
                                      checkColor: Colors.green,
                                      activeColor: Colors.white,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if(value == false){
                                            client!.stages?[i].status="incomplete";
                                          }else{
                                            client!.stages?[i].status="complete";
                                          };
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],),
                            SizedBox(height: 16.0),
                            InputWidget(
                              keyboardType: TextInputType.multiline,
                              onSaved: (String? value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },kController: con,
                              onChanged: (String? value) {
                                client!.stages?[i].notes = value;

                              },
                              topLabel: "Notes",
                              hintText: "Enter Additional Notes",
                              // prefixIcon: FlutterIcons.chevron_left_fea,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20)
                    ],
                  );
               }),
            ),



            SizedBox(height: 40.0),
            // generatorResp!=""?Text(generatorResp):SizedBox(),
            ElevatedButton.icon(
                icon: Icon(
                  Icons.save,
                  size: 14,
                ),
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20),
                    primary: Colors.lightGreen),
                onPressed: () async {
                  // print("Generating docs.");
                  if (_formKey.currentState!.validate()) {}


                  client!.directors?.removeWhere((e) => e.name == null);
                  client!.secretaries?.removeWhere((e) => e.name == null);
                  client!.stages?.removeWhere((e) => e.status == null);

                  await client.save();
                  print(client.toJson());


                },
                label: Text("Save")),

            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

}




class MiniMemo extends StatefulWidget {
  const MiniMemo({
    Key? key,
    required this.memo, required this.callback
  }) : super(key: key);
  final Client memo;
  final Function(String, String) callback;


  @override
  _MiniMemoState createState() => _MiniMemoState();
}

class _MiniMemoState extends State<MiniMemo> {
  bool _visible = false;


  int charLength = 0;

  bool status = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.memo.set=="set"?darkgreenColor:Colors.black38,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.memo.name??''}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Visibility(
                      visible: !_visible,
                      child: widget.memo.set=="set"?Icon(Icons.backspace_outlined, size: 18):Icon(Icons.add, size: 18),
                    )
                  ],
                ),
              ),
              onTap: () {
                // _toggle();
                widget.callback(widget.memo.id.toString()!, "not");


              }
          ),

        ],
      ),
    );
  }

}




