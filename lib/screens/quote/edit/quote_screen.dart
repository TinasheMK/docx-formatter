
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/screens/quote/components/quote_header.dart';
import 'package:smart_admin_dashboard/screens/quote/quotes_home_screen.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../core/utils/UserPreference.dart';
import '../../../core/models/InvoiceItem.dart';
import '../../../core/models/Payment.dart';
import '../../invoice/edit/invoice_home_screen.dart';
import '../print/app.dart';
import '../../../core/types/Memo.dart';
import '../../../core/models/Client.dart';
import '../../../core/models/Business.dart';
import '../../../core/models/Currency.dart';
import '../../../core/models/Invoice.dart';
import '../../../core/models/Wallet.dart';
import '../../../core/utils/responsive.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/constants/color_constants.dart';

import '../../dashboard/components/header.dart';
import '../../../core/utils/save_file_mobile.dart';
import '../components/select_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _Size;

String? logoPath;
String? invoicePath;
String? invoiceName;

class QuoteScreen extends StatefulWidget {
  QuoteScreen({required this.title, required this.code, this.invoiceId});
  final String title;
  final int? invoiceId;
  final String code;

  @override
  _QuoteScreenState createState() => _QuoteScreenState(invoiceId);
}

// class QuoteScreen extends StatefulWidget {
class _QuoteScreenState extends State<QuoteScreen> with SingleTickerProviderStateMixin {
  DateTime payDate = DateTime.now();
  var paymentAmount;


  bool addPayment = false;



  _QuoteScreenState(int? this.invoiceId);
  int? invoiceId;


  var _isMoved = false;


  bool isChecked = false;

  int _value = 1;

  int _directors = 2;

  List persons = [];
  List original = [];
  DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  List<Client> directors = [];


  TextEditingController txtQuery = new TextEditingController();


  // late String country;
  // String generatorResp = "";
  // late String city;
  // String street = "";
  // String name = "";
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

  List<Business> companies = [Business.fromJson({})];
  List<Currency> currencies = [Currency.fromJson({})];

  Invoice invoice = Invoice.fromJson({});
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");


