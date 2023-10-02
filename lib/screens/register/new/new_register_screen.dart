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
  List<Client> clients = [Client(objectives: [])];
  TextEditingController txtQuery = new TextEditingController();
  late int crossAxisCount;
  late double childAspectRatio;
  // List<Objective> client.objectives! = [];
  final _formKey = GlobalKey<FormState>();
  List<String> memoItems = [];
  Client client = Client(objectives: []);
  List<List<TextEditingController>> secCntrl = [[TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]] ;
  List<List<TextEditingController>> dirCntrl = [[TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]] ;
  List<TextEditingController> coCntrl = [
    TextEditingController(),TextEditingController(),
    TextEditingController(),TextEditingController(),
    TextEditingController(),TextEditingController(),
    TextEditingController(),TextEditingController(),
    TextEditingController(),TextEditingController()
  ] ;

  void loadData() async {
    clients = await getClients();
    if(companyId!=null) {
      secEdited=true;
      client = (await getClient(companyId!))!;

    }

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

    coCntrl[4].text = client.entitynum??"";
    coCntrl[5].text = client.oldaddress??"";
    coCntrl[6].text = client.oldemail??"";
    coCntrl[7].text = client.newaddress??"";
    coCntrl[8].text = client.newpostal??"";
    coCntrl[9].text = client.email??"";

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
      cntrl[3].text = e.street??"";
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
          client.objectives!.removeWhere((e) => e.id ==int.parse(mem));
          if(objective!=null)client.objectives!.add(objective);
        });
      }else{

        for(int i =0; i<client!.objectives!.length; i++){
          if(client.objectives![i].id == int.parse(mem)){
            await client.objectives![i].detach(client.id);
          }
        }


        setState(() {
          client.objectives!.removeWhere((element) => element.id == int.parse(mem));

        });
      }



    }

    Cr5Form(){
      return Column(
        children: [
          // CR5
          Text( "Fill In For CR5 Form", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Expanded(
              //   child:
              //   InputWidget(
              //     keyboardType: TextInputType.text,
              //     onSaved: (String? value) {
              //     },
              //     kController: coCntrl[4],
              //
              //     onChanged: (String? value) {
              //       client!.entitynum = value;
              //
              //
              //     },
              //     validator: (String? value) {
              //       return (value != null && value.contains('@'))
              //           ? 'Do not use the @ char.'
              //           : null;
              //     },
              //
              //     topLabel: "No of entity",
              //
              //     hintText: "No of entity",
              //   ),
              // ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                  },
                  kController: coCntrl[5],
                  onChanged: (String? value) {
                    client!.oldaddress = value;



                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },

                  topLabel: "Previous address",

                  hintText: "Enter previous address",
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  kController: coCntrl[6],
                  onSaved: (String? value) {
                  },
                  onChanged: (String? value) {
                    client!.oldemail = value;



                  },
                  validator: (String? value) {
                    // return (value != null && value.contains('@'))
                    //     ? 'Do not use the @ char.'
                    //     : null;
                  },

                  topLabel: "Previous email",

                  hintText: "Enter previous email",
                ),
              )
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Expanded(
              //   child:
              //   InputWidget(
              //     keyboardType: TextInputType.text,
              //     kController: coCntrl[7],
              //     onSaved: (String? value) {
              //     },
              //     onChanged: (String? value) {
              //       // directorStreet = value!;
              //       client!.newaddress = value;
              //
              //
              //     },
              //     validator: (String? value) {
              //       return (value != null && value.contains('@'))
              //           ? 'Do not use the @ char.'
              //           : null;
              //     },
              //
              //     topLabel: "New Address",
              //
              //     hintText: "Enter new Address",
              //   ),
              // ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  kController: coCntrl[8],
                  onSaved: (String? value) {
                  },
                  onChanged: (String? value) {
                    // directorCity = value!;
                    client!.newpostal = value;



                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },

                  topLabel: "Postal Address",

                  hintText: "Enter  postal address",
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  kController: coCntrl[9],
                  onSaved: (String? value) {
                  },
                  onChanged: (String? value) {
                    // directorCountry = value!;
                    client!.email = value;



                  },
                  validator: (String? value) {
                    // return (value != null && value.contains('@'))
                    //     ? 'Do not use the @ char.'
                    //     : null;
                  },

                  topLabel: "New email",

                  hintText: "Enter new email",
                ),
              )
            ],
          ),
          //CR5 Ends
        ],
      );
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
            SizedBox(height: 8.0),
            Cr5Form(),


            SizedBox(height: 50.0),

            Column(
              children: List.generate(
                (client.directors?.length)??0,
                    (index) =>_SecondDirector(context, index),
              ),
            ),

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


                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Secretary Full Name",

                    hintText: "Enter Full Name",
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                // SizedBox(width: 16.0),
                // Expanded(
                //   child:
                //   InputWidget(
                //     keyboardType: TextInputType.text,
                //     onSaved: (String? value) {
                //       // This optional block of code can be used to run
                //       // code when the user saves the form.
                //     },
                //     kController: secCntrl[0][1],
                //     onChanged: (String? value) {
                //       // This optional block of code can be used to run
                //       // code when the user saves the form.
                //       // directorLastName = value!;
                //       client!.secretaries![0].lastName = value;
                //
                //
                //
                //     },
                //     validator: (String? value) {
                //       return (value != null && value.contains('@'))
                //           ? 'Do not use the @ char.'
                //           : null;
                //     },
                //
                //     topLabel: "Secretary Last Name",
                //
                //     hintText: "Enter Last Name",
                //     // prefixIcon: FlutterIcons.chevron_left_fea,
                //   ),
                // ),
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


            client.objectives!.length >= 1 ?
            GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: client.objectives!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) => ObjectiveTile(memo: client.objectives![index], callback: callback),
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
                    label: Text("Edit client objectives!")),
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
                  await client.save();
                  print(client.toJson());

                  var response = await cr6FormGenerator(client, widget.code, client.objectives!);

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
              Text( "Director "+(number+1).toString()+" Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
              ),
              SizedBox(width: 100),
              TextButton(
                onPressed: () {
                  _removeDirector();
                  client!.directors![number].delete();
                  client!.directors!.removeAt(number);


                },
                child: Text("Remove Director",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.redAccent)),
              ),
              !(client!.directors?[number].shareholder??false)
                  ?
              TextButton(
                onPressed: () {
                  setState(() {
                    client!.directors![number].shareholder = true;

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
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (String? value) {
                    print(value);
                    if(value == ''){
                      setState(() {

                        client!.directors![number].shareholder = false;
                      });
                    }else{
                      client!.directors![number].shares = int.parse(value!);

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
                  },
                  kController: dirCntrl[number][0],
                  onChanged: (String? value) {
                    if(!client!.directors!.asMap().containsKey(number)){
                        client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number].name = value;

                    if(!secEdited && number == 0 ){
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

                  topLabel: "Director Full Name",

                  hintText: "Enter Full Name",
                ),
              ),
              SizedBox(width: 16.0),
              // Expanded(
              //   child:
              //   InputWidget(
              //     keyboardType: TextInputType.text,
              //     onSaved: (String? value) {
              //     },
              //     kController: dirCntrl[number][1],
              //     onChanged: (String? value) {
              //       if(!client!.directors!.asMap().containsKey(number)){
              //         client!.directors!.add(Director.fromJson({}));
              //       }
              //       client!.directors![number].lastName = value;
              //
              //
              //     },
              //     validator: (String? value) {
              //       return (value != null && value.contains('@'))
              //           ? 'Do not use the @ char.'
              //           : null;
              //     },
              //
              //     topLabel: "Director Last Name",
              //
              //     hintText: "Enter Last Name",
              //   ),
              // ),
              // SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                  },
                  kController: dirCntrl[number][2],
                  onChanged: (String? value) {
                    if(!client!.directors!.asMap().containsKey(number)){
                      client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number].nationalId = value;
                    if(!secEdited&& number ==0){
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

                  topLabel: "Director id",

                  hintText: "Enter id",
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
                  },
                  kController: dirCntrl[number][3],
                  onChanged: (String? value) {
                    // directorStreet = value!;
                    if(!client!.directors!.asMap().containsKey(number)){
                        client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number].street = value;

                    if(!secEdited&& number ==0){
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

                  topLabel: "Director Street Address",

                  hintText: "Enter Street Address",
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                  },
                  onChanged: (String? value) {
                    // directorCity = value!;
                    if(!client!.directors!.asMap().containsKey(number)){
                        client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number].city = value;

                    if(!secEdited&&number==0){
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
                  kController: dirCntrl[number][4],

                  topLabel: "Director City",

                  hintText: "Enter City",
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child:
                InputWidget(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                  },
                  onChanged: (String? value) {
                    // directorCountry = value!;
                    if(!client!.directors!.asMap().containsKey(number)){
                        client!.directors!.add(Director.fromJson({}));
                    }
                    client!.directors![number].country = value;
                    if(!secEdited&&number==0){
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
                  kController: dirCntrl[number][5],

                  topLabel: "Director Country",

                  hintText: "Enter Country",
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





class ObjectiveTile extends StatefulWidget {
  const ObjectiveTile({
    Key? key,
    required this.memo, required this.callback
  }) : super(key: key);
  final Objective memo;
  final Function(String, String) callback;


  @override
  _ObjectiveTileState createState() => _ObjectiveTileState();
}

class _ObjectiveTileState extends State<ObjectiveTile> {
  bool _visible = false;


  int charLength = 0;

  bool status = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child:Container(
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.memo.set=="set"?darkgreenColor:Colors.black38,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
            ],
          ),
        ) ,
        onTap: () {
          // _toggle();
          widget.callback(widget.memo.id.toString()!, "not");



        }
    );
  }

}




