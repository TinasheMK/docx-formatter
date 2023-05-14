
import 'package:flutter/services.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import '../../../core/utils/colorful_tag.dart';
import '../../../providers/Memo.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../providers/recent_user_model.dart';
import '../../../providers/registration/Client.dart';
import '../../../providers/registration/Company.dart';
import '../../../providers/registration/Invoice.dart';
import '../../../providers/registration/InvoiceItem.dart';
import '../../../providers/registration/Payment.dart';
import '../../../responsive.dart';

import '../../generator/CR6_form_generator.dart';
import '../../generator/invoicegenerator.dart';
import '../../generator/register_download_screen.dart';
import '../../home/home_screen.dart';
import '../../memos/memo_list_material.dart';
import '../register_home_screen.dart';
import './components/mini_information_card.dart';

import '../components/recent_forums.dart';
import '../components/recent_users.dart';
import '../components/user_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _Size;

import '../components/header.dart';
import 'components/dropdown_search.dart';


class NewRegisterScreen extends StatefulWidget {
  NewRegisterScreen({required this.title, required this.code, this.invoiceId});
  final String title;
  final int? invoiceId;
  final String code;

  @override
  _NewRegisterScreenState createState() => _NewRegisterScreenState(invoiceId);
}

// class NewRegisterScreen extends StatefulWidget {
class _NewRegisterScreenState extends State<NewRegisterScreen> with SingleTickerProviderStateMixin {
  DateTime payDate = DateTime.now();
  var paymentAmount;


  bool addPayment = false;



  _NewRegisterScreenState(int? this.invoiceId);
  int? invoiceId;


  var _isMoved = false;


  bool isChecked = false;

  int _value = 1;

  int _directors = 2;

  List persons = [];
  List original = [];

  List<Client> directors = [];


  TextEditingController txtQuery = new TextEditingController();


  // late String country;
  // String generatorResp = "";
  // late String city;
  // String street = "";
  // String companyName = "";
  String memoItems = '';


