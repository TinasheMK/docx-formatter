import 'dart:ffi';

import 'package:flutter/cupertino.dart';
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
  Bool? published;
  String? notes;
  Double? discount;
  String? invoiceDate;
  String? dueDate;
  InvoiceStatus? invoiceStatus;
  int?      client;
  Client?   clientFull;
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
    final id = await dbHelper.insert("invoice", row);
    this.id = id;
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
}



Future<List<Invoice>> getInvoices() async {
  final maps = await dbHelper.queryAllRows("invoice");

  return List.generate(maps.length, (i) {

    return Invoice(

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
      payments : maps[i]['payments'],
      invoiceitems : maps[i]['invoice_items'],


    );
  });
}
