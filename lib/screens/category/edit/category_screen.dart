
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/UserPreference.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/input_widget.dart';

import '../../../core/models/Category.dart';
import '../../../core/models/Employee.dart';
import '../../../core/models/Wallet.dart';
import '../../../core/utils/responsive.dart';
import '../../dashboard/components/header.dart';
import '../categorys_home_screen.dart';
import '../components/category_header.dart';
import 'package:flutter/material.dart';


class CategoryScreen extends StatefulWidget {
  CategoryScreen({required this.title, required this.code, this.categoryId});
  final String title;
  final String code;
  int? categoryId;

  @override
  _CategoryScreenState createState() => _CategoryScreenState(categoryId);
}

// class CategoryScreen extends StatefulWidget {
class _CategoryScreenState extends State<CategoryScreen> with SingleTickerProviderStateMixin {
  _CategoryScreenState(int? this.categoryId);
  int? categoryId;



  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;


  // List persons = [];
  // List original = [];


  Employee employee = Employee.fromJson({});


  TextEditingController txtQuery = new TextEditingController();





  // late int crossAxisCount;
  // late double childAspectRatio;
  // late List<Memo> memosSet = [];

  Category category = new Category.fromJson({});
  double balance = 0 ;

  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  TextEditingController con3 = TextEditingController();
  TextEditingController con4 = TextEditingController();
  TextEditingController con5 = TextEditingController();
  TextEditingController con6 = TextEditingController();


  Future<void> _initcategory() async {

    var prefs = await SharedPreferences.getInstance();

    if(categoryId!=null) {
      category = await getCategory(categoryId!)??Category.fromJson({});

      con1.text = category.name?? "";
      con3.text = category.description ?? "";

      var activeCurrency = await prefs!.getString(UserPreference.activeCurrency);

    }
    setState(() {});
  }


  @override
  void initState() {
    _initcategory();

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    print(category?.toJson().toString());
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
              CategoryHeader(title: category.name?? 'New Category',),
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
                                                topLabel: "Category Name",
                                                keyboardType: TextInputType.text,
                                                kController: con1,
                                                onSaved: (String? value) {
                                                  // This optional block of code can be used to run
                                                  // code when the user saves the form.
                                                },
                                                onChanged: (String? value) {
                                                  print(category!.toJson());
                                                  category!.name = value;
                                                },
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter business name.';
                                                  }
                                                  return null;
                                                },
                                                // kInitialValue: category.name ?? "",


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
                                                kController: con3,
                                                keyboardType: TextInputType.text,
                                                onSaved: (String? value) {
                                                  // This optional block of code can be used to run
                                                  // code when the user saves the form.
                                                },
                                                onChanged: (String? value) {
                                                  // This optional block of code can be used to run
                                                  // code when the user saves the form.
                                                  // directordescription = value!;
                                                  //
                                                  //
                                                  category!.description = value;
                                                },
                                                // kInitialValue: category!.description ,


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
                                                  topLabel: "Business Name",
                                                  keyboardType: TextInputType.text,
                                                  kController: con1,
                                                  onSaved: (String? value) {
                                                    // This optional block of code can be used to run
                                                    // code when the user saves the form.
                                                  },
                                                  onChanged: (String? value) {
                                                    print(category!.toJson());
                                                    category!.name = value;
                                                  },
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please enter business name.';
                                                    }
                                                    return null;
                                                  },
                                                  // kInitialValue: category.name ?? '',


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
                                                    // directordescription = value!;
                                                    //
                                                    //
                                                    category!.description = value;
                                                  },
                                                  // kInitialValue: category!.description ,


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
                                        backgroundColor: defaultColor,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding * 1.5,
                                          vertical:
                                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          print(category!.toJson());
                                          print(widget.code);
                                          try {
                                            if(widget.code == "edit"){
                                              category!.save();
                                            }else{
                                              category!.save();
                                            }

                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Category saved successfully"),
                                            ));

                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => CategorysHomeScreen()),
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
                                        "Save Category",
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




