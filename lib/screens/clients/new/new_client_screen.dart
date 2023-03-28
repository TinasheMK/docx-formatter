import 'dart:convert';

import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/services.dart';
import 'package:smart_admin_dashboard/models/registration/Employee.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import '../../../core/utils/colorful_tag.dart';
import '../../../models/Memo.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../models/recent_user_model.dart';
import '../../../models/registration/Client.dart';
import '../../../models/registration/Company.dart';
import '../../../responsive.dart';

import '../../generator/CR6_form_generator.dart';
import '../../generator/register_download_screen.dart';
import '../../home/home_screen.dart';
import '../../register/components/header.dart';
import '../../memos/memo_list_material.dart';
import '../clients_home_screen.dart';
import 'components/mini_information_card.dart';

import '../components/recent_forums.dart';
import '../components/recent_users.dart';
import '../components/user_details_widget.dart';
import 'package:flutter/material.dart';

import 'components/dropdown_search.dart';


class NewClientScreen extends StatefulWidget {
  NewClientScreen({required this.title, required this.code, this.clientId});
  final String title;
  final String code;
  int? clientId;

  @override
  _NewClientScreenState createState() => _NewClientScreenState(clientId);
}

// class NewClientScreen extends StatefulWidget {
class _NewClientScreenState extends State<NewClientScreen> with SingleTickerProviderStateMixin {
  _NewClientScreenState(int? this.clientId);
  int? clientId;

  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;

  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;

  int _directors = 2;

  List persons = [];
  List original = [];


  Employee employee = Employee.fromJson({});


  TextEditingController txtQuery = new TextEditingController();


  List<String> memoItems = [];

  void loadData() async {
    setState(() {});
  }

  late int crossAxisCount;
  late double childAspectRatio;
  late List<Memo> memosSet = [];

  late Client client;

  Future<void> _initclient() async {
    if(clientId!=null) {
      client = await getClient(clientId);
    }else{
      client = new Client.fromJson({});

    }

    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    _initclient();
    loadData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

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
              MiniInformation(title: client.companyName??"",),
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

                                SizedBox( height: 200,child: Column(
                                  children: [
                                    Expanded(
                                      child: Column(children: [
                                        
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child:
                                              Padding(
                                                padding: EdgeInsets.only(left: 5, right:5),
                                                child: InputWidget(
                                                  topLabel: "Objective Title",
                                                  keyboardType: TextInputType.text,

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
                                                  kInitialValue: client.companyName??"",


                                                  // prefixIcon: FlutterIcons.chevron_left_fea,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                          ],),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child:
                                              Padding(
                                                padding: EdgeInsets.only(left: 5, right:5),
                                                child: InputWidget(
                                                  topLabel: "Description",
                                                  keyboardType: TextInputType.text,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    client!.email = value;
                                                  },
                                                  kInitialValue: client!.email ,


                                                  // prefixIcon: FlutterIcons.chevron_left_fea,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                          ],),
                                      ],),

                                    ),
                                  ],)),
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
                                              MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
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




