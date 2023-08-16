import 'dart:convert';

import 'package:docxform/core/models/Objective.dart';
import 'package:flutter/services.dart';
import '../../../core/models/Client.dart';
import '../../../core/models/Client.dart';
import '../../../core/models/Director.dart';


import '../../../core/constants/color_constants.dart';
import '../../../core/models/Secretary.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../core/utils/responsive.dart';

import '../../../core/utils/company_reg_doc_generator.dart';
import '../../dashboard/components/header.dart';
import '../../dashboard/home_screen.dart';
import '../components/client_selector.dart';
import './components/mini_information_card.dart';

import 'package:flutter/material.dart';

import 'components/dropdown_search.dart';


class NewRegisterScreen extends StatefulWidget {
  NewRegisterScreen({required this.title, required this.code, this.companyId});
  final String title;
  final String code;
  final int? companyId;

  @override
  _NewRegisterScreenState createState() => _NewRegisterScreenState(companyId);
}

// class NewRegisterScreen extends StatefulWidget {
class _NewRegisterScreenState extends State<NewRegisterScreen> with SingleTickerProviderStateMixin {
  _NewRegisterScreenState(this.companyId);

  final int? companyId;
  bool isChecked = false;
  bool secEdited = false;
  int _directors = 2;
  List persons = [];
  List original = [];
  List<Client> clients = [Client.fromJson({})];
  TextEditingController txtQuery = new TextEditingController();
  late int crossAxisCount;
  late double childAspectRatio;
  List<Objective> objectives = [];
  final _formKey = GlobalKey<FormState>();
  List<String> memoItems = [];
  Client client = Client.fromJson({});
  List<List<TextEditingController>> secCntrl = [[TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]] ;
  List<List<TextEditingController>> dirCntrl = [[TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]] ;
  List<TextEditingController> coCntrl = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()] ;

  void loadData() async {
    clients = await getClients();
    if(companyId!=null)client = (await getClient(companyId!))!;

    if(client!.directors==null  || client!.directors!.length<1  ){
      client.directors = [Director.fromJson({
        "country": "Zimbabwe",
        "city": "Harare",
      }),Director.fromJson({
        "country": "Zimbabwe",
        "city": "Harare",
      })];
    }
    if(client!.secretaries==null || client!.secretaries!.length<1 ){
      client.secretaries = [Secretary.fromJson({
        "country": "Zimbabwe",
        "city": "Harare",
      })];
    }

    if(client.country==null)client.country="Zimbabwe";
    if(client.city==null)client.city="Harare";


    dirCntrl = [];
    secCntrl = [];

    coCntrl[0].text = client.name??"";
    coCntrl[1].text = client.street??"";
    coCntrl[2].text = client.city??"";
    coCntrl[3].text = client.country??"";

    client!.directors?.forEach((e) {
      var cntrl = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];

      cntrl[0].text = e.name??"";
      cntrl[1].text = e.lastName??"";
      cntrl[2].text = e.nationalId??"";
      cntrl[3].text = e.street??"";
      cntrl[4].text = e.city??"";
      cntrl[5].text = e.country??"";

      dirCntrl?.add(cntrl);
    });
    client!.secretaries?.forEach((e) {
      var cntrl = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];

      cntrl[0].text = e.name??"";
      cntrl[1].text = e.lastName??"";
      cntrl[2].text = e.nationalId??"";
      cntrl[4].text = e.city??"";
      cntrl[5].text = e.country??"";

      secCntrl?.add(cntrl);
    });



    setState(() {});
  }

  void _addDirector() {
    setState(() {
      _directors += 1;
        client.directors!.add(Director.fromJson({
          "country": "Zimbabwe",
          "city": "Harare",
        }));
      var cntrl = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(text: "Harare"), TextEditingController(text: "Zimbabwe")];
      dirCntrl?.add(cntrl);

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

  void _printLatestValue() {

    secCntrl.forEach((e) {
      e.forEach((a) {
        print('Text field: ${a.text}');
      });

    });

  }

  @override
  void initState() {
    secCntrl[0][4].text = "Harare";
    secCntrl[0][5].text = "Zimbabwe";
    super.initState();

    loadData();


    secCntrl.forEach((e) {
      e.forEach((a) {
        a.addListener(_printLatestValue);
      });
    });

  }

  @override
  void dispose() {
    secCntrl.forEach((e) {
      e.forEach((a) {
        a.dispose();
      });
    });
    super.dispose();
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

    callback(mem, action) async {
      if(action=="set"){
          var objective = await getObjective(int.parse(mem));
        setState(()  {
          objectives.removeWhere((e) => e.id ==int.parse(mem));
          if(objective!=null)objectives.add(objective);
        });
      }else{
        setState(() {
          objectives.removeWhere((element) => element.id == int.parse(mem));
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

            Row(
              children: [

              ],
            ),
            SizedBox(height: 16.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    kController: coCntrl[0],
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      client.name = value!;
                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Client Name",

                    hintText: "Enter Name",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },kController: coCntrl[1],
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      client.street = value!;

                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Street",

                    hintText: "Enter Street Address",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                )
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },kController: coCntrl[2],
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      client.city = value!;

                    },

                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "City",

                    hintText: "Enter City Name",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },kController: coCntrl[3],
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      client.country = value!;

                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Country",

                    hintText: "Enter Country",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                )
              ],
            ),

            SizedBox(height: 50.0),

            //First Director
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text( "Director 1 Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                ),
                SizedBox(width: 100),
                !(client!.directors?[0].shareholder??false)
                    ?
                TextButton(
                  onPressed: () {
                    setState(() {
                      client!.directors![0].shareholder = true;

                    });

                  },
                  child: Text("Make Shareholder",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.blue)),
                )
                    :
                SizedBox(
                  width: 150,
                  child:
                  TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (String? value) {
                        print(value);
                        if(value == ''){
                          setState(() {

                            client!.directors![0].shareholder = false;
                          });
                        }else{
                          client!.directors![0].shares = int.parse(value!);

                        }

                      },
                      validator: (String? value) {
                        return (value != null && value.contains('@'))
                            ? 'Do not use the @ char.'
                            : null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(74, 77, 84, 0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          //gapPadding: 16,
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        errorStyle: TextStyle(height: 0, color: Colors.transparent),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          //gapPaddings: 16,
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                        hintText: "Shares",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white54),

                      )
                    // topLabel: "Shares",

                    // hintText: "Enter Shares",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    kController: dirCntrl[0][0],
                    onChanged: (String? value) {
                      if(!client!.directors!.asMap().containsKey(0)){
                        client!.directors!.add(Director.fromJson({}));
                      }
                      client!.directors![0].name = value;

                      if(!secEdited){
                        client!.secretaries![0].name = value;
                        setState(() {
                          secCntrl[0][0].text = value.toString();
                        });
                      }

                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "First Director First Name",

                    hintText: "Enter First Name",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    kController: dirCntrl[0][1],
                    onChanged: (String? value) {
                      if(!client!.directors!.asMap().containsKey(0)){
                        client!.directors!.add(Director.fromJson({}));
                      }
                      client!.directors![0].lastName = value;

                      if(!secEdited){
                        client!.secretaries![0].lastName = value;
                        setState(() {
                          secCntrl[0][1].text = value.toString();
                        });
                      }

                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "First Director Last Name",

                    hintText: "Enter Last Name",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    kController: dirCntrl[0][2],
                    onChanged: (String? value) {
                      if(!client!.directors!.asMap().containsKey(0)){
                        client!.directors!.add(Director.fromJson({}));
                      }
                      client!.directors![0].nationalId = value;

                      if(!secEdited){
                        client!.secretaries![0].nationalId = value;
                        setState(() {
                          secCntrl[0][2].text = value.toString();
                        });
                      }

                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "First Director id",

                    hintText: "Enter id",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                )
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    kController: dirCntrl[0][3],
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorStreet = value!;
                      if(!client!.directors!.asMap().containsKey(0)){
                        client!.directors!.add(Director.fromJson({}));
                      }
                      client!.directors![0].street = value;
                      if(!secEdited){
                        client!.secretaries![0].street = value;
                        setState(() {
                          secCntrl[0][3].text = value.toString();
                        });
                      }
                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "First Director Street Address",

                    hintText: "Enter Street Address",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    kController: dirCntrl[0][4],
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorCity = value!;
                      if(!client!.directors!.asMap().containsKey(0)){
                        client!.directors!.add(Director.fromJson({}));
                      }
                      client!.directors![0].city = value;
                      if(!secEdited){
                        client!.secretaries![0].city = value;
                        setState(() {
                          secCntrl[0][4].text = value.toString();
                        });
                      }

                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "First Director City",

                    hintText: "Enter City",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    kController: dirCntrl[0][5],
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorCountry = value!;
                      if(!client!.directors!.asMap().containsKey(0)){
                        client!.directors!.add(Director.fromJson({}));
                      }
                      client!.directors![0].country = value;
                      if(!secEdited){
                        client!.secretaries![0].country = value;
                        setState(() {
                          secCntrl[0][5].text = value.toString();
                        });
                      }


                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "First Director Country",

                    hintText: "Enter Country",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                )
              ],
            ),
            //First Director Ends

            SizedBox(height: 50.0),
            client.directors!.length>=2? _SecondDirector(context, 2):SizedBox(height:0),
            client.directors!.length>=3? _SecondDirector(context, 3):SizedBox(height:0),
            client.directors!.length>=4? _SecondDirector(context, 4):SizedBox(height:0),
            client.directors!.length>=5? _SecondDirector(context, 5):SizedBox(height:0),
            client.directors!.length>=6? _SecondDirector(context, 6):SizedBox(height:0),
            client.directors!.length>=7? _SecondDirector(context, 7):SizedBox(height:0),
            client.directors!.length>=8? _SecondDirector(context, 8):SizedBox(height:0),
            client.directors!.length>=9? _SecondDirector(context, 9):SizedBox(height:0),
            client.directors!.length>=10? _SecondDirector(context, 10):SizedBox(height:0),
            client.directors!.length>=11? _SecondDirector(context, 11):SizedBox(height:0),
            client.directors!.length>=12? _SecondDirector(context, 12):SizedBox(height:0),
            client.directors!.length>=13? _SecondDirector(context, 13):SizedBox(height:0),


            SizedBox(height: 20.0),
            Row(
              children: [

                ElevatedButton.icon(
                    icon: Icon(
                      Icons.add,
                      size: 14,
                    ),
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20),
                        primary: Colors.green),
                    onPressed: () {
                      _addDirector();
                    },
                    label: Text("Add Director")),
              ],),
            SizedBox(height: 20.0),

            //Secretary
            Text( "Secretary Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    kController: secCntrl[0][0],

                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorName = value!;
                      client!.secretaries![0].name = value;
                      secEdited = true;

                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Secretary First Name",

                    hintText: "Enter First Name",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    kController: secCntrl[0][1],
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorLastName = value!;
                      client!.secretaries![0].lastName = value;
                      secEdited = true;


                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Secretary Last Name",

                    hintText: "Enter Last Name",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    kController: secCntrl[0][2],
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorLastName = value!;
                      client!.secretaries![0].nationalId = value;
                      secEdited = true;


                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Secretary id",

                    hintText: "Enter id",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                )
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    kController: secCntrl[0][3],
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorStreet = value!;
                      client!.secretaries![0].street = value;
                      secEdited = true;

                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Secretary Street Address",

                    hintText: "Enter Street Address",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    kController: secCntrl[0][4],
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorCity = value!;
                      client!.secretaries![0].city = value;
                      secEdited = true;


                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Secretary City",

                    hintText: "Enter City",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child:
                  InputWidget(
                    keyboardType: TextInputType.text,
                    kController: secCntrl[0][5],
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorCountry = value!;
                      client!.secretaries![0].country = value;
                      secEdited = true;


                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Secretary Country",

                    hintText: "Enter Country",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                )
              ],
            ),
            //Secretary Ends



            SizedBox(height: 40.0),


            objectives.length >= 1 ?
            GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: objectives.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) => MiniMemo(memo: objectives[index], callback: callback),
              )
            :SizedBox(
                height: 20.0,
                child:
                Text("Add Memorandum Items")
            ),
            SizedBox(height: 15.0),

            Row(
              children: [

                ElevatedButton.icon(
                    icon: Icon(
                      Icons.close,
                      size: 14,
                    ),
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20),
                        primary: Colors.blueAccent),
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                            return new ClientSelector(callback: callback);
                          },
                          fullscreenDialog: true));
                    },
                    label: Text("Edit Objectives")),
              ],),


            SizedBox(height: 40.0),
            // generatorResp!=""?Text(generatorResp):SizedBox(),
            ElevatedButton.icon(
                icon: Icon(
                  Icons.close,
                  size: 14,
                ),
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20),
                    primary: Colors.lightGreen),
                onPressed: () async {
                  // print("Generating docs.");
                  if (_formKey.currentState!.validate()) {}


                  client!.directors!.removeWhere((e) => e.name == null);
                  client!.secretaries!.removeWhere((e) => e.name == null);

                  await client.save();
                  print(client.toJson());

                  var response = await cr6FormGenerator(client, widget.code, objectives);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(response),
                  ));

                },
                label: Text("Generate docs")),

            SizedBox(height: 24.0),
            // AppButton(
            //   type: ButtonType.PRIMARY,
            //   text: "Back",
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => DashboardScreen()),
            //     );
            //   },
            // ),
            SizedBox(height: 24.0),
            SizedBox(height: 24.0),
            Center(
              child: Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Proceed to register client.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     if (_isMoved) {
                  //       _animationController!.reverse();
                  //     } else {
                  //       _animationController!.forward();
                  //     }
                  //     _isMoved = !_isMoved;
                  //   },
                  //   child: Text("Sign In",
                  //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  //           fontWeight: FontWeight.w400, color: greenColor)),
                  // )
                ],
              ),
            ),
            // _listView(persons),
          ],
        ),
      ),
    );
  }


  Widget _SecondDirector(BuildContext context, int number) {
    return
      Column(
        children:[
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text( "Director "+number.toString()+" Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
              ),
              SizedBox(width: 100),
              TextButton(
                onPressed: () {
                  _removeDirector();
                  client!.directors!.removeAt(number-1);

                },
                child: Text("Remove Director",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.redAccent)),
              ),
              !(client!.directors?[number-1].shareholder??false)
                  ?
              TextButton(
                onPressed: () {
                  setState(() {
                    client!.directors![number-1].shareholder = true;

                  });

                },
                child: Text("Make Shareholder",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.blue)),
              )
                  :
              SizedBox(
                width: 150,
                child:
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (String? value) {
                    print(value);
                    if(value == ''){
                      setState(() {

                        client!.directors![number-1].shareholder = false;
                      });
                    }else{
                      client!.directors![number-1].shares = int.parse(value!);

                    }

                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(74, 77, 84, 0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        //gapPadding: 16,
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      errorStyle: TextStyle(height: 0, color: Colors.transparent),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        //gapPaddings: 16,
                        borderSide: BorderSide(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                      hintText: "Shares",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white54),

                  )
                  // topLabel: "Shares",

                  // hintText: "Enter Shares",
                  // prefixIcon: FlutterIcons.chevron_left_fea,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  kController: dirCntrl[number-1][0],
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorName = value!;value
                    if(!client!.directors!.asMap().containsKey(number-1)){
                        client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number-1].name = value;

                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },

                  topLabel: "Director First Name",

                  hintText: "Enter First Name",
                  // prefixIcon: FlutterIcons.chevron_left_fea,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  kController: dirCntrl[number-1][1],
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorLastName = value!;
                    if(!client!.directors!.asMap().containsKey(number-1)){
                      client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number-1].lastName = value;


                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },

                  topLabel: "Director Last Name",

                  hintText: "Enter Last Name",
                  // prefixIcon: FlutterIcons.chevron_left_fea,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  kController: dirCntrl[number-1][2],
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorLastName = value!;
                    if(!client!.directors!.asMap().containsKey(number-1)){
                      client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number-1].nationalId = value;


                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },

                  topLabel: "Director id",

                  hintText: "Enter id",
                  // prefixIcon: FlutterIcons.chevron_left_fea,
                ),
              )
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  kController: dirCntrl[number-1][3],
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorStreet = value!;
                    if(!client!.directors!.asMap().containsKey(number-1)){
                        client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number-1].street = value;

                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },

                  topLabel: "Director Street Address",

                  hintText: "Enter Street Address",
                  // prefixIcon: FlutterIcons.chevron_left_fea,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorCity = value!;
                    if(!client!.directors!.asMap().containsKey(number-1)){
                        client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number-1].city = value;


                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                  kController: dirCntrl[number-1][4],

                  topLabel: "Director City",

                  hintText: "Enter City",
                  // prefixIcon: FlutterIcons.chevron_left_fea,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorCountry = value!;
                    if(!client!.directors!.asMap().containsKey(number-1)){
                        client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number-1].country = value;


                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                  kController: dirCntrl[number-1][5],

                  topLabel: "Director Country",

                  hintText: "Enter Country",
                  // prefixIcon: FlutterIcons.chevron_left_fea,
                ),
              )
            ],
          ),
          SizedBox(height: 40.0),
        ],

      );
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
    required this.memo, required this.callback
  }) : super(key: key);
  final Objective memo;
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




