import 'package:flutter/cupertino.dart';

import '../../main.dart';

class Payment {
  int? id;
  String? ref;
  String? status;
  double? total;
  String? paymentDate;
  int? invoiceId;


  Payment({
    this.id,
    this.ref,
    this.status,
    this.total,
    this.paymentDate,
    this.invoiceId
  } );

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
      'invoice_id': this.invoiceId,
      'payment_date': this.paymentDate,
    };

    var id;

    if(this.id==null) {
      final id = await dbHelper.insert("payment", row);
    }else{
      dbHelper.update('payment',row);
      id = this.id;
    }

    debugPrint('inserted payment row id: $id');
  }

  Future<void> saveAndAttach(int companyId) async {
    debugPrint('adding   payment');

    Map<String, dynamic> row = {
      'id': this.id,
      'ref': this.ref,
      'status': this.status,
      'invoice_id': this.invoiceId,
      'total': this.total,
      'payment_date': this.paymentDate,
    };
    var id;

    if(this.id==null) {
      final id = await dbHelper.insert("payment", row);
    }else{
      dbHelper.update('payment',row);
      id = this.id;
    }


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






Future<List<Payment>> getInvoicePayments(id) async {
  final maps = await dbHelper.findInvoicePayments("payment", id);

  return List.generate(maps.length, (i) {
    return Payment(
      id : maps[i]['id'],
      ref : maps[i]['ref'],
      status : maps[i]['status'],
      total : maps[i]['total'],
      paymentDate : maps[i]['payment_date'],
      invoiceId : maps[i]['invoice_id'],


    );
  });

}
