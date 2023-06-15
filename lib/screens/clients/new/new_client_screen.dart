import 'dart:convert';

import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/providers/registration/Employee.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import '../../../common/UserPreference.dart';
import '../../../core/utils/colorful_tag.dart';
import '../../../providers/Memo.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../providers/recent_user_model.dart';
import '../../../providers/registration/Client.dart';
import '../../../providers/registration/Company.dart';
import '../../../providers/registration/Wallet.dart';
import '../../../responsive.dart';

import '../../dashboard/components/header.dart';
import '../../generator/CR6_form_generator.dart';
import '../../generator/register_download_screen.dart';
import '../../home/home_screen.dart';
import '../../invoice/components/header.dart';
import '../../memos/memo_list_material.dart';
import '../clients_home_screen.dart';
import 'components/mini_information_card.dart';

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



  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;


  // List persons = [];
  // List original = [];


  Employee employee = Employee.fromJson({});


  TextEditingController txtQuery = new TextEditingController();





  // late int crossAxisCount;
  // late double childAspectRatio;
  // late List<Memo> memosSet = [];

  Client client = new Client.fromJson({});
  double balance = 0 ;

  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  TextEditingController con3 = TextEditingController();
  TextEditingController con4 = TextEditingController();
  TextEditingController con5 = TextEditingController();
  TextEditingController con6 = TextEditingController();


  Future<void> _initclient() async {

    var prefs = await SharedPreferences.getInstance();

    if(clientId!=null) {
      client = await getClient(clientId);

      con1.text = client.companyName?? "";
      con2.text = client.email ?? "";
      con3.text = client.street ?? "";
      con4.text = client.city ?? "";
      con5.text = client.country ?? "";
      con6.text = client.telephone ?? "";

      var activeCurrency = await prefs!.getString(UserPreference.activeCurrency);

      Wallet wallet = await client.getWallet(client.currency ?? activeCurrency ?? 'USD' );
      print(wallet.toJson());
      balance = wallet.balance! ?? 0;
    }
    setState(() {});
  }


  @override
  void initState() {
    _initclient();

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    print(client?.toJson().toString());
    print(widget.code);

    // print(widget.code);
    final Size _size = MediaQuery.of(context).size;


    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              MiniInformation(title: client.companyName?? 'New Client',),
              SizedBox(height: defaultPadding),
              Text("Balance: \$"+balance.toString(), style: TextStyle(fontSize: 20, color: Colors.white) ),

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
                            minHeight: MediaQuery.of(context).size.height - 0.0,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [

                                SizedBox(height: 16.0),

                                Responsive.isMobile(context)
                                    ? SizedBox( height: 480,child: Column(children: [
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
                                                topLabel: "Company Name",
                                                keyboardType: TextInputType.text,
                                                kController: con1,
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
                                                // kInitialValue: client.companyName ?? "",


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
                                                kController: con2,
                                                keyboardType: TextInputType.text,
                                                onSaved: (String? value) {
                                                  // This optional block of code can be used to run
                                                  // code when the user saves the form.
                                                },
                                                onChanged: (String? value) {
                                                  client!.email = value;
                                                },
                                                // kInitialValue: client!.email ,


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
                                                topLabel: "Address",
                                                kController: con3,
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
                                                  client!.street = value;
                                                },
                                                // kInitialValue: client!.street ,


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
                                                topLabel: "City",
                                                kController: con4,
                                                keyboardType: TextInputType.text,
                                                onSaved: (String? value) {
                                                  // This optional block of code can be used to run
                                                  // code when the user saves the form.
                                                },
                                                onChanged: (String? value) {

                                                  client!.city = value;
                                                },
                                                validator: (String? value) {
                                                  return (value != null && value.contains('@'))
                                                      ? 'Do not use the @ char.'
                                                      : null;
                                                },
                                                // kInitialValue: client!.city,


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
                                                kController: con5,
                                                keyboardType: TextInputType.text,
                                                onSaved: (String? value) {
                                                  // This optional block of code can be used to run
                                                  // code when the user saves the form.
                                                },
                                                onChanged: (String? value) {
                                                  client!.country = value;
                                                },
                                                validator: (String? value) {
                                                  return (value != null && value.contains('@'))
                                                      ? 'Do not use the @ char.'
                                                      : null;
                                                },
                                                // kInitialValue: client!.country,


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
                                                kController: con6,
                                                keyboardType: TextInputType.text,
                                                onSaved: (String? value) {
                                                  // This optional block of code can be used to run
                                                  // code when the user saves the form.
                                                },
                                                onChanged: (String? value) {
                                                  client!.telephone = value;
                                                },
                                                validator: (String? value) {
                                                  return (value != null && value.contains('@'))
                                                      ? 'Do not use the @ char.'
                                                      : null;
                                                },
                                                // kInitialValue: client!.telephone ,


                                                // prefixIcon: FlutterIcons.chevron_left_fea,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                        ],),
                                    ],),

                                  ),
                                ],))
                                    : Row(
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
                                                  topLabel: "Company Name",
                                                  keyboardType: TextInputType.text,
                                                  kController: con1,
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
                                                  // kInitialValue: client.companyName ?? '',


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
                                                  kController: con2,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    client!.email = value;
                                                  },
                                                  // kInitialValue: client!.email ,


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
                                                  topLabel: "Address",
                                                  keyboardType: TextInputType.text,
                                                  kController: con3,
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
                                                    client!.street = value;
                                                  },
                                                  // kInitialValue: client!.street ,


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
                                                  topLabel: "City",
                                                  keyboardType: TextInputType.text,
                                                  kController: con4,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {

                                                    client!.city = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },
                                                  // kInitialValue: client!.city,


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
                                                  kController: con5,
                                                  keyboardType: TextInputType.text,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    client!.country = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },
                                                  // kInitialValue: client!.country,


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
                                                  kController: con6,
                                                  keyboardType: TextInputType.text,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    client!.telephone = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },
                                                  // kInitialValue: client!.telephone ,


                                                  // prefixIcon: FlutterIcons.chevron_left_fea,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                          ],),
                                      ],),

                                    ),
                                  ],),
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




