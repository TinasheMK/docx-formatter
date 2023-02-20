import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:smart_admin_dashboard/models/registration/Secretary.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:smart_admin_dashboard/screens/register/register_screen.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../models/registration/Director.dart';
import '../../../models/registration/Company.dart';
import '../../../responsive.dart';

import '../../generator/CR6_form_generator.dart';
import '../../generator/register_download_screen.dart';
import '../../home/home_screen.dart';
import './components/mini_information_card.dart';

import '../components/recent_forums.dart';
import '../components/recent_users.dart';
import '../components/user_details_widget.dart';
import 'package:flutter/material.dart';

import '../components/header.dart';
import 'components/dropdown_search.dart';


class NewRegisterScreen extends StatefulWidget {
  NewRegisterScreen({required this.title, required this.code});
  final String title;
  final String code;

  @override
  _NewRegisterScreenState createState() => _NewRegisterScreenState();
}

// class NewRegisterScreen extends StatefulWidget {
class _NewRegisterScreenState extends State<NewRegisterScreen> with SingleTickerProviderStateMixin {
  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;

  var _isMoved = false;

  bool isChecked = false;

  int _value = 1;

  int _directors = 2;

  List persons = [];
  List original = [];

  List<Director> directors = [];
  List<Secretary> secretaries = [Secretary.fromJson({})];


  TextEditingController txtQuery = new TextEditingController();


  late String country;
  late String city;
  late String street;
  late String companyName;

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
    print(widget.code);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [


            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( "Search Existing Clients", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: txtQuery,
                  onChanged: search,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    prefixIcon: Icon(Icons.search, color: greenColor),
                    fillColor: secondaryColor,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, color: greenColor),

                        onPressed: () {
                        txtQuery.text = '';
                        search(txtQuery.text);
                      },
                    ),
                  ),
                ),
              ],
            ),






            SizedBox(height: 8.0),

            Text( "New Client", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
            ),
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
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      companyName = value!;
                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },

                    topLabel: "Company Name",

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
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      street = value!;

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
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      city = value!;

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
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      country = value!;

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
            Text( "First Director Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
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
                    onChanged: (String? value) {
                      if(!directors.asMap().containsKey(0)){
                        directors.add(Director.fromJson({}));
                      }
                      directors[0].name = value;
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
                    onChanged: (String? value) {
                      if(!directors.asMap().containsKey(0)){
                        directors.add(Director.fromJson({}));
                      }
                      directors[0].lastName = value;

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
                    onChanged: (String? value) {
                      if(!directors.asMap().containsKey(0)){
                        directors.add(Director.fromJson({}));
                      }
                      directors[0].nationalId = value;

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
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorStreet = value!;
                      if(!directors.asMap().containsKey(0)){
                        directors.add(Director.fromJson({}));
                      }
                      directors[0].street = value;
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
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorCity = value!;
                      if(!directors.asMap().containsKey(0)){
                        directors.add(Director.fromJson({}));
                      }
                      directors[0].city = value;

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
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorCountry = value!;
                      if(!directors.asMap().containsKey(0)){
                        directors.add(Director.fromJson({}));
                      }
                      directors[0].country = value;


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
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorName = value!;
                      secretaries[0].name = value;

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
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorLastName = value!;
                      secretaries[0].lastName = value;


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
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorLastName = value!;
                      secretaries[0].nationalId = value;


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
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorStreet = value!;
                      secretaries[0].street = value;

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
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorCity = value!;
                      secretaries[0].city = value;


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
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      // directorCountry = value!;
                      secretaries[0].country = value;


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


            _directors>=2? _SecondDirector(context, 2):SizedBox(height:0),
            _directors>=3? _SecondDirector(context, 3):SizedBox(height:0),
            _directors>=4? _SecondDirector(context, 4):SizedBox(height:0),
            _directors>=5? _SecondDirector(context, 5):SizedBox(height:0),
            _directors>=6? _SecondDirector(context, 6):SizedBox(height:0),
            _directors>=7? _SecondDirector(context, 7):SizedBox(height:0),
            _directors>=8? _SecondDirector(context, 8):SizedBox(height:0),
            _directors>=9? _SecondDirector(context, 9):SizedBox(height:0),
            _directors>=10? _SecondDirector(context, 10):SizedBox(height:0),
            _directors>=11? _SecondDirector(context, 11):SizedBox(height:0),
            _directors>=12? _SecondDirector(context, 12):SizedBox(height:0),
            _directors>=13? _SecondDirector(context, 13):SizedBox(height:0),


            SizedBox(height: 40.0),
            AppButton(
              type: ButtonType.PLAIN,
              text: "Add Director",
              onPressed: () {
                _addDirector();
              },
            ),
            SizedBox(height: 40.0),
            AppButton(
              type: ButtonType.PRIMARY,
              text: "Proceed",
              onPressed: () async {

                // List<DailyInfoModel> dailyDatas =
                // dailyData.map((item) => DailyInfoModel.fromJson(item)).toList();


                var register = {
                  "companyName":companyName,
                  "street":street,
                  "city":city,
                  "country":country,
                };
                Company company =  Company.fromJson(register);



                company.directors = directors;
                company.secretaries = secretaries;
                await company.save();
                print(company.toJson());

                cr6FormGenerator(company, widget.code);
              },
            ),
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
                    "Proceed to register company.",
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
            children: [
              Text( "Director "+number.toString()+" Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
              ),
              SizedBox(width: 100),
              TextButton(
                onPressed: () {
                  _removeDirector();
                  directors.removeAt(number-1);

                },
                child: Text("Remove Director",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.redAccent)),
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
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorName = value!;value
                    if(!directors.asMap().containsKey(number-1)){
                        directors.add(Director.fromJson({}));
                    }
                    directors[number-1].name = value;

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
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorLastName = value!;
                    if(!directors.asMap().containsKey(number-1)){
                        directors.add(Director.fromJson({}));
                    }
                    directors[number-1].lastName = value;


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
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorLastName = value!;
                    if(!directors.asMap().containsKey(number-1)){
                      directors.add(Director.fromJson({}));
                    }
                    directors[number-1].nationalId = value;


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
                  onChanged: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    // directorStreet = value!;
                    if(!directors.asMap().containsKey(number-1)){
                        directors.add(Director.fromJson({}));
                    }
                    directors[number-1].street = value;

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
                    if(!directors.asMap().containsKey(number-1)){
                        directors.add(Director.fromJson({}));
                    }
                    directors[number-1].city = value;


                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },

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
                    if(!directors.asMap().containsKey(number-1)){
                        directors.add(Director.fromJson({}));
                    }
                    directors[number-1].country = value;


                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },

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






