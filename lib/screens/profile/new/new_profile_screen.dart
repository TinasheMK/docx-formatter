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
import 'package:smart_admin_dashboard/screens/profile/profile_home_screen.dart';
import '../../../core/utils/UserPreference.dart';
import '../../../core/utils/colorful_tag.dart';
import '../../../core/types/Memo.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../core/types/recent_user_model.dart';
import '../../../core/models/Company.dart';
import '../../../core/models/Company.dart';
import '../../../core/utils/responsive.dart';

import '../../clients/clients_home_screen.dart';
import '../../dashboard/components/header.dart';
import '../../home/home_screen.dart';
import '../../invoice/components/header.dart';
import '../../memos/memo_list_material.dart';
import '../../profile/profiles_home_screen.dart';
import 'components/mini_information_card.dart';

import '../components/recent_users.dart';
import '../components/user_details_widget.dart';
import 'package:flutter/material.dart';

import 'components/dropdown_search.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class NewProfileScreen extends StatefulWidget {
  NewProfileScreen({required this.title, required this.code, this.profileId});
  final String title;
  final String code;
  int? profileId;

  @override
  _NewProfileScreenState createState() => _NewProfileScreenState(profileId);
}

// class NewProfileScreen extends StatefulWidget {
class _NewProfileScreenState extends State<NewProfileScreen> with SingleTickerProviderStateMixin {


  _NewProfileScreenState(int? this.profileId);
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

  Company client = Company.fromJson({});
  String? logoPath;

  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  TextEditingController con3 = TextEditingController();
  TextEditingController con4 = TextEditingController();
  TextEditingController con5 = TextEditingController();
  TextEditingController con6 = TextEditingController();

  Future<void> _initclient() async {
    if(profileId!=null) {
      client = await getCompany(profileId);
      if(client.color != null)currentColor = Color(client.color!);
      con1.text = client.companyName?? "";
      con2.text = client.email ?? "";
      con3.text = client.street ?? "";
      con4.text = client.city ?? "";
      con5.text = client.country ?? "";
      con6.text = client.telephone ?? "";
    }else{
      client= Company.fromJson({});
    }

    final directory = await getDownloadPath2();
    if(client.logo!=null)logoPath = "${directory}${client.logo}";
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    _initclient();

  }




  @override
  Widget build(BuildContext context) {
    print(client?.toJson().toString());
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
              MiniInformation(title: client.companyName?? 'Add Profile',),
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
                                        backgroundColor: Colors.black38,
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

                                        client.logo = logo;
                                        if(client.companyName==null) client.companyName = "N/A";
                                        client.save();

                                        if(client.logo!=null)logoPath = "${directory}${client.logo}";

                                        setState(() {
                                        });

                                      },
                                      child: Text(
                                        "Pick Company Logo",
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              titlePadding: const EdgeInsets.all(0),
                                              contentPadding: const EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: MediaQuery.of(context).orientation == Orientation.portrait
                                                    ? const BorderRadius.vertical(
                                                  top: Radius.circular(500),
                                                  bottom: Radius.circular(100),
                                                )
                                                    : const BorderRadius.horizontal(right: Radius.circular(500)),
                                              ),
                                              content: SingleChildScrollView(
                                                child: HueRingPicker(
                                                  pickerColor: currentColor,
                                                  onColorChanged: (color){
                                                    currentColor = color;
                                                    // print(color.value);
                                                    client.color = color.value;
                                                    setState(() {

                                                    });
                                                  },
                                                  enableAlpha: true,
                                                  displayThumbColor: true,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        'Brand Color',
                                        style: TextStyle(color: useWhiteForeground(currentColor) ? Colors.white : Colors.black),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: currentColor,
                                        shadowColor: currentColor.withOpacity(1),
                                        elevation: 10,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 16.0),

                                Responsive.isMobile(context)
                                    ? SizedBox( height: 480,child: Column(
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
                                                  topLabel: "Company Profile Name",
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
                                                    client!.street = value;
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

                                                    client!.city = value;
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
                                                    client!.country = value;
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
                                                    client!.telephone = value;
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
                                                  topLabel: "Company Name",
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
                                                    client!.email = value;
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
                                                    client!.street = value;
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

                                                    client!.city = value;
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
                                                    client!.country = value;
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
                                                    client!.telephone = value;
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
                                          print(client!.toJson());
                                          print(widget.code);
                                          try {
                                            if(widget.code == "edit"){
                                              client!.update();
                                            }else{
                                              var clientId = await client!.save();

                                              print('Client id is $clientId');

                                              SharedPreferences prefs = await SharedPreferences.getInstance();

                                              prefs.setInt(UserPreference.activeCompany, clientId);
                                            }



                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Company saved successfully"),
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
                                        "Save Company",
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
                                          print(client!.toJson());
                                          print(widget.code);
                                          try {
                                            client.delete();

                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Company deleted"),
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
                                        "Delete Company",
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




