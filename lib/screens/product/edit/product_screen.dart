import 'dart:io';

import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/models/Employee.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:smart_admin_dashboard/screens/profile/profiles_home_screen.dart';
import '../../../core/utils/UserPreference.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../core/models/Business.dart';
import '../../../core/utils/responsive.dart';

import '../../dashboard/components/header.dart';
import '../components/product_header.dart';
import 'package:flutter/material.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class ProductScreen extends StatefulWidget {
  ProductScreen({required this.title, required this.code, this.profileId});
  final String title;
  final String code;
  int? profileId;

  @override
  _ProductScreenState createState() => _ProductScreenState(profileId);
}

// class ProductScreen extends StatefulWidget {
class _ProductScreenState extends State<ProductScreen> with SingleTickerProviderStateMixin {


  _ProductScreenState(int? this.profileId);
  int? profileId;

  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;


  List persons = [];
  List original = [];


  Employee employee = Employee.fromJson({});


  TextEditingController txtQuery = new TextEditingController();


  // late int crossAxisCount;
  // late double childAspectRatio;
  // late List<Memo> memosSet = [];
  Color currentColor = Colors.green;

  Business business = Business.fromJson({});
  String? logoPath;

  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  TextEditingController con3 = TextEditingController();
  TextEditingController con4 = TextEditingController();
  TextEditingController con5 = TextEditingController();
  TextEditingController con6 = TextEditingController();
  TextEditingController con7 = TextEditingController();

  Future<void> _initbusiness() async {
    if(profileId!=null) {
      business = await getBusiness(profileId!)??Business.fromJson({});
      if(business.color != null)currentColor = Color(business.color!);
      con1.text = business.name?? "";
      con2.text = business.email ?? "";
      con3.text = business.street ?? "";
      con4.text = business.city ?? "";
      con5.text = business.country ?? "";
      con6.text = business.telephone ?? "";
      con7.text = business.paymentInfo ?? "";
    }else{
      business= Business.fromJson({});
    }

    final directory = await getDownloadPath2();
    if(business.logo!=null)logoPath = "${directory}${business.logo}";
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    _initbusiness();

  }




  @override
  Widget build(BuildContext context) {
    print(business?.toJson().toString());
    print(profileId);
    print(profileId);
    print(profileId);

    // print(widget.code);
    // final Size _size = MediaQuery.of(context).size;
    // crossAxisCount= _size.width < 650 ? 2 : 4;
    // childAspectRatio= _size.width < 650 ? 3 : 3;
    //
    // memosSet = memoInits;
    //
    // for( int i = 0 ; i < memos.length; i++ ) {
    //   if(memos[i].set!="set"){
    //     memosSet.removeWhere((element) => element.code == memos[i].code);
    //     print(i);
    //   }else if(memos.length==0){
    //     memosSet.add(memos[1]);
    //   }
    // }

    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              ProductHeader(title: business.name?? 'Add Product',),
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

                                SizedBox(
                                  height: 200,
                                  child: logoPath ==null ? Image.asset("assets/logo/logo_icon.png", scale:1)
                                      : Image.file(File(logoPath!), scale:1),
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                                    ElevatedButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: defaultColor,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding * 1.5,
                                          vertical:
                                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                        ),
                                      ),
                                      onPressed: () async {
                                        final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);


                                        // var path = await getExternalStorageDirectory();
                                        //
                                        // String p = path.toString();
                                        // p = p.replaceAll("'", '');
                                        String logo = "${getRandomString(5)}_logo.png";

                                        final directory = await getDownloadPath2();
                                        print(directory);
                                        new File("${directory}${logo}").create(recursive: true)
                                            .then((File file) async {
                                          if (image != null) await file.writeAsBytes(await image!.readAsBytes());
                                        });

                                        business.logo = logo;
                                        if(business.name==null) business.name = "N/A";
                                        business.save();

                                        if(business.logo!=null)logoPath = "${directory}${business.logo}";

