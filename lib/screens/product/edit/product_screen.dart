import 'dart:io';

import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/models/Category.dart';
import 'package:smart_admin_dashboard/core/models/Employee.dart';
import 'package:smart_admin_dashboard/core/types/daily_info_model.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:smart_admin_dashboard/screens/product/products_home_screen.dart';
import 'package:smart_admin_dashboard/screens/profile/profiles_home_screen.dart';
import '../../../core/utils/UserPreference.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../core/models/Product.dart';
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
  var addCategory = false;

  String name = "";
  String desc = "";



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

  Product product = Product.fromJson({});
  List<Category> categories = [];

  String? imagePath;

  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  TextEditingController con3 = TextEditingController();
  TextEditingController con4 = TextEditingController();
  TextEditingController con5 = TextEditingController();
  TextEditingController con6 = TextEditingController();
  TextEditingController con7 = TextEditingController();

  Future<void> _initproduct() async {
    categories = await getCategorys();

    if(profileId!=null) {
      categories.clear();
      product = await getProduct(profileId!)??Product.fromJson({});
      con1.text = product.name??"";
      con2.text = product.price?.toString() ?? "";
      con3.text = product.sku ?? "";
      con4.text = product.stock?.toString()?? "";
      // con4.text = product.category ?? "";
    }else{
      product= Product.fromJson({});
    }

    final directory = await getDownloadPath2();
    // if(product.image!=null)imagePath = "${directory}${product.image}";
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    _initproduct();

  }




  @override
  Widget build(BuildContext context) {
    print(product?.toJson().toString());
    print(profileId);
    print(profileId);
    print(profileId);

    categoryList(){
      return       showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children:
                          List.generate(
                              categories.length,
                                  (index) =>


                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    // padding: EdgeInsets.symmetric(
                                    //   horizontal: defaultPadding,
                                    //   vertical: defaultPadding / 2,
                                    // ),
                                    decoration: BoxDecoration(
                                      // color: secondaryColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(),
                                    ),
                                    child: TextButton(
                                      child: Text(categories[index].name??''),
                                      onPressed: () {
                                        product.categoryId = categories[index].id;
                                        product.category = categories[index];
                                        setState(() {});
                                        Navigator.of(context).pop();
                                      },
                                      // Delete
                                    ),

                                  )
                          ),


                        ),
                      ),
                      if(!addCategory)ElevatedButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical:
                            defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                          ),
                        ),
                        onPressed: () async {
                          addCategory = true;
                          Navigator.of(context).pop();
                          categoryList();


                        },
                        icon: Icon(Icons.add),
                        label: Text(
                          "Add",
                        ),
                      ),
                      addCategory ? Container(
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: darkgreenColor,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 3),
                            SizedBox(width: 300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Expanded(
                                    child:
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:[
                                          Text( "Category Name:          ",
                                            style: TextStyle(fontWeight: FontWeight.bold ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                            child: TextFormField(
                                              onChanged: (String value){
                                                name = value;
                                              },


                                            ),
                                          )
                                        ]
                                    ),
                                  ),
                                ],
                              ),),


                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Expanded(
                                  child:
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[
                                        Text( "Description:          ", style: TextStyle(fontWeight: FontWeight.bold ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: TextFormField(
                                            onChanged: (String value){
                                              desc = value;
                                            },


                                          ),
                                        )
                                      ]
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Expanded(
                                  child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding * 1.5,
                                        vertical:
                                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                      ),
                                    ),
                                    onPressed: () async {
                                      addCategory = false;
                                      categories = await getCategorys();

                                      setState(() {
                                      });

                                      Navigator.of(context).pop();
                                      categoryList();
                                    },
                                    // icon: Icon(Icons.cancel),
                                    child: Text(
                                      "Cancel",
                                    ),
                                  ),),
                                SizedBox(width: 15),
                                Expanded(child: ElevatedButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 1.5,
                                      vertical:
                                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Category newCategory = Category(name: name, description: desc);
                                    newCategory.save();

                                    addCategory = false;
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Category Added"),
                                    ));
                                    categories = await getCategorys();
                                    setState(() { });
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.add),
                                  label: Text(
                                    "Add",
                                  ),
                                ),),
                                SizedBox(width: 15),
                              ],
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ): SizedBox(),
                    ],
                  ),
                ));
          });
    }

    Widget _formFields1(){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      print(product!.toJson());
                      product!.name = value;
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
                      topLabel: "Price",
                      keyboardType: TextInputType.text,
                      kController: con2,
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter price.';
                        }
                        return null;
                      },

                      onChanged: (String? value) {
                        product!.price = double.parse(value??"0");
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
                    topLabel: "SKU",
                    keyboardType: TextInputType.text,
                    kController: con3,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {
                      product!.sku = value;
                    },


                    // prefixIcon: FlutterIcons.chevron_left_fea,
                  ),
                ),
              ),
              SizedBox(height: 3),
            ],),
        ],);
    }

    Widget _formFields2(){
      return  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child:
                Padding(
                  padding: EdgeInsets.only(left: 5, right:5),
                  child: InputWidget(
                    topLabel: "Stock",
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    onChanged: (String? value) {

                      product!.stock = int.parse(value??"0");
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
                  padding: EdgeInsets.only(left: 5, right:5, top: 20),
                  child:                         Row(
                      children:[
                        Text( "Category:            ", style: TextStyle(fontWeight: FontWeight.bold ),
                        ),
                        product.category != null ? Container(
                          // margin: EdgeInsets.only(left: defaultPadding),
                          // padding: EdgeInsets.symmetric(
                          //   horizontal: defaultPadding /4,
                          //   vertical: defaultPadding / 5,
                          // ),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: TextButton(
                            child: Text(product.category!.name!),
                            onPressed: ()  {


                              if(true){
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children:
                                              List.generate(
                                                  categories.length,
                                                      (index) =>


                                                      Container(
                                                        margin: EdgeInsets.only(bottom: defaultPadding),
                                                        // padding: EdgeInsets.symmetric(
                                                        //   horizontal: defaultPadding,
                                                        //   vertical: defaultPadding / 2,
                                                        // ),
                                                        decoration: BoxDecoration(
                                                          color: secondaryColor,
                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          border: Border.all(),
                                                        ),
                                                        child: TextButton(
                                                          child: Text(categories[index].name??''),
                                                          onPressed: () {
                                                            product.categoryId = categories[index].id;
                                                            product.category = categories[index];
                                                            setState(() {});
                                                            Navigator.of(context).pop();
                                                          },
                                                          // Delete
                                                        ),

                                                      )
                                              ),


                                            ),
                                          ));
                                    });
                              }






                            },
                            // Delete
                          ),

                        ):ElevatedButton.icon(
                          icon: Icon(
                            Icons.flag,
                            size: 14,
                          ),
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10),
                              primary: Colors.blueAccent),
                          label: Text(product.category?.id.toString()! ?? "Select Category"),

                          onPressed: () {

                            categoryList();
                          },),


                      ]
                  ),
                ),
              ),
              SizedBox(height: 3),
            ],),
        ],);
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
              ProductHeader(title: product.name?? 'Add Product',),
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

                                // SizedBox(
                                //   height: 200,
                                //   child: imagePath ==null ? Image.asset("assets/image/image_icon.png", scale:1)
                                //       : Image.file(File(imagePath!), scale:1),
                                // ),
                                // SizedBox(height: 16.0),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //   children: [
                                //
                                //     ElevatedButton(
                                //       style: TextButton.styleFrom(
                                //         backgroundColor: defaultColor,
                                //         padding: EdgeInsets.symmetric(
                                //           horizontal: defaultPadding * 1.5,
                                //           vertical:
                                //           defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                //         ),
                                //       ),
                                //       onPressed: () async {
                                //         final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                //
                                //
                                //         // var path = await getExternalStorageDirectory();
                                //         //
                                //         // String p = path.toString();
                                //         // p = p.replaceAll("'", '');
                                //         String image = "${getRandomString(5)}_image.png";
                                //
                                //         final directory = await getDownloadPath2();
                                //         print(directory);
                                //         new File("${directory}${image}").create(recursive: true)
                                //             .then((File file) async {
                                //           if (image != null) await file.writeAsBytes(await image!.readAsBytes());
                                //         });
                                //
                                //         product.image = image;
                                //         if(product.name==null) product.name = "N/A";
                                //         product.save();
                                //
                                //         if(product.image!=null)imagePath = "${directory}${product.image}";
                                //
                                //         setState(() {
                                //         });
                                //
                                //       },
                                //       child: Text(
                                //         "Pick Product Image",
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(height: 16.0),

                                SingleChildScrollView(
                                  child: SizedBox(
                                      child: Responsive(
                                        mobile: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              _formFields1(),
                                              _formFields2(),
                                            ],
                                          ),
                                        ),
                                        tablet: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(child: _formFields1()),
                                            Expanded(child: _formFields2()),
                                          ],
                                        ),
                                        desktop: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(child: _formFields1()),
                                            Expanded(child: _formFields2()),
                                          ],
                                        ),

                                      )
                                  ),
                                ),
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
                                          print(product!.toJson());
                                          print(widget.code);
                                          try {
                                            if(widget.code == "edit"){
                                              product.categoryId = 1;
                                              product.businessId = 1;
                                              var productId = product!.save();
                                              print('Product id is $productId');

                                            }else{
                                              product.categoryId = 1;
                                              product.businessId = 1;
                                              var productId = await product!.save();

                                              print('Product id is $productId');

                                              SharedPreferences prefs = await SharedPreferences.getInstance();

                                              // prefs.setInt(UserPreference.activeProduct, productId);
                                            }



                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Product saved successfully"),
                                            ));

                                            SchedulerBinding.instance!
                                                .addPostFrameCallback((_) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => ProductsHomeScreen()),
                                              );
                                            });

                                          }catch(e){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
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
                                          print(product!.toJson());
                                          print(widget.code);
                                          try {
                                            product.delete();

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




