
import 'package:flutter/services.dart';
import '../../../core/models/Client.dart';
import '../../../core/models/Employee.dart';
import '../../../core/models/Memo.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../core/utils/responsive.dart';

import '../../dashboard/components/header.dart';
import '../objectives_home_screen.dart';
import 'components/objective_mini_information_card.dart';

import 'package:flutter/material.dart';


class NewObjectiveScreen extends StatefulWidget {
  NewObjectiveScreen({required this.title, required this.code, this.clientId});
  final String title;
  final String code;
  int? clientId;

  @override
  _NewObjectiveScreenState createState() => _NewObjectiveScreenState(clientId);
}

// class NewObjectiveScreen extends StatefulWidget {
class _NewObjectiveScreenState extends State<NewObjectiveScreen> with SingleTickerProviderStateMixin {
  _NewObjectiveScreenState(int? this.clientId);
  int? clientId;

  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;

  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;

  List persons = [];
  List original = [];


  Employee employee = Employee.fromJson({});


  TextEditingController txtQuery = new TextEditingController();


  List<String> memoItems = [];


  late int crossAxisCount;
  late double childAspectRatio;
  late List<Memo> memosSet = [];

  Client client =  new Client.fromJson({});
  TextEditingController titleCon = TextEditingController();
  TextEditingController descCon = TextEditingController();

  Future<void> _initclient() async {
    if(clientId!=null) {
      client = await getClient(clientId);
      titleCon.text = client?.companyName??"";
      descCon.text = client?.email??"";

    }
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    _initclient();


  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
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
              ObjectiveMiniInformation(title: client.companyName??"",),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        //MyFiels(),
                        //SizedBox(height: defaultPadding),
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            // minHeight: MediaQuery.of(context).size.height - 0.0,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [

                                SizedBox(height: 16.0),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right:5),
                                  child: InputWidget(
                                    topLabel: "Objective Title",
                                    keyboardType: TextInputType.text,
                                    kController: titleCon,

                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    onChanged: (String? value) {
                                      print(client!.toJson());
                                      client!.companyName = value;
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
                                      client!.email = value;
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
                                            if(widget.code == "edit"){
                                              client!.update();
                                            }else{
                                              client!.save();
                                            }

                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Client saved successfully"),
                                            ));

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ObjectivesHomeScreen()),
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
                                        "Save Client",
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




