
import 'package:flutter/cupertino.dart';

import '../../main.dart';

class InvoiceItem {
  int?    id;
  String? product;
  double? unitPrice;
  num? units;
  double? total;
  int? invoiceId;
  String? description;



  InvoiceItem({
    this.id,
    this.product,
    this.unitPrice,
    this.units,
    this.total,
    this.invoiceId,
    this.description,

  });

  InvoiceItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    unitPrice = json['unitPrice'];
    units = json['units'];
    total = json['total'];
    invoiceId = json['invoiceId'];
    description = json['description'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['product'] = this.product;
    data['unitPrice'] = this.unitPrice;
    data['units'] = this.units;
    data['total'] = this.total;
    data['invoiceId'] = this.invoiceId;
    data['description'] = this.description;
    return data;
  }

  Future<void> save() async {
    Map<String, dynamic> row = {
      'product': this.product,
      'unitPrice': this.unitPrice,
      'units': this.units,
      'total': this.total,
      'invoiceId': this.invoiceId,
      'description': this.description,
    };
    final id = await dbHelper.insert("invoice_item", row);
    this.id = id;
    debugPrint('inserted invoice_item row id: $id');
  }

  Future<int> saveAndAttach(int invoiceId) async {
    debugPrint('adding   invoice_item');

    Map<String, dynamic> row = {
      'id': this.id,
      'product': this.product,
      'unit_price': this.unitPrice,
      'units': this.units,
      'total': this.total,
      'invoice_id': invoiceId,
      'description': this.description,
    };

    print(row);
    var id;

    if(this.id==null) {
      id = await dbHelper.insert("invoice_item", row);
      this.id = id;
      print('the id is $id');
    }else{
      dbHelper.update('invoice_item',row);
      id = this.id;
    }


    this.id = id;
    debugPrint('inserted invoice_item row id: $id');
    return id;
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
      'units': this.units,
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

  String? getIndex(int index) {
    switch (index) {
      case 0:
        return id.toString();
      case 1:
        return description;
      case 2:
        return unitPrice.toString();
      case 3:
        return units.toString();
      case 4:
        return total.toString();
    }
    return '';
  }
}

Future<List<InvoiceItem>> getInvoiceItems(id) async {
  final maps = await dbHelper.findInvoiceItems("invoice_item", id);

  return List.generate(maps.length, (i) {
    return InvoiceItem(
      id : maps[i]['id'],
      product : maps[i]['product'],
      unitPrice : maps[i]['unit_price'],
      units : maps[i]['units'],
      total : maps[i]['total'],
      invoiceId : maps[i]['invoiceId'],
      description : maps[i]['description'],

    );
  });

}


//
// Future<List<InvoiceItem>> getInvoiceItems() async {
//   final maps = await dbHelper.queryAllRows("invoice_items");
//
//   return List.generate(maps.length, (i) {
//
//     return InvoiceItem(
//
//       id : maps[i]['id'],
//       totalAmount : maps[i]['totalAmount'],
//       vatPercent : maps[i]['vatPercent'],
//       vatAmount : maps[i]['vatAmount'],
//       subTotalAmount : maps[i]['subTotalAmount'],
//       published : maps[i]['published'],
//       notes : maps[i]['notes'],
//       discount : maps[i]['discount'],
//       invoiceDate : maps[i]['invoiceDate'],
//       dueDate : maps[i]['dueDate'],
//       invoiceStatus : maps[i]['invoiceStatus'],
//       client : maps[i]['client'],
//       payments : maps[i]['payments'],
//       invoiceitems : maps[i]['invoiceitems'],
//
//
//     );
//   });
// }

