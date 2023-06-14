


import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:smart_admin_dashboard/providers/registration/Company.dart';
import 'package:smart_admin_dashboard/providers/registration/Currency.dart';
import '../../main.dart';
import '../compare_res.dart';
import 'Client.dart';
import 'InvoiceItem.dart';
import 'Payment.dart';

class Invoice {
  int? id;
  double? totalAmount;
  double? vatPercent;
  double? vatAmount;
  double? subTotalAmount;
  bool? published;
  String? notes;
  double? discount;
  String? invoiceDate;
  String? dueDate;
  String? invoiceNumber;
  String? invoiceStatus;
  String? currency;
  Currency? currencyFull;
  int?      clientId;
  Client?   client;
  int?   companyId;

  Company?   companyFull;
  List<Payment>?     payments;
  List<InvoiceItem>? invoiceItems;
  int?   universalId;
  bool?   isOptimised;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isChanged;


  Invoice({
    this.id,
    this.totalAmount,
    this.vatPercent,
    this.vatAmount,
    this.subTotalAmount,
    this.published,
    this.notes,
    this.currency,
    this.currencyFull,
    this.discount,
    this.invoiceDate,
    this.dueDate,
    this.invoiceNumber,
    this.companyId,
    this.invoiceStatus,
    this.clientId,
    this.client,
    this.payments,
    this.invoiceItems,
    this.universalId,
    this.isOptimised,
    this.isSynced,
    this.originId,
    this.version,
    this.isChanged
  });

