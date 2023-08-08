
import 'package:flutter/cupertino.dart';

import '../../main.dart';
import 'Currency.dart';

class InvoiceItem {
  int?    id;
  String? product;
  double? unitPrice;
  num? units;
  double? total;
  int? invoiceId;
  String? description;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;



  InvoiceItem({
    this.id,
    this.product,
    this.unitPrice,
    this.units,
    this.total,
    this.invoiceId,
    this.description,

    this.universalId,
    this.isSynced,
    this.originId,
    this.version,
    this.isConfirmed

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
  InvoiceItem.fromSycJson(Map<String, dynamic> json) {
    // id = json['originId'];
    universalId = json['id'];
    product = json['product'];
    unitPrice = json['unitPrice'];
    units = json['units'];
    total = json['total'];
    invoiceId = json['invoiceId'];
    description = json['description'];

    version = json['version'];
    isConfirmed = json['isConfirmed'];

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
  Map<String, dynamic> toSyncJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.universalId??null;
    data['originId'] = this.id??0;

    data['product'] = this.product;
    data['productId'] = null;
    data['unitPrice'] = this.unitPrice;
    data['units'] = this.units;
    data['total'] = this.total;
    data['description'] = this.description;
    // if(data['originId']==null){
    //   print("No origin id");
    // }
    return data;
  }


  Future<int> saveAndAttach(int invoiceId) async {
    debugPrint('adding   invoice_item');
    if(this.id==null && this.universalId!=null ) {
      InvoiceItem existing = await getInvoiceItemByUni(this.universalId!);
      this.id = existing.id;
    }

    Map<String, dynamic> row = {
      'id': this.id,
      'product': this.product,
      'unit_price': this.unitPrice,
      'units': this.units,
      'total': this.total,
      'invoice_id': invoiceId,
      'description': this.description,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
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
  Future<int> saveSyncedAndAttach(int invoiceId) async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    debugPrint('adding   invoice_item');
    if(this.id==null && this.universalId!=null ) {
      InvoiceItem existing = await getInvoiceItemByUni(this.universalId!);
      this.id = existing.id;
    }

    Map<String, dynamic> row = {
      'id': this.id,
      'product': this.product,
      'unit_price': this.unitPrice,
      'units': this.units,
      'total': this.total,
      'invoice_id': invoiceId,
      'description': this.description,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
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
  Future<int> updateSyncedAndAttach(int invoiceId) async {

    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    if(this.id!=null){
      print("id is not required");
      throw Error();
    }
    debugPrint('adding   invoice_item');
    if(this.id==null && this.universalId!=null ) {
      InvoiceItem existing = await getInvoiceItemByUni(this.universalId!);
      this.id = existing.id;
    }

    Map<String, dynamic> row = {
      'id': this.id,
      'product': this.product,
      'unit_price': this.unitPrice,
      'units': this.units,
      'total': this.total,
      'invoice_id': invoiceId,
      'description': this.description,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
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
    if(this.id!=null) {
      final rowsDeleted = await dbHelper.delete('invoice_item', this.id!);
      debugPrint('deleted $rowsDeleted row(s): row $id');

    }
  }

  String? getIndex(int index, Currency currency) {
    switch (index) {
      // case 0:
      //   return id.toString();
      case 0:
        return description;
      case 1:
        return unitPrice?.toStringAsFixed(2);
      case 2:
        return units.toString();
      case 3:
        return currency.symbol!+total!.toStringAsFixed(2);
    }
    return '';
  }
}

//Get invoice items for invoice
Future<List<InvoiceItem>> getInvoiceItems(int id) async {
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

      universalId : maps?[i]["universal_id"],
      // isOptimised : maps?[i]["is_optimised"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });

}


Future<InvoiceItem> getInvoiceItemByUni(int id, {bool? copy}) async {
  final maps = await dbHelper.findByIdUni("invoice_item", id);
  return InvoiceItem(
    id : maps?['id'],
    product : maps?['product'],
    unitPrice : maps?['unit_price'],
    units : maps?['units'],
    total : maps?['total'],
    invoiceId : maps?['invoiceId'],
    description : maps?['description'],
    universalId : maps?["universal_id"],
    isSynced : maps?["is_synced"]==1?true:false,
    originId : maps?["origin_id"],
    version : maps?["version"],
    isConfirmed : maps?["is_confirmed"]==1?true:false,

  );

}
