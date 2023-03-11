import 'dart:convert';

import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/services.dart';
import 'package:smart_admin_dashboard/models/registration/Secretary.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import '../../../core/utils/colorful_tag.dart';
import '../../../models/Memo.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../models/recent_user_model.dart';
import '../../../models/registration/Director.dart';
import '../../../models/registration/Company.dart';
import '../../../responsive.dart';

import '../../generator/CR6_form_generator.dart';
import '../../generator/register_download_screen.dart';
import '../../home/home_screen.dart';
import '../../memos/memo_list_material.dart';
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

    callback(mem, action) {
      if(action=="set"){
        setState(() {
          memoItems.add(mem);
          print(memoItems);
          memosSet.add(memos.where((element) => element.code ==mem).first);


        });
      }else{
        setState(() {
          memoItems.removeWhere((element) => element == mem);
          memosSet.removeWhere((element) => element.code == mem);

          print(memoItems);
        });
      }



    }

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

            SizedBox(height:10),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                    // );
                  },
                  icon: Icon(Icons.send),
                  label: Text(
                    "Publish",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                    // );
                  },
                  icon: Icon(Icons.mail),
                  label: Text(
                    "Publish & Send Email",
                  ),
                ),
              ],
            ),






            SizedBox(height: 16.0),
           //Client and invoice details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  Row(
                    children:[
                      Text( "Client Name: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text( "Kanjan Solutions", style: TextStyle(color: Colors.white),
                      ),
                    ]
                  ),

                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  Row(
                    children:[
                      Text( "Invoice Date: ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                      Text( "10/12/2023", style: TextStyle( color: Colors.white),
                      ),
                    ]
                  ),

                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  Row(
                      children:[
                        Text( "Due Date: ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Text( "10/12/2023", style: TextStyle( color: Colors.white),
                        ),
                      ]
                  ),

                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  Row(
                      children:[
                        Text( "Total Due: ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Text( "\$10", style: TextStyle( color: Colors.white),
                        ),
                      ]
                  ),

                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  Row(
                      children:[
                        Text( "Balance: ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Text( "\$10", style: TextStyle( color: Colors.white),
                        ),
                      ]
                  ),

                ),
              ],
            ),
            SizedBox(height: 50.0),

            //First Director
            Text( "Draft", style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                  Row(
                      children:[
                        Text( "Payment Method: ", style: TextStyle(color: Colors.white),
                        ),
                        Text( "Mail in Payment", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ]
                  ),

                ),
              ],
            ),
            SizedBox(width: 10.0),

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
                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                    // );
                  },
                  icon: Icon(Icons.mail),
                  label: Text(
                    "Send Email",
                  ),
                ),

              ],
            ),
            SizedBox(height: 16.0),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                    // );
                  },
                  icon: Icon(Icons.cancel),
                  label: Text(
                    "Mark Cancelled",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                    // );
                  },
                  icon: Icon(Icons.cancel_outlined),
                  label: Text(
                    "Mark Unpaid",
                  ),
                ),
              ],
            ),
            SizedBox(height:20),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Invoice Items",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SingleChildScrollView(
                    //scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      horizontalMargin: 0,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("Unit"),
                        ),
                        DataColumn(
                          label: Text("Description"),
                        ),
                        DataColumn(
                          label: Text("Unit Price"),
                        ),
                        DataColumn(
                          label: Text("Amount"),
                        ),
                        DataColumn(
                          label: Text("Action"),
                        ),
                      ],
                      rows: List.generate(
                        recentUsers.length,
                            (index) => recentUserDataRow(recentUsers[index], context),
                      ),
                    ),
                ),
              ),
            ],
          ),),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child:SizedBox(width: 600.0)),
                Text("Subtotal"),
                SizedBox(width: 60.0),
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


                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child:SizedBox(width: 600.0)),
                Text("Credit"),
                SizedBox(width: 60.0),
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


                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child:SizedBox(width: 600.0)),
                Text("Total Due"),
                SizedBox(width: 60.0),
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


                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
            SizedBox(height: 16.0),


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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                    // );
                  },
                  icon: Icon(Icons.save),
                  label: Text(
                    "Save Changes",
                  ),
                ),
                SizedBox(width: 15,),





                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                    // );
                  },
                  icon: Icon(Icons.cancel_outlined),
                  label: Text(
                    "Mark Unpaid",
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),


            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Related Payments",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SingleChildScrollView(
                    //scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 0,
                        columnSpacing: defaultPadding,
                        columns: [
                          DataColumn(
                            label: Text("Unit"),
                          ),
                          DataColumn(
                            label: Text("Description"),
                          ),
                          DataColumn(
                            label: Text("Unit Price"),
                          ),
                          DataColumn(
                            label: Text("Amount"),
                          ),
                          DataColumn(
                            label: Text("Action"),
                          ),
                        ],
                        rows: List.generate(
                          recentUsers.length,
                              (index) => recentUserDataRow(recentUsers[index], context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
            //Secretary Ends



            SizedBox(height: 20.0),
            SizedBox(height: 40.0),


            memosSet.length >= 1 ?
            GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: memosSet.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) => MiniMemo(memo: memosSet[index]),
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
                            return new MemoListMaterial(callback: callback);
                          },
                          fullscreenDialog: true));
                    },
                    label: Text("Edit Memo")),
              ],),


            SizedBox(height: 40.0),
            generatorResp!=""?Text(generatorResp):SizedBox(),
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
                // await company.save();
                print(company.toJson());

                var response = await cr6FormGenerator(company, widget.code, memosSet);

                setState(() {
                  generatorResp = response;
                });
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