 Invoice.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   totalAmount = json['totalAmount'];
   vatPercent = json['vatPercent'];
   vatAmount = json['vatAmount'];
   subTotalAmount = json['subTotalAmount'];
   published = json['published'];
   notes = json['notes'];
   currency = json['currency'];
   discount = json['discount'];
   invoiceDate = json['invoiceDate'];
   dueDate = json['dueDate'];
   invoiceNumber = json['invoiceNumber'];
   companyId = json['companyId'];
   originId = json['originId'];
   invoiceStatus = json['invoiceStatus'];
   clientId = json['clientId'];
   payments = json['payments'];
   isOptimised = json['isOptimised'];
   invoiceItems = json['invoiceItems'];
   isChanged = json['isChanged'];

  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['originId'] = this.id;
    data['universalId'] = this.universalId??null;
    data['isOptimised'] = this.isOptimised??null;
    data['isSynced'] = this.isSynced??"dev";
    data['originId'] = this.originId??"dev";
    data['version'] = this.version??null;
    data['isChanged'] = this.isChanged??null;
    data['totalAmount'] = this.totalAmount;
    data['vatPercent'] = this.vatPercent;
    data['vatAmount'] = this.vatAmount;
    data['subTotalAmount'] = this.subTotalAmount;
    data['published'] = this.published;
    data['notes'] = this.notes;
    data['currency'] = this.currency;
    data['companyId'] = this.companyId;
    data['discount'] = this.discount;
    // data['invoiceDate'] = this.invoiceDate.toString();
    // data['dueDate'] = this.dueDate.toString();
    data['invoiceNumber'] = this.invoiceNumber.toString();
    data['invoiceStatus'] = this.invoiceStatus;
    data['clientId'] = this.clientId;
    data['invoiceItems'] = this.invoiceItems?.map((item) => item.toJson());
    data['payments'] = this.payments?.map((item) => item.toJson());
    // data['client'] = this.client.toJson();

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
      "currency": this.currencyFull?.id,
      "company_id": this.companyId,
      "discount": this.discount,
      "invoice_date": this.invoiceDate,
      "due_date": this.dueDate,
      "invoice_number": this.invoiceNumber,
      "invoice_status": this.invoiceStatus,
      "client_id": this.clientId,
      "universal_id" : this.universalId,
      "is_optimised" : this.isOptimised,
      "is_synced" : this.isSynced,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_changed" : this.isChanged,


    };

    var id;

    if(this.id==null) {
      id = await dbHelper.insert("invoice", row);
      this.id = id;
    }else{
      final rowsAffected = await dbHelper.update("invoice",row);
      id = this.id;
    }

    var invs = this.invoiceItems;
    var pays = this.payments;

    for(int i=0; i<30; i++){{
      try {
        invs?[i]?.saveAndAttach(id);
        pays?[i]?.saveAndAttach(id);
      }catch(err) {}

      }
    }

    if(this.invoiceNumber == null){
      this.invoiceNumber = '#'+this.id.toString();
      save();
    };

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
      "currency": this.currency,
      "company_id": this.companyId,
      "discount": this.discount,
      "invoiceDate": this.invoiceDate,
      "dueDate": this.dueDate,
      "invoiceNumber": this.invoiceNumber,
      "invoiceStatus": this.invoiceStatus,
      "client_id": this.clientId,
      "payments": this.payments,
      "isChanged": this.isChanged,


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


  Future compare() async {
   Invoice newInv = await getInvoiceByUni(this.id);
   Invoice oldInv = await getInvoiceByUni(this.id, copy: true);

   List<CompareRes> comps = [] ;
   CompareRes comp = new CompareRes();

   if(newInv.invoiceStatus != oldInv.invoiceStatus && this.invoiceStatus != oldInv.invoiceStatus && newInv.invoiceStatus != this.invoiceStatus){
     comp.localValue = newInv.invoiceStatus;
     comp.oldValue = this.invoiceStatus;
     comp.field = "invoiceStatus";
     comps.add(comp);
    }
   //todo: Merge non conflicting fields


   return comps;

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



Future<List<Invoice>> getInvoices({String? filter, String? clientId}) async {
  var maps;
  print("Getting all invoices");

  filter!=null && filter != 'ALL'
      ?maps = await dbHelper.queryFilteredInvoices("invoice",filter: filter)
      :clientId!=null && clientId != 'CLIENTS'
      ?maps = await dbHelper.queryFilteredInvoices("invoice",clientId: clientId)
      :maps = await dbHelper.queryFilteredInvoices("invoice");

  List<Invoice> invoices = [];
  for( int i =0; i  <maps?.length; i++)   {

    Client client = await getClient(maps?[i]['client_id']);

    invoices.add(
        Invoice(

      id : maps?[i]['id'],
      totalAmount : maps?[i]['total_amount'],
      vatPercent : maps?[i]['vat_percent'],
      vatAmount : maps?[i]['vat_amount'],
      subTotalAmount : maps?[i]['sub_total_amount'],
      published : maps?[i]['published'],
      notes : maps?[i]['notes'],
          currency : maps?[i]['currency'],
      companyId : maps?[i]['company_id'],
      discount : maps?[i]['discount'],
      invoiceDate : maps?[i]['invoice_date'],
      dueDate : maps?[i]['due_date'],
      invoiceNumber : maps?[i]['invoice_number'],
      invoiceStatus : maps?[i]['invoice_status'],
      clientId : maps?[i]['client_id'],
      client: client,
      payments : maps?[i]['payments'],
      invoiceItems : maps?[i]['invoice_items'],
            universalId : maps?[i]["universal_id"],
            isOptimised : maps?[i]["is_optimised"],
            isSynced : maps?[i]["is_synced"],
          originId : maps?[i]["origin_id"],
            version : maps?[i]["version"],
            isChanged : maps?[i]["is_changed"],


    ));
  };

  return invoices;
}


Future<Invoice> getInvoice(id) async {
  final maps = await dbHelper.findById("invoice", id);
  Client client = await getClient(maps?['client_id']);
  List<InvoiceItem> invoiceItems = await getInvoiceItems(maps?['id']);

  return Invoice(
    id : maps?['id'],
    totalAmount : maps?['total_amount'],
    vatPercent : maps?['vat_percent'],
    vatAmount : maps?['vat_amount'],
    subTotalAmount : maps?['sub_total_amount'],
    published : maps?['published'],
    notes : maps?['notes'],
    currency : maps?['currency'],
    discount : maps?['discount'],
    invoiceDate : maps?['invoice_date'],
    dueDate : maps?['due_date'],
    invoiceNumber : maps?['invoice_number'],
    invoiceStatus : maps?['invoice_status'],
    clientId : maps?['client_id'],
    client: client,
    payments : maps?['payments'],
    companyId : maps?['company_id'],
    universalId : maps?["universal_id"],
    isOptimised : maps?["is_optimised"],
    isSynced : maps?["is_synced"],
    originId : maps?["origin_id"],
    version : maps?["version"],
    isChanged : maps?["is_changed"],
    invoiceItems : invoiceItems,

  );

}

Future<Invoice> getInvoiceByUni(id, {bool? copy}) async {
  var maps;
  Client client;
  List<InvoiceItem> invoiceItems;

  if(copy != null && copy==true){
    final maps = await dbHelper.findByIdUni("invoice", id.toString()+"cp");
    client = await getClient(maps?['client_id']);
    invoiceItems = await getInvoiceItems(maps?['id']);
  }else{
    final maps = await dbHelper.findByIdUni("invoice", id.toString());

    client = await getClient(maps?['client_id']);
    invoiceItems = await getInvoiceItems(maps?['id']);
  }


  return Invoice(
    id : maps?['id'],
    totalAmount : maps?['total_amount'],
    vatPercent : maps?['vat_percent'],
    vatAmount : maps?['vat_amount'],
    subTotalAmount : maps?['sub_total_amount'],
    published : maps?['published'],
    notes : maps?['notes'],
    currency : maps?['currency'],
    discount : maps?['discount'],
    invoiceDate : maps?['invoice_date'],
    dueDate : maps?['due_date'],
    invoiceNumber : maps?['invoice_number'],
    invoiceStatus : maps?['invoice_status'],
    clientId : maps?['client_id'],
    client: client,
    payments : maps?['payments'],
    companyId : maps?['company_id'],
    universalId : maps?["universal_id"],
    isOptimised : maps?["is_optimised"],
    isSynced : maps?["is_synced"],
    originId : maps?["origin_id"],
    version : maps?["version"],
    isChanged : maps?["is_changed"],
    invoiceItems : invoiceItems,

  );

}


