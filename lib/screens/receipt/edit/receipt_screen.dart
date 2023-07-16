
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smart_admin_dashboard/screens/quote/components/quote_header.dart';
import 'package:smart_admin_dashboard/screens/receipt/edit/receipt_home_screen.dart';
import '../../../core/models/Category.dart';
import '../../../core/models/Product.dart';
import '../../../core/types/daily_info_model.dart';
import '../../../core/utils/UserPreference.dart';
import '../../../core/models/InvoiceItem.dart';
import '../../../core/models/Payment.dart';
import '../../dashboard/components/mini_information_widget.dart';
import '../components/receipt_header.dart';
import '../components/tile.dart';
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
import '../components/select_client.dart';
import 'package:flutter/material.dart';

import '../receipts_home_screen.dart';


String? logoPath;
String? invoicePath;
String? invoiceName;

class ReceiptScreen extends StatefulWidget {
  ReceiptScreen({required this.title, required this.code, this.invoiceId});
  final String title;
  final int? invoiceId;
  final String code;

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState(invoiceId);
}

// class ReceiptScreen extends StatefulWidget {
class _ReceiptScreenState extends State<ReceiptScreen> with  TickerProviderStateMixin {
  DateTime payDate = DateTime.now();
  var paymentAmount;
  bool addPayment = false;
  _ReceiptScreenState(int? this.invoiceId);
  int? invoiceId;
  bool isChecked = false;
  List persons = [];
  List original = [];
  DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  List<Client> directors = [];
  TextEditingController txtQuery = new TextEditingController();
  String memoItems = '';
  List<List<TextEditingController>> myController = [[TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]];
  int crossAxisCount = 2;
  double childAspectRatio =2;
  List<Business> companies = [Business.fromJson({})];
  List<Client> clients = [Client.fromJson({})];
  List<Currency> currencies = [Currency.fromJson({})];
  Invoice invoice = Invoice.fromJson({});
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  List<Category> categories = [Category.fromJson({})];
  List<Product> products = [Product.fromJson({})];
  List<Product> productsSearch = [];

  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  OverlayEntry? _overlayEntry;
  GlobalKey globalKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  final LayerLink _layerLink2 = LayerLink();
  OverlayState? overlayState;

  Future<void> _initInvoice() async {
    categories = await getCategorys();
    products = await getFeaturedProducts();
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

      invoice.invoiceStatus = 'DRAFT';

      invoice.invoiceDate = dateFormat.format(DateTime.now());
      invoice.dueDate = dateFormat.format(DateTime.now().add(const Duration(days: 7))) ;
    }
    if(invoice.invoiceItems == null) {
      // invoice.invoiceItems = [InvoiceItem.fromJson({})];
    }
    if(invoice.payments == null) {
      invoice.payments= [Payment.fromJson({})];
    }
    if(invoice.business == null) {
      var activeBusiness = await prefs!.getInt(UserPreference.activeBusiness);

      if(activeBusiness!=null)invoice.business= await getBusiness(activeBusiness);
    }