                                        setState(() {
                                        });

                                      },
                                      child: Text(
                                        "Pick Product Image",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),

                                Responsive.isMobile(context)
                                    ? SizedBox( height: 585,child: Column(
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
                                                  topLabel: "Product Name",
                                                  keyboardType: TextInputType.text,
                                                  kController: con1,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    print(business!.toJson());
                                                    business!.name = value;
                                                  },
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please enter product name.';
                                                    }
                                                    return null;
                                                  },


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
                                                      business!.email = value;
                                                    }


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
                                                    business!.street = value;
                                                  },


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
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {

                                                    business!.city = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },
                                                  kController: con4,


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
                                                    business!.country = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },
                                                  kController: con5,


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
                                                    business!.telephone = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },
                                                  kController: con6,

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
                                                  topLabel: "Payment Info",
                                                  keyboardType: TextInputType.text,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    business!.paymentInfo = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },
                                                  kController: con7,

                                                  // prefixIcon: FlutterIcons.chevron_left_fea,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                          ],),
                                      ],),

                                    ),
                                  ],))
                                    :  Row(
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
                                                  topLabel: "Product Name",
                                                  keyboardType: TextInputType.text,

                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    print(business!.toJson());
                                                    business!.name = value;
                                                  },
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please enter product name.';
                                                    }
                                                    return null;
                                                  },
                                                  kController: con1,


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
                                                    business!.email = value;
                                                  },
                                                  kController: con2,


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
                                                    business!.street = value;
                                                  },
                                                  kController: con3,


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
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {

                                                    business!.city = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },
                                                  kController: con4,

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
                                                    business!.country = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },
                                                  kController: con5,


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
                                                  kController: con6,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    business!.telephone = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },


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
                                                  topLabel: "Payment Info",
                                                  keyboardType: TextInputType.text,
                                                  kController: con7,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    business!.paymentInfo = value;
                                                  },
                                                  validator: (String? value) {
                                                    return (value != null && value.contains('@'))
                                                        ? 'Do not use the @ char.'
                                                        : null;
                                                  },


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
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          print(business!.toJson());
                                          print(widget.code);
                                          try {
                                            if(widget.code == "edit"){
                                              business!.save();
                                            }else{
                                              var businessId = await business!.save();

                                              print('Client id is $businessId');

                                              SharedPreferences prefs = await SharedPreferences.getInstance();

                                              prefs.setInt(UserPreference.activeBusiness, businessId);
                                            }



                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Product saved successfully"),
                                            ));

                                            SchedulerBinding.instance!
                                                .addPostFrameCallback((_) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => ProfileHomeScreen()),
                                              );
                                            });

                                          }catch(e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("An error occured. Check all fields"),
                                            ));
                                          };


                                        }

                                      },
                                      icon: Icon(Icons.save),
                                      label: Text(
                                        "Save Product",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    ElevatedButton.icon(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding * 1.5,
                                          vertical:
                                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (true) {
                                          print(business!.toJson());
                                          print(widget.code);
                                          try {
                                            business.delete();

                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Product deleted"),
                                            ));



                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfileHomeScreen()),
                                            );
                                          }catch(e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("An error occured."),
                                            ));
                                          };

                                          setState(() {

                                          });


                                        }

                                      },
                                      icon: Icon(Icons.cancel),
                                      label: Text(
                                        "Delete Product",
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

Future<String?> getDownloadPath2() async {
  Directory? directory;
  String directoryStr;
  try {
    if (Platform.isIOS ) {
      directory = await getApplicationDocumentsDirectory();
    } else if (Platform.isWindows) {
      directory = await getApplicationDocumentsDirectory();
      directoryStr =  "${directory.path}\\Invoices\\";
      directory = Directory(directoryStr);

    } else {
      // directory = Directory('/storage/emulated/0/Download/Invoices/');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io

      directory = await getExternalStorageDirectory();
    }
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory?.path;
}




