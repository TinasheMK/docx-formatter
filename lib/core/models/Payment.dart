import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import '../../main.dart';

class Payment {
  int? id;
  String? ref;
  String? status;
  Double? total;
  DateTime? paymentDate;
  int? invoiceId;


  Payment(
    this.id,
    this.ref,
    this.status,
    this.total,
    this.paymentDate,
      this.invoiceId
      );

  Payment.fromJson(Map<String, dynamic> json) {

    ref = json['ref'];
    status = json['status'];
    total = json['total'];
    paymentDate = json['paymentDate'];
    invoiceId = json['invoiceId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id']= this.id;
    data['ref']= this.ref;
    data['status']= this.status;
    data['total']= this.total;
    data['invoiceId']= this.invoiceId;
    data['paymentDate']= this.paymentDate;
    return data;
  }

  Future<void> save() async {
    Map<String, dynamic> row = {
      'id': this.id,
      'ref': this.ref,
      'status': this.status,
      'total': this.total,
      'invoiceId': this.invoiceId,
      'paymentDate': this.paymentDate,
    };
    final id = await dbHelper.insert("payment", row);
    this.id = id;
    debugPrint('inserted payment row id: $id');
  }

  Future<void> saveAndAttach(int companyId) async {
    debugPrint('adding   payment');

    Map<String, dynamic> row = {
      'id': this.id,
      'ref': this.ref,
      'status': this.status,
      'invoiceId': this.invoiceId,
      'total': this.total,
      'paymentDate': this.paymentDate,
    };
    final id = await dbHelper.insert("payment", row);
    this.id = id;
    debugPrint('inserted payment row id: $id');
  }

  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('payment');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void update() async {
    // row to update
    Map<String, dynamic> row = {
      'id': this.id,
      'ref': this.ref,
      'status': this.status,
      'invoiceId': this.invoiceId,
      'total': this.total,
      'paymentDate': this.paymentDate,
    };
    final rowsAffected = await dbHelper.update('payment',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('company');
    final rowsDeleted = await dbHelper.delete('payment',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}