    companies = await getBusinesss();
    clients = await getClients();
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
  void _printLatestValue() {
    myController.forEach((e) {
      e.forEach((a) {
      });
    });
  }
  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    return OverlayEntry(
        builder: (context) => Positioned(
          width: Responsive.isMobile(context) ? ((MediaQuery.of(context).size.width )-26) : ((MediaQuery.of(context).size.width /2)-26),
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0,  55.0),
            child: Material(
              elevation: 5.0,
              child:
                  Column(
                    children: [
                      SizedBox(height: 15,),
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
                          _overlayEntry?.remove();
                          _overlayEntry=null;


                        },
                        icon: Icon(Icons.cancel),
                        label: Text(
                          "Cancel",
                        ),
                      ),
                      SingleChildScrollView(
                        child: clients.isEmpty? Text("No client with these details was found."):Column(
                          children: List.generate(
                              clients.length,
                                  (index) => GestureDetector(
                                child:  ListTile(
                                  title: Text(clients[index].name!),
                                ),
                                onTap: (){
                                  invoice.client = clients[index];
                                  print("Tapping has occured");
                                  _overlayEntry?.remove();
                                  _overlayEntry=null;
                                  setState(() {
                                  });
                                },
                              )),
                        ),
                      ),
                    ],
                  )
                  ),

            ),
          ),
        );
  }
  OverlayEntry _createOverlay2() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    print('i have  been  summoned ');
    var size = renderBox.size;
    return OverlayEntry(
        builder: (context) => Positioned(
          width: Responsive.isMobile(context) ? ((MediaQuery.of(context).size.width )-26) : ((MediaQuery.of(context).size.width /2)-26),
          child: CompositedTransformFollower(
            link: _layerLink2,
            showWhenUnlinked: false,
            offset: Offset(0.0,  55.0),
            child: Material(
              elevation: 5.0,
              child:
                  Column(
                    children: [
                      SizedBox(height: 15,),
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
                          _overlayEntry?.remove();
                          _overlayEntry=null;


                        },
                        icon: Icon(Icons.cancel),
                        label: Text(
                          "Cancel",
                        ),
                      ),
                      SingleChildScrollView(
                        child: productsSearch.isEmpty? Text("No product found."):Column(
                          children: List.generate(
                              productsSearch!.length,
                                  (index) => GestureDetector(
                                child:  ListTile(
                                  title: Text(productsSearch[index].name!),
                                ),
                                onTap: (){
                                  InvoiceItem invoiceItem = new InvoiceItem(units: 1 ,unitPrice:products[index].price , description:products[index].name??"", total: products[index].price );
                                  if(invoice!.invoiceItems == null) {
                                    invoice!.invoiceItems = [invoiceItem];
                                  }else{
                                    invoice!.invoiceItems!.add(invoiceItem);
                                  }
                                  myController.add([TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]);

                                  print("Tapping has occured");
                                  _overlayEntry?.remove();
                                  _overlayEntry=null;
                                  setState(() {
                                  });
                                },
                              )),
                        ),
                      ),
                    ],
                  )
                  ),

            ),
          ),
        );
  }
  resetOverlay(asycClients){
    if (_focusNode.hasFocus) {
      _overlayEntry?.remove();
      _overlayEntry=null;
      _overlayEntry = _createOverlay();
      overlayState!.insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry=null;
    }
  }

  resetOverlay2(asycClients){
    if (_focusNode2.hasFocus) {
      _overlayEntry?.remove();
      _overlayEntry=null;
      _overlayEntry = _createOverlay2();
      overlayState!.insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry=null;
    }
  }

  @override
  void dispose() {
    myController.forEach((e) {
      e.forEach((a) {
        a.dispose();
      });
    });
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _initInvoice();
    myController.forEach((e) {
      e.forEach((a) {
        a.addListener(_printLatestValue);
      });
    });

    overlayState = Overlay.of(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      globalKey;
    });

    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus) {
    //     _overlayEntry = _createOverlay();
    //     overlayState!.insert(_overlayEntry!);
    //   } else {
    //     _overlayEntry?.remove();
    // _overlayEntry=null;
    //   }
    // });
  }



  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    crossAxisCount= _size.width < 650 ? 2 : 4;
    childAspectRatio= _size.width < 650 ? 2 : 2;

    // paymentAmount = invoice.subTotalAmount?.toString() ?? "0";
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              // Header(),
              SizedBox(height: defaultPadding),
              ReceiptHeader(title: widget.title,),
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



    double total = 0;

      invoice.invoiceItems?.forEach((i) {
        total += i.total ?? 0;
      });

      invoice?.subTotalAmount = total;




    Future<Invoice?> saveInvoice() async {

      var state = 0;
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
    final Size _size = MediaQuery.of(context).size;


    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 0.0,
      ),
      child: Responsive(
        mobile: Column(children: [
          _mainForm(),
          clickCard()
        ],),
        tablet:Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width /2)-26,
              child: _mainForm(),
            ),
            SizedBox(width: 4,),
            SizedBox(
              width: (MediaQuery.of(context).size.width /2)-26,
              child: clickCard(),
            )

        ],),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width /2)-26,
                child: _mainForm(),
              ),
              SizedBox(width: 4,),

              SizedBox(
                width: (MediaQuery.of(context).size.width /2)-26,
                child: clickCard(),
              )

            ],),),
    );






  }



  Widget _mainForm(){
    Future<Invoice?> saveInvoice() async {

      var state = 0;
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

    return Form(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CompositedTransformTarget(
            link: _layerLink,
            child:
                 TextFormField(
                  focusNode: _focusNode,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  onChanged: (v) async {
                    clients = await searchClients(v);
                    resetOverlay(clients);
                    setState(() {
                    });
                  },
                  // decoration: kTextInputDecoration.copyWith(labelText: 'Country Name'),

                )


          ),
          SizedBox(height: 10,),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(padding: EdgeInsets.only(top: 5),
                child:Icon(Icons.person),
              ),

              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text((invoice?.client?.name??"Customer"), style: TextStyle(fontSize: 20 ) ),
                  Text("Loyalty Program", style: TextStyle(fontSize: 16 ) ),

                ],),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: warningColor,
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
                    if(invoice.business == null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select or add your business details in profile."),
                      ));
                      return;
                    }

                    invoice.invoiceStatus = 'CANCELLED';
                    invoice.isSynced = false;
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
                icon: Icon(Icons.document_scanner),
                label: Text(
                  "Customer Info",
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: infoColor,
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
                  if(invoice.business == null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please select or add your business details in profile."),
                    ));
                    return;
                  }

                  if(invoice.invoiceStatus == 'PAID'){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invoice already paid."),
                    ));
                  }else {
                    invoice.invoiceStatus = 'UNPAID';
                    invoice.isSynced = false;
                    invoice.save();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Marked as unpaid'),
                    ));
                  }
                  setState(() {

                  });

                },
                icon: Icon(Icons.wallet),
                label: Text(
                  "PURCHASES",
                ),
              ),
            ],
          ),
          SizedBox(height:20),
          CompositedTransformTarget(
              link: _layerLink2,
              child:
              TextFormField(
                focusNode: _focusNode2,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                onChanged: (v) async {
                  productsSearch = await searchProducts(v);
                  resetOverlay2(productsSearch);
                  setState(() {
                  });
                },
                // decoration: kTextInputDecoration.copyWith(labelText: 'Country Name'),

              )


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
            mainAxisSize: MainAxisSize.min,
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
                  child: Text((invoice.currencyFull?.symbol??'')+" " + invoice.subTotalAmount.toString()! ),
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child:SizedBox(width: 600.0)),
              Text("Credit"),
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
                  child: Text((invoice.currencyFull?.symbol??'')+" 0" ),
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
            mainAxisSize: MainAxisSize.min,
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
                  child: Text((invoice.currencyFull?.symbol??'')+" "+invoice.subTotalAmount.toString()! ),
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: dangerColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                    defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () async {

                  await saveInvoice();


                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Invoice saved"),
                  ));

                  setState(() {

                  });

                },
                icon: Icon(Icons.delete),
                label: Text(
                  "Delete",
                ),
              ),
              SizedBox(width: 15,),


              Container(
                // margin: EdgeInsets.only(left: defaultPadding),
                // padding: EdgeInsets.symmetric(
                //   horizontal: defaultPadding,
                //   vertical: defaultPadding / 16,
                // ),
                decoration: BoxDecoration(
                  color: defaultColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.white10),
                ),
                child: TextButton(
                  child: Text("Add Payment", style: TextStyle(color: Colors.white) ),
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
                            Text( "Payment Date:   ", style: TextStyle(fontWeight: FontWeight.bold),
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
                            Text( "Total Paid:          ", style: TextStyle(fontWeight: FontWeight.bold),
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
                                initialValue: invoice.totalAmount?.toString()??"0",


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
                        backgroundColor: defaultColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical:
                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () async {
                        var pay = new Payment.fromJson({});

                        pay.total = double.parse(paymentAmount);
                        pay.paymentDate = dateTimeFormat.format(payDate);
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
          SizedBox(height: 20.0),

          SizedBox(height: 24.0),
          // _listView(persons),
        ],
      ),
    );
  }


  Widget businessProfile(Business c) {
    return GestureDetector(
      child: Text(c.name!) ,
      onTap: (){
        invoice.business = c;
        Navigator.of(context).pop();
        setState(() {

        });
      },
    );
  }

  Widget clickCard() {
    // this.crossAxisCount = 4;
    // this.childAspectRatio = 1;
    return SizedBox(
      // width: 500,
      child: Column(
        children: [
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) =>

                GestureDetector(
                  child: TileWidget(dailyData: categories[index].name??"", color: Colors.lightBlueAccent,),
                  onTap: () async {
                    products = await getFeaturedProducts(categoryId:categories[index].id );
                    setState(() {
                    });
                    print("I select category and refresh products to category with id :"+ index.toString());
                  },
                ),
          ),
          SizedBox(height: defaultPadding,),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) =>
                GestureDetector(
                  child: TileWidget(dailyData: products[index].name??"", color: Colors.lightGreen,),
                  onTap: (){
                    setState ((){
                      InvoiceItem invoiceItem = new InvoiceItem(units: 1 ,unitPrice:products[index].price , description:products[index].name??"", total: products[index].price );
                      if(invoice!.invoiceItems == null) {
                        invoice!.invoiceItems = [invoiceItem];
                      }else{
                        invoice!.invoiceItems!.add(invoiceItem);
                      }

                  myController.add([TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()]);
                    });
                    print("I add products to the receipt with id :"+ index.toString());
                  },
                ),
          ),
          SizedBox(height: defaultPadding,),
          // GridView.builder(
          //   physics: NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   itemCount: posmenu.length,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: crossAxisCount,
          //     crossAxisSpacing: defaultPadding,
          //     mainAxisSpacing: defaultPadding,
          //     childAspectRatio: childAspectRatio,
          //   ),
          //   itemBuilder: (context, index) =>
          //       GestureDetector(
          //         child: TileWidget(dailyData: categories[index]),
          //         onTap: (){
          //           print("I await your command :"+ index.toString());
          //         },
          //       ),
          // ),
        ],
      ),
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
                // onTapOutside: (value){
                //   setState(() {});
                // },
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
              child: Text(
                  myController[index][1].text

              )
              ,)

        ),
        DataCell(
            Padding(padding: EdgeInsets.all(3),
              child: Text(
                  myController[index][2].text

              ),
            )

        ),
        DataCell(
            Padding(padding: EdgeInsets.all(3),

              child: Text(
                  myController[index][3].text

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
              )
              : SizedBox(width: 0,),
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

