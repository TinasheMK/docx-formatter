import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import '../../main.dart';

class InvoiceItem {
  int?    id;
  String? product;
  Double? unitPrice;
  Double? total;
  int? invoiceId;
  String? description;



  InvoiceItem(
    this.id,
    this.product,
    this.unitPrice,
    this.total,
    this.invoiceId,
    this.description,

      );

  InvoiceItem.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    unitPrice = json['unitPrice'];
    total = json['total'];
    invoiceId = json['invoiceId'];
    description = json['description'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['product'] = this.product;
    data['unitPrice'] = this.unitPrice;
    data['total'] = this.total;
    data['invoiceId'] = this.invoiceId;
    data['description'] = this.description;
    return data;
  }

  Future<void> save() async {
    Map<String, dynamic> row = {
      'product': this.product,
      'unitPrice': this.unitPrice,
      'total': this.total,
      'invoiceId': this.invoiceId,
      'description': this.description,
    };
    final id = await dbHelper.insert("invoice_item", row);
    this.id = id;
    debugPrint('inserted invoice_item row id: $id');
  }

  Future<void> saveAndAttach(int companyId) async {
    debugPrint('adding   invoice_item');

    Map<String, dynamic> row = {
      'product': this.product,
      'unitPrice': this.unitPrice,
      'total': this.total,
      'invoiceId': this.invoiceId,
      'description': this.description,
    };
    final id = await dbHelper.insert("invoice_item", row);
    this.id = id;
    debugPrint('inserted invoice_item row id: $id');
  }

  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('invoice_item');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void update() async {
    // row to update
    Map<String, dynamic> row = {
      'product': this.product,
      'unitPrice': this.unitPrice,
      'total': this.total,
      'invoiceId': this.invoiceId,
      'description': this.description,
    };
    final rowsAffected = await dbHelper.update('invoice_item',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('company');
    final rowsDeleted = await dbHelper.delete('invoice_item',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}