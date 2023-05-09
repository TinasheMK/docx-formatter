
import 'package:flutter/cupertino.dart';
import 'package:smart_admin_dashboard/providers/registration/Company.dart';
import '../../main.dart';
import '../../screens/generator/databaseHelper.dart';
import 'Client.dart';
import 'InvoiceItem.dart';
import 'Payment.dart';

class Invoice {
  int?    id;
  double? totalAmount;
  double? vatPercent;
  double? vatAmount;
  double? subTotalAmount;
  bool? published;
  String? notes;
  double? discount;
  String? invoiceDate;
  String? dueDate;
  String? invoiceStatus;
  int?      client;
  Client?   clientFull;
  int?   company;
  Company?   companyFull;
  List<Payment>?     payments;
  List<InvoiceItem>? invoiceitems;


  Invoice({
    this.id,
    this.totalAmount,
    this.vatPercent,
    this.vatAmount,
    this.subTotalAmount,
    this.published,
    this.notes,
    this.discount,
    this.invoiceDate,
    this.dueDate,
    this.invoiceStatus,
    this.client,
    this.clientFull,
    this.payments,
    this.invoiceitems,
  });

 Invoice.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   totalAmount = json['totalAmount'];
   vatPercent = json['vatPercent'];
   vatAmount = json['vatAmount'];
   subTotalAmount = json['subTotalAmount'];
   published = json['published'];
   notes = json['notes'];
   discount = json['discount'];
   invoiceDate = json['invoiceDate'];
   dueDate = json['dueDate'];
   invoiceStatus = json['invoiceStatus'];
   client = json['client'];
   payments = json['payments'];
   invoiceitems = json['invoiceitems'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['totalAmount'] = this.totalAmount;
    data['vatPercent'] = this.vatPercent;
    data['vatAmount'] = this.vatAmount;
    data['subTotalAmount'] = this.subTotalAmount;
    data['published'] = this.published;
    data['notes'] = this.notes;
    data['discount'] = this.discount;
    data['invoiceDate'] = this.invoiceDate;
    data['dueDate'] = this.dueDate;
    data['invoiceStatus'] = this.invoiceStatus;
    data['client'] = this.client;
    data['invoiceitems'] = this.invoiceitems?.map((item) => item.toJson());
    data['payments'] = this.payments?.map((item) => item.toJson());
    // data['clientFull'] = this.clientFull.toJson();

    return data;


  }


  Future<void> save() async {
    Map<String, dynamic> row = {

      "id": this.id,
      "total_amount": this.totalAmount,
      "vat_percent": this.vatPercent,
      "vat_amount": this.vatAmount,
      "sub_total_amount": this.subTotalAmount,
      "published": this.published,
      "notes": this.notes,
      "discount": this.discount,
      "invoice_date": this.invoiceDate,
      "due_date": this.dueDate,
      "invoice_status": this.invoiceStatus,
      "client": this.client


    };

    var id;

    if(this.id==null) {
      id = await dbHelper.insert("invoice", row);
    }else{
      final rowsAffected = await dbHelper.update("invoice",row);
      id = this.id;
    }

    var invs = this.invoiceitems;
    var pays = this.payments;

    for(int i=0; i<30; i++){{
      try {
        invs?[i]?.saveAndAttach(id);
        pays?[i]?.saveAndAttach(id);
      }catch(err) {}

      }
    }


    debugPrint('inserted invoice row id: $id');
  }


  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('invoice');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void update() async {
    // row to update
    Map<String, dynamic> row = {

      "totalAmount": this.totalAmount,
      "vatPercent": this.vatPercent,
      "vatAmount": this.vatAmount,
      "subTotalAmount": this.subTotalAmount,
      "published": this.published,
      "notes": this.notes,
      "discount": this.discount,
      "invoiceDate": this.invoiceDate,
      "dueDate": this.dueDate,
      "invoiceStatus": this.invoiceStatus,
      "clients": this.client,
      "payments": this.payments,


    };
    final rowsAffected = await dbHelper.update('invoice',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('invoice');
    final rowsDeleted = await dbHelper.delete('invoice',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}

enum InvoiceStatus {
  UNPAID,
  PAID,
  PROCESSED,
  CANCELLED,
  DRAFT,
  REFUNDED,
  PUBLISHED,
  OVERDUE,
}



Future<List<Invoice>> getInvoices({String? filter}) async {
  var maps;

  filter!=null && filter != 'ALL'
      ?maps = await dbHelper.queryFilteredInvoices("invoice",filter: filter)
      :maps = await dbHelper.queryFilteredInvoices("invoice");

  List<Invoice> invoices = [];
  for( int i =0; i  <maps.length; i++)   {

    Client client = await getClient(maps[i]['client']);

    invoices.add(
        Invoice(

      id : maps[i]['id'],
      totalAmount : maps[i]['total_amount'],
      vatPercent : maps[i]['vat_percent'],
      vatAmount : maps[i]['vat_amount'],
      subTotalAmount : maps[i]['sub_total_amount'],
      published : maps[i]['published'],
      notes : maps[i]['notes'],
      discount : maps[i]['discount'],
      invoiceDate : maps[i]['invoice_date'],
      dueDate : maps[i]['due_date'],
      invoiceStatus : maps[i]['invoice_status'],
      client : maps[i]['client'],
      clientFull: client,
      payments : maps[i]['payments'],
      invoiceitems : maps[i]['invoice_items'],


    ));
  };

  return invoices;
}


Future<Invoice> getInvoice(id) async {
  final maps = await dbHelper.findById("invoice", id);
  Client client = await getClient(maps['client']);
  List<InvoiceItem> invoiceItems = await getInvoiceItems(maps['id']);

  return Invoice(
    id : maps['id'],
    totalAmount : maps['total_amount'],
    vatPercent : maps['vat_percent'],
    vatAmount : maps['vat_amount'],
    subTotalAmount : maps['sub_total_amount'],
    published : maps['published'],
    notes : maps['notes'],
    discount : maps['discount'],
    invoiceDate : maps['invoice_date'],
    dueDate : maps['due_date'],
    invoiceStatus : maps['invoice_status'],
    client : maps['client'],
    clientFull: client,
    payments : maps['payments'],
    invoiceitems : invoiceItems,

  );

}