  void search(String query) {
    if (query.isEmpty) {
      persons = original;
      setState(() {});
      return;
    }

    query = query.toLowerCase();
    // print(query);
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


  void deleteRow(int index) {
      invoice!.invoiceitems!.removeAt(index);
      myController.removeAt(index);
      print("Deleting at index:");
      print(index);
      setState(() {

      });
  }

  void deletePayRow(int index) {
    invoice!.payments!.removeAt(index);
    print("Deleting at index:");
    setState(() {

    });
  }


  List<List<TextEditingController>> myController = [[TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]] ;

  late int crossAxisCount;
  late double childAspectRatio;
  late Client selectedClient = Client.fromJson({});
  late String _dateCount;
  late String _range;


  @override
  void dispose() {
    myController.forEach((e) {
      e.forEach((a) {
        a.dispose();
      });

    });
    super.dispose();
  }



  Invoice invoice = Invoice.fromJson({});
  Company activeCompany = Company.fromJson({});

  Future<void> _initInvoice() async {
    if(invoiceId!=null) {
      invoice = await getInvoice(invoiceId);
      selectedClient = await getClient(invoice.client);
      invoice.invoiceitems = await getInvoiceItems(invoiceId);
      invoice.payments = await getInvoicePayments(invoiceId);
    }else{
      invoice = Invoice.fromJson({});
      invoice.invoiceStatus = 'DRAFT';
      invoice.invoiceDate = DateTime.now().toString();
      invoice.dueDate = DateTime.now().add(const Duration(days: 7)).toString();
    }
    if(invoice.invoiceitems == null) {
      invoice.invoiceitems = [InvoiceItem.fromJson({})];
    }
    if(invoice.payments == null) {
      invoice.payments= [Payment.fromJson({})];
    }


    setState(() {
      invoice;
    });
  }

  List<Company> companies = [Company.fromJson({})];

  Future<void> _initCompanys() async {
    companies = await getCompanys();
    activeCompany = await getCompany(1);

    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    _initInvoice();
    _initCompanys();
    myController.forEach((e) {
      e.forEach((a) {
        a.addListener(_printLatestValue);
      });
    });
  }

  void _printLatestValue() {

    myController.forEach((e) {
      e.forEach((a) {
        // print('Second text field: ${a.text}');
      });

    });

  }


  @override
  Widget build(BuildContext context) {
    paymentAmount = invoice.subTotalAmount?.toString() ?? "0";
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

    // invoice.subTotalAmount = 0;
    invoice.invoiceitems?.forEach((e) {
      myController.add([TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]);

      print(e.toJson());
    });



    callback(mem, action) async {
      if(action=="set"){
        memoItems = mem;
        print("Selected client with id" + memoItems);
        // print(memoItems);
        selectedClient = await getClient(int.parse(mem));
        // allClients.add(memos.where((element) => element.code ==mem).first);
        // print(selectedClient);

        setState(()  {

        });
      }else{
        setState(() {
          // allClients.removeWhere((element) => element.code == mem);

          // print(memoItems);
        });
      }
    }

    double total = 0;

      invoice.invoiceitems?.forEach((i) {
        total += i.total ?? 0;
      });

      invoice?.subTotalAmount = total;



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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(left: defaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 16,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text(activeCompany.companyName ?? "Select" , style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              // title: Center(
                              //   child: Column(
                              //     children: [
                              //       Text("Select Filter"),
                              //     ],
                              //   ),
                              // ),
                                content: Container(
                                  color: secondaryColor,
                                  height: 410,
                                  child: Column(
                                    children: List.generate(
                                      companies.length,
                                          (index) => companyProfile(companies[index]),
                                    ),
                                  ),
                                ));
                          });
                    },
                    // Delete
                  ),

                ),
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


                    invoice.invoiceStatus = 'UNPAID';
                    invoice.save();



                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Invoice Published'),
                    ));

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                    );

                  },
                  icon: Icon(Icons.send),
                  label: Text(
                    "Publish",
                  ),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                // ElevatedButton.icon(
                //   style: TextButton.styleFrom(
                //     backgroundColor: Colors.orange,
                //     padding: EdgeInsets.symmetric(
                //       horizontal: defaultPadding * 1.5,
                //       vertical:
                //       defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                //     ),
                //   ),
                //   onPressed: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                //     // );
                //   },
                //   icon: Icon(Icons.mail),
                //   label: Text(
                //     "Publish & Send Email",
                //   ),
                // ),
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
                              selectedClient.companyName != null ? Container(
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
                                    child: Text(selectedClient.companyName!, style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                                          builder: (BuildContext context) {
                                            return new MemoListMaterial(callback: callback);
                                          },
                                          fullscreenDialog: false));
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
                                                        // print(args.value);
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
                                                    // print(args.value);
                                                    invoice.dueDate = args.value.toString();
                                                    setState(() {

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
                              Text( "\$"+ invoice.subTotalAmount.toString() != null
                                  ?   invoice.subTotalAmount.toString()
                                  : '0', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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
                              // Text( "Balance:             ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              // ),
                              // Text( "\$12", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              // ),
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
              child: Text( invoice.invoiceStatus != null ? invoice.invoiceStatus! : 'DRAFT', style: TextStyle(fontSize: 30, color: Colors.white),
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

                    invoice.invoiceStatus = 'CANCELLED';
                    invoice.save();

                    invoice.invoiceitems?.forEach((e) {
                      print(e.toJson());
                    });


                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Marked as cancelled'),
                    ));

                    setState(() {

                    });
                  },
                  icon: Icon(Icons.cancel),
                  label: Text(
                    "Set Cancelled",
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


                    invoice.invoiceStatus = 'UNPAID';
                    invoice.save();
                    // print(invoice.toJson());


                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Marked as unpaid'),
                    ));

                    setState(() {

                    });

                  },
                  icon: Icon(Icons.cancel_outlined),
                  label: Text(
                    "Set Unpaid",
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
                          label: Text("U Price"),
                        ),
                        DataColumn(
                          label: Text("Amount"),
                        ),
                        DataColumn(
                          label: Text(""),
                        ),
                      ],
                      rows: List.generate(
                        invoice.invoiceitems != null ? invoice.invoiceitems!.length : 0 ,
                            (index) => _recentUserDataRow(invoice.invoiceitems?[index] ?? InvoiceItem.fromJson({}), index, context),
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

                    // invoice.invoiceitems! = invoice!.invoiceitems!;
                    invoice.totalAmount = invoice.subTotalAmount;
                    invoice.client = selectedClient.id;
                    invoice.company = activeCompany.id;
                    await invoice.save();

                    invoice.clientFull = selectedClient;
                    invoice.companyFull = activeCompany;

                    invoice.payments = await getInvoicePayments(invoiceId);



                    var response = await invoiceGenerator(invoice, widget.code);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(response),
                    ));

                    setState(() {

                    });

                  },
                  icon: Icon(Icons.save),
                  label: Text(
                    "Save",
                  ),
                ),
                SizedBox(width: 15,),


                Container(
                  margin: EdgeInsets.only(left: defaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 16,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text("Add Payment" , style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      addPayment = true;
                      setState(() {

                      });
                      // showDialog(
                      //     context: context,
                      //     builder: (_) {
                      //       return AlertDialog(
                      //           content: SizedBox(
                      //             height: 113,
                      //             // padding: EdgeInsets.all(defaultPadding),
                      //             // decoration: BoxDecoration(
                      //             //   borderRadius: const BorderRadius.all(Radius.circular(10)),),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Row(
                      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                   children: [
                      //                     Expanded(
                      //                       child:
                      //                       Row(
                      //                           children:[
                      //                             Text( "Payment Date:   ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                      //                             ),
                      //                             // Text( "10/12/2023", style: TextStyle( color: Colors.white),
                      //                             // ),
                      //                             SizedBox(
                      //                               // width: 150,
                      //                               child:
                      //                               TextButton(
                      //                                 child: Text(payDate.toString().split(" ")[0], style: TextStyle(color:Colors.blueAccent)),
                      //                                 onPressed: () {
                      //                                   showDialog(
                      //                                       context: context,
                      //                                       builder: (_) {
                      //                                         return AlertDialog(
                      //                                             title: Center(
                      //                                               child: Column(
                      //                                                 children: [
                      //                                                   Text("Select Date"),
                      //                                                 ],
                      //                                               ),
                      //                                             ),
                      //                                             content: Container(
                      //                                               color: secondaryColor,
                      //                                               height: 350,
                      //                                               width: 350,
                      //                                               child: SizedBox(
                      //                                                 width: 300,
                      //                                                 height: 300,
                      //                                                 child: SfDateRangePicker(
                      //                                                   onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      //                                                     print(payDate);
                      //                                                     payDate = args.value.toString();
                      //                                                     setState(() {
                      //                                                     });
                      //                                                   },
                      //                                                   selectionMode: DateRangePickerSelectionMode.single,
                      //                                                   initialSelectedRange: PickerDateRange(
                      //                                                       DateTime.now().subtract(const Duration(days: 4)),
                      //                                                       DateTime.now().add(const Duration(days: 3))),
                      //                                                 ),
                      //                                               ),
                      //                                             ));
                      //                                       });
                      //                                 },
                      //                                 // Delete
                      //                               ),
                      //                             ),
                      //                           ]
                      //                       ),
                      //
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 SizedBox(height: 3),
                      //                 Row(
                      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                   children: [
                      //                     Expanded(
                      //                       child:
                      //                       Row(
                      //                           children:[
                      //                             Text( "Total Paid:          ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                      //                             ),
                      //                             SizedBox(
                      //                               width: 80,
                      //                               child: TextFormField(
                      //                                 inputFormatters: <TextInputFormatter>[
                      //                                   FilteringTextInputFormatter.digitsOnly
                      //                                 ],
                      //                                 keyboardType: TextInputType.number,
                      //                                 // controller: myController[index][0],
                      //                                 onChanged: (String value){
                      //
                      //                                 },
                      //
                      //
                      //                               ),
                      //                             )
                      //                           ]
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 SizedBox(height: 6),
                      //                 ElevatedButton.icon(
                      //                   style: TextButton.styleFrom(
                      //                     backgroundColor: Colors.green,
                      //                     padding: EdgeInsets.symmetric(
                      //                       horizontal: defaultPadding * 1.5,
                      //                       vertical:
                      //                       defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                      //                     ),
                      //                   ),
                      //                   onPressed: () async {
                      //
                      //
                      //
                      //                   },
                      //                   icon: Icon(Icons.add),
                      //                   label: Text(
                      //                     "Add",
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //       );
                      //     });
                    },
                    // Delete
                  ),

                ),


              ],
            ),
            SizedBox(height: 15.0),

            addPayment ? Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                border: Border.all(
                  color: darkgreenColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                              Text( "Payment Date:   ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              // Text( "10/12/2023", style: TextStyle( color: Colors.white),
                              // ),
                              SizedBox(
                                // width: 150,
                                child:
                                TextButton(
                                  child: Text(payDate.toString().split(" ")[0], style: TextStyle(color:Colors.blueAccent)),
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
                                                      print(payDate);
                                                      payDate = args.value;
                                                      setState(() {
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Expanded(
                        child:
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Text( "Total Paid:          ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              SizedBox(
                                width: 80,
                                child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
                                  ],
                                  keyboardType: TextInputType.number,
                                  // controller: myController[index][0],
                                  onChanged: (String value){
                                    paymentAmount = value;
                                  },
                                  initialValue: paymentAmount,


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
                            addPayment = false;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Payment Added"),
                            ));
                            setState(() {

                            });

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
                            var pay = new Payment.fromJson({});

                            pay.total = double.parse(paymentAmount);
                            pay.paymentDate = payDate.toString();
                            pay.invoiceId = invoice.id;

                            print(invoice.payments);

                            if(invoice.payments == null) {
                              invoice.payments= [pay];
                            }else{
                              invoice.payments!.add(pay);
                            }


                            addPayment = false;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Payment Added"),
                            ));
                            setState(() {

                            });

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
                  invoice.payments !=null

                  ?SingleChildScrollView(
                    //scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 0,
                        columnSpacing: defaultPadding,
                        columns: [
                          DataColumn(
                            label: Text("Reference"),
                          ),
                          DataColumn(
                            label: Text("Date"),
                          ),
                          DataColumn(
                            label: Text("Amount"),
                          ),
                          DataColumn(
                            label: Text("Action"),
                          ),
                        ],
                        rows: List.generate(
                          invoice.payments!.length,
                              (index) => paymentsDataRow(invoice.payments![index],index, context),
                        ),
                      ),
                    ),
                  )
                  :Text(
                    "No payments",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),),
            //Secretary Ends



            SizedBox(height: 20.0),
            // generatorResp!=""?Text(generatorResp):SizedBox(),
            AppButton(
              type: ButtonType.PRIMARY,
              text: "Print Invoice",
              onPressed: () async {

                // List<DailyInfoModel> dailyDatas =
                // dailyData.map((item) => DailyInfoModel.fromJson(item)).toList();


                // var register = {
                //   "companyName":companyName,
                //   "street":street,
                //   "city":city,
                //   "country":country,
                // };

                // Company company =  Company.fromJson(register);

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

  Widget companyProfile(Company c) {
    return GestureDetector(
      child: Text(c.companyName!) ,
      onTap: (){
        activeCompany = c;
        Navigator.of(context).pop();
        setState(() {

        });
      },
    );
  }

  DataRow _recentUserDataRow( InvoiceItem item, int index, BuildContext context) {
    myController[index][0].text = item.units?.toString() ?? "";
    myController[index][1].text = item.description?.toString() ?? "";
    myController[index][2].text = item.unitPrice?.toString() ?? "";
    myController[index][3].text = item.total?.toString() ?? "";
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
                onChanged: (String value){
                  value!=null || value !=""
                      ? invoice!.invoiceitems![index].units =  int.parse(value)
                      :invoice!.invoiceitems![index].units =1 ;


                  invoice!.invoiceitems![index].unitPrice!=null
                      ?''
                      : invoice!.invoiceitems![index].unitPrice = 0;

                  invoice!.invoiceitems![index].total = invoice!.invoiceitems![index].units! * invoice!.invoiceitems![index].unitPrice!;


                  myController[index][3].text =  invoice!.invoiceitems![index].total.toString();



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
                  invoice!.invoiceitems![index].description =  value;
                  // print(invoice!.invoiceitems![index].toJson());
                },

              ),)

        ),
        DataCell(
            Padding(padding: EdgeInsets.all(3),
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
                ],
                controller: myController[index][2],
                onChanged: (String value){
                  invoice!.invoiceitems![index].unitPrice =  double.parse(value) ;
                  invoice!.invoiceitems![index].total =  double.parse(value) * (invoice!.invoiceitems![index].units!=null ? invoice!.invoiceitems![index].units!:1);
                  // print(invoice!.invoiceitems![index].toJson());

                  var total = 0.0;
                  invoice!.invoiceitems!.forEach((e) {
                    if(e.total==null){e.total = 0;}
                    total+=e.total!;
                  });

                  invoice.subTotalAmount = total;

                  myController[index][3].text = invoice!.invoiceitems![index].total.toString();



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
                  invoice!.invoiceitems![index].total =  double.parse(value);
                  // print(invoice!.invoiceitems![index].toJson());
                },


              ),)

        ),
        DataCell(
          Row(
            children: [
              invoice.invoiceitems?.length != 1 ? GestureDetector(
                child:Icon(Icons.delete, color: Colors.redAccent,),
                onTap: () {
                  deleteRow(index);
                  item.delete();
                },
              ) : SizedBox(width: 0,),
              invoice.invoiceitems?.length == (index+1) ? GestureDetector(
                child:Icon(Icons.add, color: Colors.blueAccent,),
                onTap: () {
                  setState ((){
                    invoice!.invoiceitems!.add(InvoiceItem.fromJson({}));
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



  DataRow paymentsDataRow(Payment userInfo,  int index,BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
              ),
            ),
            child: Text(userInfo.id?.toString() ?? ""))),
        DataCell(Text(userInfo.paymentDate?.toString().split(" ")[0] ?? "")),
        DataCell(Text(userInfo.total?.toString() ?? "")),
        // DataCell(Text(userInfo.total.toString() ?? ""))
        DataCell(
          Row(
            children: [
              GestureDetector(
                child:userInfo.total!=null ?Icon(Icons.delete, color: Colors.redAccent,):SizedBox(),
                onTap: () {
                  deletePayRow(index);
                  userInfo.delete();
                },
              ),
            ],
          ),
        )
      ],
    );
  }

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