  Future<void> _initInvoice() async {
    invoice.currencyFull =   Currency(
      id: 'USD',
      symbol: '\$',
      country: 'USA',
    );

    currencies.clear();
    var prefs = await SharedPreferences.getInstance();


    if(invoiceId!=null) {
      invoice = await getInvoice(invoiceId!);
      if(invoice.clientId!=null) invoice.client = await getClient(invoice.clientId!);
      invoice.invoiceItems = await getInvoiceItems(invoiceId!);
      invoice.payments = await getInvoicePayments(invoiceId!);
      if(invoice.businessId!=null)invoice.business = await getBusiness(invoice.businessId!);

    }else{
      invoice = Invoice.fromJson({});

      var activeClient = await prefs!.getInt(UserPreference.activeClient);
      if(activeClient !=null) {
        invoice.client = await getClient(activeClient);
      }else{
        invoice.client = Client.fromJson({});
      }

      invoice.invoiceStatus = 'DRAFT';

      invoice.invoiceDate = dateFormat.format(DateTime.now());
      invoice.dueDate = dateFormat.format(DateTime.now().add(const Duration(days: 7))) ;
    }
    if(invoice.invoiceItems == null) {
      invoice.invoiceItems = [];
    }
    if(invoice.payments == null) {
      invoice.payments= [Payment.fromJson({})];
    }
    if(invoice.business == null) {
      var activeBusiness = await prefs!.getInt(UserPreference.activeBusiness);

      if(activeBusiness!=null)invoice.business= await getBusiness(activeBusiness);
    }


    companies = await getBusinesss();
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

    // paymentAmount = invoice.subTotalAmount?.toString() ?? "0";
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              QuoteHeader(title: widget.title,),
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




    Future<Invoice?> saveInvoice() async {

      if(invoice.client?.id == null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please select or add a client."),
        ));
        return null;
      }
      if(invoice.business == null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please select or add your business details in profile."),
        ));
        return null;
      }
      if(invoice.invoiceItems!.isEmpty ){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please add billable items"),
        ));
        return null;
      }

      if(invoice.invoiceType==null)invoice.invoiceType = 'QUOTATION';
      invoice.totalAmount = invoice.subTotalAmount;
      invoice.clientId = invoice.client?.id;
      invoice.businessId = invoice.business?.id;
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
      invoice.isSynced = false;
      await invoice.save();




      if(invoiceId != null) invoice.payments = await getInvoicePayments(invoiceId!);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setInt(UserPreference.activeClient, invoice.client?.id ?? 0);
      return invoice;
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
                              Text( "Business:            ", style: TextStyle(fontWeight: FontWeight.bold ),
                              ),
                              Container(
                                // margin: EdgeInsets.only(left: defaultPadding/4),
                                padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding/100,
                                  vertical: defaultPadding / 100,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(buttonBorderRadius)),
                                  border: Border.all(color: Colors.white10),
                                ),
                                child: TextButton(
                                  child: Text(invoice.business?.name ?? "Select" ),
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
                                                // color: secondaryColor,
                                                // height: 410,
                                                child: SingleChildScrollView(
                                                  child: companies.isEmpty? Text("Please go to profile and add your business details."):Column(
                                                    children: List.generate(
                                                      companies.length,
                                                          (index) => businessProfile(companies[index]),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          );
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
                  SizedBox(height: 3),                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child:
                        Row(
                            children:[
                              Text( "Client:            ", style: TextStyle(fontWeight: FontWeight.bold ),
                              ),
                              invoice.client?.name != null ? Container(
                                // margin: EdgeInsets.only(left: defaultPadding),
                                // padding: EdgeInsets.symmetric(
                                //   horizontal: defaultPadding /100,
                                //   vertical: defaultPadding / 100,
                                // ),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(buttonBorderRadius)),
                                  border: Border.all(color: Colors.white10),
                                ),
                                child: TextButton(
                                  child: Text(invoice.client?.name ?? "Select Client"),
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
                              Text( "Invoice Date:   ", style: TextStyle(fontWeight: FontWeight.bold ),
                              ),
                              // Text( "10/12/2023", style: TextStyle( color: Colors.white),
                              // ),
                              SizedBox(
                                // width: 150,
                                child:
                                TextButton(
                                  child: Text(invoice.invoiceDate??"", style: TextStyle(color:Colors.blueAccent)),
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
                                                // color: secondaryColor,
                                                height: 350,
                                                width: 350,
                                                child: SizedBox(
                                                  width: 300,
                                                  height: 300,
                                                  child: SfDateRangePicker(
                                                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                                      setState(() {
                                                        // print(args.value);
                                                        invoice.invoiceDate = dateFormat.format(args.value);
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
                              Text( "Due Date:        ", style: TextStyle(fontWeight: FontWeight.bold ),
                              ),
                              // Text( "10/12/2023", style: TextStyle( color: Colors.white),
                              // ),
                              TextButton(
                                child: Text(invoice.dueDate??"", style: TextStyle(color: Colors.blueAccent)),
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
                                              // color: secondaryColor,
                                              height: 350,
                                              width: 350,
                                              child: SizedBox(
                                                width: 300,
                                                height: 300,
                                                child: SfDateRangePicker(
                                                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                                    // print(args.value);
                                                    invoice.dueDate = dateFormat.format(args.value);
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
                              Text( "Total Due:          ", style: TextStyle(fontWeight: FontWeight.bold ),
                              ),
                              Text( (invoice.currencyFull?.symbol??"")+" "+ invoice.subTotalAmount.toString() != null
                                  ?   invoice.subTotalAmount.toString()
                                  : '0', style: TextStyle(fontWeight: FontWeight.bold ),
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
                              // Text( "Balance:             ", style: TextStyle(fontWeight: FontWeight.bold ),
                              // ),
                              // Text( "\$12", style: TextStyle(fontWeight: FontWeight.bold ),
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
                              Text( "Currency:            ", style: TextStyle(fontWeight: FontWeight.bold ),
                              ),
                              invoice.currency != null ? Container(
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
                                  child: Text(invoice.currency!),
                                  onPressed: ()  {

                                    if(invoice.id!=null){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text("Cannot change currency of saved invoice"),
                                      ));
                                    }
                                    else{
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
                                                              margin: EdgeInsets.only(bottom: defaultPadding),
                                                              // padding: EdgeInsets.symmetric(
                                                              //   horizontal: defaultPadding,
                                                              //   vertical: defaultPadding / 2,
                                                              // ),
                                                              decoration: BoxDecoration(
                                                                color: secondaryColor,
                                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                border: Border.all(color: Colors.white10),
                                                              ),
                                                              child: TextButton(
                                                                child: Text(currencies[index].id??''),
                                                                onPressed: () {
                                                                  invoice.currency = currencies[index].id;
                                                                  invoice.currencyFull = currencies[index];
                                                                  invoice.client?.currency = currencies[index].id;
                                                                  invoice.client?.save();
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
                                label: Text(invoice.currencyFull?.id! ?? "Select Currency"),

                                onPressed: () {

                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                            content: Container(
                                              // color: secondaryColor,
                                              // height: (60*currencies.length).toDouble(),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children:
                                                  List.generate(
                                                      currencies.length,
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
                                                              child: Text(currencies[index].id??''),
                                                              onPressed: () {
                                                                invoice.currency = currencies[index].id;
                                                                invoice.currencyFull = currencies[index];
                                                                invoice.client?.currency = currencies[index].id;
                                                                invoice.client?.save();
                                                                setState(() {});
                                                                Navigator.of(context).pop();
                                                              },
                                                              // Delete
                                                            ),

                                                          )
                                                  ),


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



            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quotation Items",
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
                  SizedBox(height: 10,),
                  GestureDetector(
                    child:Icon(Icons.add, color: Colors.blueAccent,),
                    onTap: () {
                      setState ((){
                        invoice!.invoiceItems!.add(InvoiceItem.fromJson({}));
                        myController.add([TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]);
                      });
                    },
                  )
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
                  // margin: EdgeInsets.only(left: defaultPadding),
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: defaultPadding,
                  //   vertical: defaultPadding / 2,
                  // ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text(invoice.currencyFull!.symbol!+" " + invoice.subTotalAmount.toString()!),
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
                Text("Tax"),
                SizedBox(width: 60.0,),
                Container(
                  // margin: EdgeInsets.only(left: defaultPadding),
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: defaultPadding,
                  //   vertical: defaultPadding / 2,
                  // ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text(invoice.currencyFull!.symbol!+" 0"),
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
                  // margin: EdgeInsets.only(left: defaultPadding),
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: defaultPadding,
                  //   vertical: defaultPadding / 2,
                  // ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextButton(
                    child: Text(invoice.currencyFull!.symbol!+" "+invoice.subTotalAmount.toString()!),
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
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {

                    var inv =  await saveInvoice();
                    if(inv!=null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PdfInvoice(invoice: inv ?? invoice,)),
                      );
                    }

                  },
                  icon: Icon(Icons.document_scanner),
                  label: Text(
                    "Print Quote",
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: defaultColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {

                    await saveInvoice();


                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Quotation saved"),
                    ));

                    setState(() {

                    });

                  },
                  icon: Icon(Icons.save),
                  label: Text(
                    "Save",
                  ),
                ),

              ],
            ),
            SizedBox(height: 75.0),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () async {
                invoice.invoiceType = 'INVOICE';
                var inv = await saveInvoice();
                if(inv !=null){

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Quotation converted"),
                  ));

                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new InvoiceHome(title: "Edit Invoice: ${inv.id}", code: "edit", invoiceId: inv.id );
                      },
                      fullscreenDialog: true));
                }


                setState(() {

                });

              },
              icon: Icon(Icons.change_circle),
              label: Text(
                "Convert to invoice",
              ),
            ),

            SizedBox(height: 5,),



            SizedBox(height: 20.0),
            // generatorResp!=""?Text(generatorResp):SizedBox(),




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

  Widget businessProfile(Business c) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          // color: secondaryColor,

          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(),
        ),
        child: TextButton(
          child: Text(c.name!, style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: () {},
          // Delete
        ),

      ),
      onTap: (){
        invoice.business = c;
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
                keyboardType: TextInputType.number,

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



void _onShare(BuildContext context) async {
  // A builder is used to retrieve the context immediately
  // surrounding the ElevatedButton.
  //
  // The context's `findRenderObject` returns the first
  // RenderObject in its descendent tree when it's not
  // a RenderObjectWidget. The ElevatedButton's RenderObject
  // has its position and size after it's built.
  final box = context.findRenderObject() as RenderBox?;

  if (invoicePath!=null) {
    final files = <XFile>[];
    // for (var i = 0; i < imagePaths.length; i++) {
    files.add(XFile(invoicePath!, name: invoiceName));
    // }
    await Share.shareXFiles(files,
        text: "Share invoice",
        subject: "Invoice",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  } else {
    await Share.share("Share invoice",
        subject: "Invoice",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}

