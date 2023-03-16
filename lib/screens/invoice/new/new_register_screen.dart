import 'dart:convert';
import 'dart:ffi';

import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/services.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import '../../../core/utils/colorful_tag.dart';
import '../../../models/Memo.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../models/recent_user_model.dart';
import '../../../models/registration/Client.dart';
import '../../../models/registration/Company.dart';
import '../../../models/registration/Invoice.dart';
import '../../../models/registration/InvoiceItem.dart';
import '../../../responsive.dart';

import '../../generator/CR6_form_generator.dart';
import '../../generator/invoicegenerator.dart';
import '../../generator/register_download_screen.dart';
import '../../home/home_screen.dart';
import '../../memos/memo_list_material.dart';
import './components/mini_information_card.dart';

import '../components/recent_forums.dart';
import '../components/recent_users.dart';
import '../components/user_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _Size;

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
  int _invoiceitems = 1;

  List persons = [];
  List original = [];

  List<Client> directors = [];
  List<InvoiceItem> invoiceitems = [InvoiceItem.fromJson({})];
  Invoice invoice = Invoice.fromJson({});


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
      _invoiceitems += 1;
    });
  }

  void deleteRow(int index) {
      invoiceitems.removeAt(index);
      myController.removeAt(index);
      print("Deleting at index:");
      print(index);
      setState(() {

      });
  }

  void _removeDirector() {
    setState(() {
      if(_invoiceitems>1){
        _invoiceitems-= 1;
      }else{
        _invoiceitems = 1;
      }
    });
  }

   List<List<TextEditingController>> myController = [[TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]] ;

  late int crossAxisCount;
  late double childAspectRatio;
  late List<Memo> memosSet = [];
  late String _dateCount;
  late String _range;


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _animationController?.dispose();

    myController.forEach((e) {
      e.forEach((a) {
        a.dispose();
      });

    });
    super.dispose();
  }

  @override
  void initState() {
    _dateCount = '';
    _range = '';

    invoice.subTotalAmount = 0;
    invoice.invoiceDate = DateTime.now().toString();
    invoice.dueDate = DateTime.now().add(const Duration(days: 7)).toString();
    super.initState();

    loadData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    myController.forEach((e) {
      e.forEach((a) {
        a.addListener(_printLatestValue);
      });
    });



  }

  void _printLatestValue() {

    myController.forEach((e) {
      e.forEach((a) {
        print('Second text field: ${a.text}');
      });

    });

  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      print(args.value);
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      }
    });
  }






  @override
  Widget build(BuildContext context) {
    // print(widget.code);
    final _Size.Size _size = MediaQuery.of(context).size;
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

            SizedBox(height: 15.0),


            SizedBox(height:10),

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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Publishing"),
                    ));
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
            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child:
                        Row(
                            children:[
                              Text( "Client:            ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              memosSet.length >= 1 ? Container(
                                  margin: EdgeInsets.only(left: defaultPadding),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding /2,
                                    vertical: defaultPadding / 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.white10),
                                  ),
                                  child: TextButton(
                                    child: Text(memosSet[0].title!, style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                                          builder: (BuildContext context) {
                                            return new MemoListMaterial(callback: callback);
                                          },
                                          fullscreenDialog: true));
                            },
                            // Delete
                          ),

                        )
                              :ElevatedButton.icon(
                                  icon: Icon(
                                    Icons.person,
                                    size: 14,
                                  ),
                                  style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10),
                                      primary: Colors.blueAccent),
                                  onPressed: () {
                                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                                        builder: (BuildContext context) {
                                          return new MemoListMaterial(callback: callback);
                                        },
                                        fullscreenDialog: true));
                                  },
                                  label: Text("Select Client")),
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
                              Text( "Invoice Date:   ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              // Text( "10/12/2023", style: TextStyle( color: Colors.white),
                              // ),
                              SizedBox(
                                // width: 150,
                                child:
                                TextButton(
                                  child: Text(invoice.invoiceDate.toString().split(" ")[0], style: TextStyle(color:Colors.blueAccent)),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                              title: Center(
                                                child: Column(
                                                  children: [
                                                    Text("Select Date"),
                                                  ],
                                                ),
                                              ),
                                              content: Container(
                                                color: secondaryColor,
                                                height: 350,
                                                width: 350,
                                                child: SizedBox(
                                                  width: 300,
                                                  height: 300,
                                                  child: SfDateRangePicker(
                                                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                                      setState(() {
                                                        print(args.value);
                                                        invoice.invoiceDate = args.value.toString();
                                                      });
                                                    },
                                                    selectionMode: DateRangePickerSelectionMode.single,
                                                    initialSelectedRange: PickerDateRange(
                                                        DateTime.now().subtract(const Duration(days: 4)),
                                                        DateTime.now().add(const Duration(days: 3))),
                                                  ),
                                                ),
                                              ));
                                        });
                                  },
                                  // Delete
                                ),
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
                              Text( "Due Date:        ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              // Text( "10/12/2023", style: TextStyle( color: Colors.white),
                              // ),
                              TextButton(
                                child: Text(invoice.dueDate.toString().split(" ")[0], style: TextStyle(color: Colors.blueAccent)),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                            title: Center(
                                              child: Column(
                                                children: [
                                                  Text("Select Date"),
                                                ],
                                              ),
                                            ),
                                            content: Container(
                                              color: secondaryColor,
                                              height: 350,
                                              width: 350,
                                              child: SizedBox(
                                                width: 300,
                                                height: 300,
                                                child: SfDateRangePicker(
                                                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                                    setState(() {
                                                      print(args.value);
                                                      invoice.dueDate = args.value.toString();
                                                    });
                                                  },
                                                  selectionMode: DateRangePickerSelectionMode.single,
                                                  initialSelectedRange: PickerDateRange(
                                                      DateTime.now().subtract(const Duration(days: 4)),
                                                      DateTime.now().add(const Duration(days: 3))),
                                                ),
                                              ),
                                            ));
                                      });
                                },
                                // Delete
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
                              Text( "Total Due:          ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              Text( "\$"+ invoice.subTotalAmount.toString()!, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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
                              Text( "Balance:             ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              Text( "\$12", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ]
                        ),

                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                ],
              ),),



            //First Director
            Center(
              child: Text( "Draft", style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text( "Payment Method: ", style: TextStyle(color: Colors.white),
                  ),
                  Text( "Mail in Payment", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ]
            ),
            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: defaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 2,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text("Invoice Created", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                                title: Center(
                                  child: Column(
                                    children: [
                                      Text("Select Notification Type"),
                                    ],
                                  ),
                                ),
                                content: Container(
                                  color: secondaryColor,
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: defaultPadding),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding,
                                          vertical: defaultPadding / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("Invoice Created", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                          },
                                          // Delete
                                        ),

                                      ),
                                      SizedBox(height: 7,),
                                      Container(
                                        margin: EdgeInsets.only(left: defaultPadding),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding,
                                          vertical: defaultPadding / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("Invoice Modified", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                          },
                                          // Delete
                                        ),

                                      ),
                                      SizedBox(height: 7,),

                                      Container(
                                        margin: EdgeInsets.only(left: defaultPadding),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding,
                                          vertical: defaultPadding / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("Invoice Overdue", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                          },
                                          // Delete
                                        ),

                                      ),

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
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          });
                    },
                    // Delete
                  ),

                ),
                SizedBox(width: 16.0),
                SizedBox(
                  // padding: EdgeInsets.only(left:0, top:25, right:0, bottom:0),
                  child:ElevatedButton.icon(
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
                  )
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
                        invoiceitems.length,
                            (index) => _recentUserDataRow(invoiceitems[index], index, context),
                      ),
                    ),
                ),
              ),
            ],
          ),),

                SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child:SizedBox(width: 600.0)),
                Text("Subtotal"),
                SizedBox(width: 60.0),
                Container(
                  margin: EdgeInsets.only(left: defaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 2,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text("\$" + invoice.subTotalAmount.toString()!, style: TextStyle(color: Colors.white)),
                    onPressed: () {
                    },
                    // Delete
                  ),

                ),

                SizedBox(width: 16.0),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child:SizedBox(width: 600.0)),
                Text("Credit"),
                SizedBox(width: 60.0,),
                Container(
                  margin: EdgeInsets.only(left: defaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 2,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text("\$0", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                    },
                    // Delete
                  ),

                ),
                SizedBox(width: 16.0),
              ],
            ),
            SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child:SizedBox(width: 600.0)),
                Text("Total Due"),
                SizedBox(width: 60.0, height: 15,),
                Container(
                  margin: EdgeInsets.only(left: defaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 2,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text("\$"+invoice.subTotalAmount.toString()!, style: TextStyle(color: Colors.white)),
                    onPressed: () {
                    },
                    // Delete
                  ),

                ),
                SizedBox(width: 16.0),
              ],
            ),
            SizedBox(height: 10.0),


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

                    invoice.invoiceitems = invoiceitems;
                    invoice.totalAmount = invoice.subTotalAmount;
                    invoice.client = int.parse(memoItems[0]);
                    invoice.save();

                    print(invoice.toJson());

                    var response = await invoiceGenerator(invoice, widget.code, memosSet);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(response),
                    ));

                    // setState(() {
                    //   generatorResp = response;
                    // });
                  },
                  icon: Icon(Icons.save),
                  label: Text(
                    "Save Changes",
                  ),
                ),
                SizedBox(width: 15,),





                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
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
                  icon: Icon(Icons.add),
                  label: Text(
                    "Add Payment",
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
                        ],
                        rows: List.generate(
                          recentUsers.length,
                              (index) => paymentsDataRow(recentUsers[index], context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
            //Secretary Ends



            SizedBox(height: 20.0),
            generatorResp!=""?Text(generatorResp):SizedBox(),
            AppButton(
              type: ButtonType.PRIMARY,
              text: "Print Invoice",
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



                // company.cl = directors;
                // company.secretaries = secretaries;
                // await company.save();
                print(company.toJson());

                // var response = await cr6FormGenerator(company, widget.code, memosSet);


                // setState(() {
                //   generatorResp = response;
                // });
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
                        directors.add(Client.fromJson({}));
                    }
                    directors[number-1].companyName = value;

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
                        directors.add(Client.fromJson({}));
                    }
                    directors[number-1].companyName = value;


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
                      directors.add(Client.fromJson({}));
                    }
                    directors[number-1].companyName = value;


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
                        directors.add(Client.fromJson({}));
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
                        directors.add(Client.fromJson({}));
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
                        directors.add(Client.fromJson({}));
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


  DataRow _recentUserDataRow( InvoiceItem item, int index, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
            Padding(padding: EdgeInsets.all(3),
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                controller: myController[index][0],
                decoration: InputDecoration(

                  focusedBorder: OutlineInputBorder(
                    //gapPadding: 16,
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                ),
                onChanged: (String value){
                  value!=null || value !=""
                      ? invoiceitems[index].units =  int.parse(value)
                      :invoiceitems[index].units =1 ;


                  // invoiceitems[index].unitPrice = invoiceitems[index].total != null ? invoiceitems[index].total : 1 / invoiceitems[index].units! ;
                  invoiceitems[index].total!=null?invoiceitems[index].total : invoiceitems[index].total =1;
                  invoiceitems[index].unitPrice = invoiceitems[index].total! / invoiceitems[index].units!;
                  print(invoiceitems[index].toJson());

                  setState(() {
                    myController[index][2].text = invoiceitems[index].unitPrice.toString();

                  });


                },


              ),)

        ),
        DataCell(
            Padding(padding: EdgeInsets.all(3),
              child: TextFormField(
                controller: myController[index][1],

                decoration: InputDecoration(

                  focusedBorder: OutlineInputBorder(
                    //gapPadding: 16,
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                ),
                onChanged: (String value){
                  invoiceitems[index].description =  value;
                  print(invoiceitems[index].toJson());
                },

              ),)

        ),
        DataCell(
            Padding(padding: EdgeInsets.all(3),

              child: TextField(
                enabled: false,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
                ],
                controller: myController[index][2],
                decoration: InputDecoration(

                  focusedBorder: OutlineInputBorder(
                    //gapPadding: 16,
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                ),

                onChanged: (String value){
                  invoiceitems[index].unitPrice =  double.parse(value);
                  print(invoiceitems[index].toJson());
                },


              ),)

        ),
        DataCell(
            Padding(padding: EdgeInsets.all(3),
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
                ],
                controller: myController[index][3],

                decoration: InputDecoration(

                  focusedBorder: OutlineInputBorder(
                    //gapPadding: 16,
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                ),
                onChanged: (String value){
                  invoiceitems[index].total =  double.parse(value) ;
                  invoiceitems[index].unitPrice =  double.parse(value) / (invoiceitems[index].units!=null ? invoiceitems[index].units!:1);
                  print(invoiceitems[index].toJson());

                  var total = 0.0;
                  invoiceitems.forEach((e) {
                    if(e.total==null){e.total = 0;}
                    total+=e.total!;
                  });

                  invoice.subTotalAmount = total;

                  setState(() {
                    myController[index][2].text = invoiceitems[index].unitPrice.toString();

                  });


                },


              ),)

        ),
        DataCell(
          Row(
            children: [
              invoiceitems.length != 1
                  ? TextButton(
                    child: Icon(Icons.delete, color: Colors.redAccent,),
                    onPressed: () {
                      deleteRow(index);
                    },
              )
                  : SizedBox(width: 0,),
              invoiceitems.length == (index+1) ? TextButton(
                child: Icon(Icons.add, color: Colors.blueAccent,),
                onPressed: () {
                  setState ((){
                      invoiceitems.add(InvoiceItem.fromJson({}));
                      myController.add([TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]);
                  });

                },
              ) : SizedBox(width: 0,),
            ],
          ),
        ),
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

DataRow paymentsDataRow(RecentUser userInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                userInfo.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      DataCell(Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: getRoleColor(userInfo.role).withOpacity(.2),
            border: Border.all(color: getRoleColor(userInfo.role)),
            borderRadius: BorderRadius.all(Radius.circular(5.0) //
            ),
          ),
          child: Text(userInfo.role!))),
      DataCell(Text(userInfo.date!)),
      DataCell(Text(userInfo.posts!))
    ],
  );
}


