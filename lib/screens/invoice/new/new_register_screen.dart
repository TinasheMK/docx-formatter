
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../common/UserPreference.dart';
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
import '../../../providers/registration/Currency.dart';
import '../../../providers/registration/Invoice.dart';
import '../../../providers/registration/InvoiceItem.dart';
import '../../../providers/registration/Payment.dart';
import '../../../providers/registration/Wallet.dart';
import '../../../responsive.dart';

import '../../../services/permissions.dart';
import '../../generator/CR6_form_generator.dart';
import '../../generator/invoicegenerator.dart';
import '../../generator/pdf_invoice.dart';
import '../../generator/register_download_screen.dart';
import '../../generator/save_file_mobile.dart';
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

String? logoPath;

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
      invoice!.invoiceItems!.removeAt(index);
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

  List<Company> companies = [Company.fromJson({})];
  List<Currency> currencies = [Currency.fromJson({})];

  Invoice invoice = Invoice.fromJson({});

  Future<void> _initInvoice() async {
    currencies.clear();
    var prefs = await SharedPreferences.getInstance();


    if(invoiceId!=null) {
      invoice = await getInvoice(invoiceId);
      invoice.client = await getClient(invoice.clientId);
      invoice.invoiceItems = await getInvoiceItems(invoiceId);
      invoice.payments = await getInvoicePayments(invoiceId);
      invoice.companyFull = await getCompany(invoice.companyId);

    }else{
      invoice = Invoice.fromJson({});

      var activeClient = await prefs!.getInt(UserPreference.activeClient);
      if(activeClient !=null) {
        invoice.client = await getClient(activeClient);
      }else{
        invoice.client = Client.fromJson({});
      }

      invoice.invoiceStatus = 'DRAFT';
      invoice.invoiceDate = DateTime.now().toString();
      invoice.dueDate = DateTime.now().add(const Duration(days: 7)).toString();
    }
    if(invoice.invoiceItems == null) {
      invoice.invoiceItems = [InvoiceItem.fromJson({})];
    }
    if(invoice.payments == null) {
      invoice.payments= [Payment.fromJson({})];
    }
    if(invoice.companyFull == null) {
      var activeCompany = await prefs!.getInt(UserPreference.activeCompany);

      if(activeCompany!=null)invoice.companyFull= await getCompany(activeCompany);
    }


    companies = await getCompanys();
    currencies = await getCurrencys();

    var activeCurrency = await prefs!.getString(UserPreference.activeCurrency);

    invoice.client?.currency != null
        ? invoice.currencyFull=  await getCurrency(invoice.client?.currency)
        :activeCurrency != null ? invoice.currencyFull = await getCurrency(activeCurrency)
        : invoice.currencyFull = await getCurrency("USD");

    setState(() {
      invoice;
    });
  }






  @override
  void initState() {

    _initInvoice();
    super.initState();
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
    invoice.invoiceItems?.forEach((e) {
      myController.add([TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]);

      print(e.toJson());
    });



    callback(mem, action) async {
      if(action=="set"){
        memoItems = mem;
        print("Selected client with id" + memoItems);
        invoice.client = await getClient(int.parse(mem));

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

      invoice.invoiceItems?.forEach((i) {
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
                  margin: EdgeInsets.only(left: defaultPadding/4),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding/100,
                    vertical: defaultPadding / 100,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text(invoice.companyFull?.companyName ?? "Select" , style: TextStyle(color: Colors.white)),
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
                                  child: companies.isEmpty? Text("Please go to profile and add your company details."):Column(
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

                    if(invoice.client?.id == null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select or add a client."),
                      ));
                      return;
                    }
                    if(invoice.companyFull == null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select or add your company details in profile."),
                      ));
                      return;
                    }

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
                              invoice.client?.companyName != null ? Container(
                                  margin: EdgeInsets.only(left: defaultPadding),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding /100,
                                    vertical: defaultPadding / 100,
                                  ),
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.white10),
                                  ),
                                  child: TextButton(
                                    child: Text(invoice.client?.companyName ?? "Select Client", style: TextStyle(color: Colors.white)),
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
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child:
                        Row(
                            children:[
                              Text( "Currency:            ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              invoice.currency != null ? Container(
                                margin: EdgeInsets.only(left: defaultPadding),
                                padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding /4,
                                  vertical: defaultPadding / 5,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.white10),
                                ),
                                child: TextButton(
                                  child: Text(invoice.currency!, style: TextStyle(color: Colors.white)),
                                  onPressed: () {
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
                                  label: Text(invoice.currencyFull?.id! ?? "Select Currency"),

                                onPressed: () {

                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                            content: Container(
                                              color: secondaryColor,
                                              height: 410,
                                              child: Column(
                                                children:
                                                List.generate(
                                                  currencies.length,
                                                      (index) =>


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
                                                      child: Text(currencies[index].id??'', style: TextStyle(color: Colors.white)),
                                                      onPressed: () {
                                                        invoice.currency = currencies[index].id;
                                                        invoice.client?.currency = currencies[index].id;
                                                        invoice.client?.save();
                                                        setState(() {
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      // Delete
                                                    ),

                                                  )
                                                ),


                                              ),
                                            ));
                                      });
                                },)
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
                    if(invoice.invoiceStatus == 'PAID'){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Invoice already paid."),
                      ));
                    }else {
                      if(invoice.client?.id == null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please select or add a client."),
                        ));
                        return;
                      }
                      if(invoice.companyFull == null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please select or add your company details in profile."),
                        ));
                        return;
                      }

                      invoice.invoiceStatus = 'CANCELLED';
                      invoice.save();

                      invoice.invoiceItems?.forEach((e) {
                        print(e.toJson());
                      });


                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Marked as cancelled'),
                      ));
                    }
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
                    if(invoice.client?.id == null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select or add a client."),
                      ));
                      return;
                    }
                    if(invoice.companyFull == null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select or add your company details in profile."),
                      ));
                      return;
                    }

                    if(invoice.invoiceStatus == 'PAID'){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Invoice already paid."),
                      ));
                    }else {
                      invoice.invoiceStatus = 'UNPAID';
                      invoice.save();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Marked as unpaid'),
                      ));
                    }
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
                        invoice.invoiceItems != null ? invoice.invoiceItems!.length : 0 ,
                            (index) => _recentUserDataRow(invoice.invoiceItems?[index] ?? InvoiceItem.fromJson({}), index, context),
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

                    var state = 0;
                    if(invoice.client?.id == null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select or add a client."),
                      ));
                      return;
                    }
                    if(invoice.companyFull == null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select or add your company details in profile."),
                      ));
                      return;
                    }
                    invoice.totalAmount = invoice.subTotalAmount;
                    invoice.clientId = invoice.client?.id;
                    invoice.companyId = invoice.companyFull?.id;
                    double sum = 0.0;

                    if(invoice.payments!.isNotEmpty) {
                      if (invoice.payments?[0].total == null) invoice.payments!
                          .remove(invoice.payments![0]);
                    }
                    invoice.payments?.forEach((e) {
                      sum += e.total??0;
                      // if(e.total==null) invoice.payments!.remove(e);
                    });


                    if(invoice.totalAmount! < sum && invoice.invoiceStatus != 'PAID') {
                      Wallet wallet = await invoice.client!.getWallet(invoice.currencyFull!.id!);
                      wallet.deposit(sum - invoice.totalAmount!);
                    }


                    if(invoice.totalAmount! <= sum){
                      invoice.invoiceStatus = 'PAID';

                    }
                    await invoice.save();




                    if(invoiceId != null) invoice.payments = await getInvoicePayments(invoiceId);

                    SharedPreferences prefs = await SharedPreferences.getInstance();

                    prefs.setInt(UserPreference.activeClient, invoice.client?.id ?? 0);



                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invoice saved"),
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
                      if(invoice.invoiceStatus == 'PAID'){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Invoice already paid."),
                        ));
                      }else {
                        addPayment = true;
                      }
                      setState(() {

                      });

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

                if(invoice.id == null){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please save the invoice first"),
                  ));
                  return;
                }
                // var response = await invoiceGenerator(invoice);

                _generatePDF();
                var _model = ImageModel();
                _model.requestFilePermission();
                // OpenFile.open('/storage/emulated/0/Documents/Invoices/Invoice.pdf');
                var res = await OpenFile.open('/storage/emulated/0/Documents/Invoices/Invoice_'+invoice.id.toString()+'.pdf');
                print(res.message);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Invoice printed. Check documents/invoices folder."),
                ));
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
        invoice.companyFull = c;
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
                // keyboardType: TextInputType.number,
                controller: myController[index][0],
                onChanged: (String value){
                  value!=null || value !=""
                      ? invoice!.invoiceItems![index].units =  int.parse(value)
                      :invoice!.invoiceItems![index].units =1 ;


                  invoice!.invoiceItems![index].unitPrice!=null
                      ?''
                      : invoice!.invoiceItems![index].unitPrice = 0;

                  invoice!.invoiceItems![index].total = invoice!.invoiceItems![index].units! * invoice!.invoiceItems![index].unitPrice!;


                  myController[index][3].text =  invoice!.invoiceItems![index].total.toString();



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
                  invoice!.invoiceItems![index].description =  value;
                  // print(invoice!.invoiceItems![index].toJson());
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
                  invoice!.invoiceItems![index].unitPrice =  double.parse(value) ;
                  invoice!.invoiceItems![index].total =  double.parse(value) * (invoice!.invoiceItems![index].units!=null ? invoice!.invoiceItems![index].units!:1);
                  // print(invoice!.invoiceItems![index].toJson());

                  var total = 0.0;
                  invoice!.invoiceItems!.forEach((e) {
                    if(e.total==null){e.total = 0;}
                    total+=e.total!;
                  });

                  invoice.subTotalAmount = total;

                  myController[index][3].text = invoice!.invoiceItems![index].total.toString();



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
                  invoice!.invoiceItems![index].total =  double.parse(value);
                  // print(invoice!.invoiceItems![index].toJson());
                },


              ),)

        ),
        DataCell(
          Row(
            children: [
              invoice.invoiceItems?.length != 1 ? GestureDetector(
                child:Icon(Icons.delete, color: Colors.redAccent,),
                onTap: () {
                  deleteRow(index);
                  item.delete();
                },
              ) : SizedBox(width: 0,),
              invoice.invoiceItems?.length == (index+1) ? GestureDetector(
                child:Icon(Icons.add, color: Colors.blueAccent,),
                onTap: () {
                  setState ((){
                    invoice!.invoiceItems!.add(InvoiceItem.fromJson({}));
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



  Future<void> _generatePDF() async {
    var _model = ImageModel();

    final directory = await getDownloadPath2();
    if(invoice.companyFull!.logo!=null) logoPath = "${directory}${invoice.companyFull!.logo!}";


    _model.requestFilePermission();
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = _getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = await _drawHeader(page, pageSize, grid);
    //Draw grid
    _drawGrid(page, grid, result);
    //Add invoice footer
    _drawFooter(page, pageSize);
    //Save and dispose the document.
    final List<int> bytes = await document.save();
    document.dispose();
    //Launch file.
    await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice_'+invoice.id.toString()+'.pdf');
  }

  //Draws the invoice header
  Future<PdfLayoutResult> _drawHeader(PdfPage page, Size pageSize, PdfGrid grid) async {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));
    page.graphics.drawString(r'$' + _getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    print(logoPath);
    double height  =0;
    if(logoPath!=null) {
      var image = File(logoPath!).readAsBytesSync();
      var decodedImage = await decodeImageFromList(image);
      print(decodedImage.width);
      print(decodedImage.height);

      var x = decodedImage.width/(pageSize.width - 400);
      height = decodedImage.height / x;

      page.graphics.drawImage(
          PdfBitmap(image),
          Rect.fromLTWH(
              395, height+33, pageSize.width - 400, height));
    }

    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber = 'Invoice Number: '+invoice.invoiceNumber!+'\r\n\r\nDate: ' +
        invoice.invoiceDate.toString().split(" ")[0];
        // format.format(DateTime.now());
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String addr = invoice.client!.street ?? '';
    String city = invoice.client!.city ?? '';
    String country = invoice.client!.country ?? '';
    String address =
        'Bill To: \r\n\r\n'+invoice.client!.companyName!+', \r\n\r\n'+addr +', \r\n\r\n'+city +', \r\n\r\n'+country ;
    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120+height,
            contentSize.width + 30, pageSize.height - 120));



    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  //Draws the grid
  void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
    //Draw grand total.
    page.graphics.drawString('Grand Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString(_getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
  }

  //Draw the invoice footer data.
  void _drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    String addr = invoice.companyFull!.street??"";
    String city = invoice.companyFull!.city??"";
    String country = invoice.companyFull!.country??"";
    String email = invoice.companyFull!.email??"";
    String footerContent =
        invoice.companyFull!.companyName!+'.\r\n\r\n'+ addr+', '+ city+', '+ country +'\r\n\r\nAny Questions? '+ email;
    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid _getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Units';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Code';
    headerRow.cells[2].value = 'Product Name';
    headerRow.cells[3].value = 'Price';
    headerRow.cells[4].value = 'Total';

    invoice.invoiceItems?.forEach((p) {
      _addProducts(p.units?.toString()??'','789RT' , p.description??'', p.unitPrice??0.0, p.total??0.0, grid);
    });


    // _addProducts(
    //     'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    // _addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    // _addProducts(
    //     'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    // _addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    // _addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    grid.columns[2].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void _addProducts(String units,String code, String productName, double price,
      double total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = units;
    row.cells[1].value = code;
    row.cells[2].value = productName;
    row.cells[3].value = price.toString();
    row.cells[4].value = total.toString();
  }

  //Get the total amount.
  double _getTotalAmount(PdfGrid grid) {
    double total = 0;
    // for (int i = 0; i < grid.rows.count; i++) {
    //   final String value =
    //   grid.rows[i].cells[grid.columns.count - 1].value as String;
    //   total += double.parse(value);
    // }
    return invoice.totalAmount?? 0.0;
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

