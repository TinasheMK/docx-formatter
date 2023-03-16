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
import '../../memos/memo_list_material.dart';
import '../clients_home_screen.dart';
import 'components/mini_information_card.dart';

import '../components/recent_forums.dart';
import '../components/recent_users.dart';
import '../components/user_details_widget.dart';
import 'package:flutter/material.dart';

import '../components/header.dart';
import 'components/dropdown_search.dart';


class NewClientScreen extends StatefulWidget {
  NewClientScreen({required this.title, required this.code, this.client});
  final String title;
  final String code;
  Client? client;

  @override
  _NewClientScreenState createState() => _NewClientScreenState();
}

// class NewClientScreen extends StatefulWidget {
class _NewClientScreenState extends State<NewClientScreen> with SingleTickerProviderStateMixin {
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


  late String country;
  String generatorResp = "";
  late String city;
  late String street;
  late String companyName;
  List<String> memoItems = [];

  void loadData() async {
    // String jsonStr = await rootBundle.loadString('assets/persons.json');
    // var json = jsonDecode(jsonStr);
    // persons = json;
    // original = json;
    setState(() {});
  }

  void search(String query) {
    if (query.isEmpty) {
      persons = original;
      setState(() {});
      return;
    }

    query = query.toLowerCase();
    print(query);
    List result = [];
    persons.forEach((p) {
      var name = p["name"].toString().toLowerCase();
      if (name.contains(query)) {
        result.add(p);
      }
    });

    persons = result;
    setState(() {});
  }

  void _addDirector() {
    setState(() {
      _directors += 1;
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



  late int crossAxisCount;
  late double childAspectRatio;
  late List<Memo> memosSet = [];



  @override
  void initState() {
    super.initState();

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
    if(widget.client == null){
      widget.client = Client.fromJson({});
    }
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
              MiniInformation(title: widget.title,),
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
                        _registerScreen(context),
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

  Container _registerScreen(BuildContext context) {


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

            Responsive.isMobile(context)
                ? SizedBox( height: 600,child: Column( children: fields(context),))
                :  Row(children: fields(context),),
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
                      print(widget.client!.toJson());
                      print(widget.code);
                      try {
                        if(widget.code == "edit"){
                          widget.client!.update();
                        }else{
                          widget.client!.save();
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
    );
  }

  List<Widget> fields(BuildContext context) {
    return[
      Expanded(
        child: Column(children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child:
                Padding(
                  padding: EdgeInsets.only(left: 5, right:5),
                  child: InputWidget(
                    topLabel: "First Name",
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      employee.firstName = value;
                    },
                    kInitialValue: widget.client!.employees?[0].firstName ,



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
                    topLabel: "Last Name",
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      employee.lastName = value;
                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                    kInitialValue: widget.client!.employees?[0].lastName ,


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
                    topLabel: "Company Name",
                    keyboardType: TextInputType.text,

                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      widget.client!.companyName = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter company name.';
                      }
                      return null;
                    },
                    kInitialValue: widget.client!.companyName ,


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
                    topLabel: "Email",
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      widget.client!.email = value;
                    },
                    kInitialValue: widget.client!.email ,


                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
              ),
              SizedBox(height: 3),
            ],),
        ],),

      ),
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
                    topLabel: "Address",
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorStreet = value!;
                      //
                      //
                      widget.client!.street = value;
                    },
                    kInitialValue: widget.client!.email ,


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
                    topLabel: "City",
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {

                      widget.client!.city = value;
                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                    kInitialValue: widget.client!.city,


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
                    topLabel: "Country",
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      widget.client!.country = value;
                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                    kInitialValue: widget.client!.country,


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
                    topLabel: "Phone Number",
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      widget.client!.telephone = value;
                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                    kInitialValue: widget.client!.telephone ,


                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
              ),
              SizedBox(height: 3),
            ],),
        ],),

      ),
    ];
  }


}

Widget _listView(persons) {
  return Expanded(
    child: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          var person = persons[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(person['name'][0]),
            ),
            title: Text(person['name']),
            subtitle: Text("City: " + person['city']),
          );
        }),
  );
}





class MiniMemo extends StatefulWidget {
  const MiniMemo({
    Key? key,
    required this.memo
  }) : super(key: key);
  final Memo memo;

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
                      "${widget.memo.title!}",
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

              }
          ),

        ],
      ),
    );
  }

}


DataRow recentUserDataRow(RecentUser userInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Text("1",
            ),
          ],
        ),
      ),
      DataCell(Text(userInfo.name!)),
      DataCell(Text("10")),
      DataCell(Text("100")),
      DataCell(
        Row(
          children: [
            TextButton(
              child: Text('Add Row', style: TextStyle(color: greenColor)),
              onPressed: () {},
            ),
            SizedBox(
              width: 6,
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                          title: Center(
                            child: Column(
                              children: [
                                Icon(Icons.warning_outlined,
                                    size: 36, color: Colors.red),
                                SizedBox(height: 20),
                                Text("Confirm Deletion"),
                              ],
                            ),
                          ),
                          content: Container(
                            color: secondaryColor,
                            height: 70,
                            child: Column(
                              children: [
                                Text(
                                    "Are you sure want to delete '${userInfo.name}'?"),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.close,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.grey),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        label: Text("Cancel")),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () {},
                                        label: Text("Delete"))
                                  ],
                                )
                              ],
                            ),
                          ));
                    });
              },
              // Delete
            ),
          ],
        ),
      ),
    ],
  );
}







