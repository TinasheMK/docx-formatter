import 'package:flutter/cupertino.dart';

import '../../../main.dart';

class Payment {
  int? id;
  String? ref;
  String? status;
  double? total;
  String? paymentDate;
  int? invoiceId;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;


  Payment({
    this.id,
    this.ref,
    this.status,
    this.total,
    this.paymentDate,
    this.invoiceId,

    this.universalId,
    this.isSynced,
    this.originId,
    this.version,
    this.isConfirmed
  } );

  Payment.fromJson(Map<String, dynamic> json) {

    ref = json['ref'];
    status = json['status'];
    total = json['total'];
    paymentDate = json['paymentDate'];
    invoiceId = json['invoiceId'];

  }

  Payment.fromSyncJson(Map<String, dynamic> json) {
    // id = json['originId'];
    universalId = json['id'];
    ref = json['ref'];
    status = json['status'];
    total = json['total'];
    paymentDate = json['paymentDate'];
    invoiceId = json['invoiceId'];

    version = json['version'];
    isConfirmed = json['isConfirmed'];

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
  Map<String, dynamic> toSyncJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.universalId??null;
    data['originId'] = this.id;

    data['ref']= this.ref;
    data['status']= this.status;
    data['total']= this.total;
    data['paymentDate']= this.paymentDate;
    // if(data['originId']==null){
    //   print("No origin id");
    //   throw Error();
    // }
    return data;
  }


  Future<int> saveAndAttach(int companyId) async {
    debugPrint('adding   payment');
    if(this.id==null && this.universalId!=null ) {
      Payment existing = await getPaymentByUni(this.universalId!);
      this.id = existing.id;
    }

    Map<String, dynamic> row = {
      'id': this.id,
      'ref': this.ref,
      'status': this.status,
      'invoice_id': this.invoiceId,
      'total': this.total,
      'payment_date': this.paymentDate,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
    };
    var id;

    if(this.id==null) {
      final id = await dbHelper.insert("payment", row);
    }else{
      dbHelper.update('payment',row);
      id = this.id;
    }


    debugPrint('inserted payment row id: $id');
    return id;
  }
  Future<int> saveSyncedAndAttach(int companyId) async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    debugPrint('adding   payment');
    if(this.id==null && this.universalId!=null ) {
      Payment existing = await getPaymentByUni(this.universalId!);
      this.id = existing.id;
    }

    Map<String, dynamic> row = {
      'id': this.id,
      'ref': this.ref,
      'status': this.status,
      'invoice_id': this.invoiceId,
      'total': this.total,
      'payment_date': this.paymentDate,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
    };
    var id;

    if(this.id==null) {
      final id = await dbHelper.insert("payment", row);
    }else{
      dbHelper.update('payment',row);
      id = this.id;
    }


    debugPrint('inserted payment row id: $id');
    return id;
  }
  Future<int> updateSyncedAndAttach(int companyId) async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    if(this.id==null){
      print("id is required");
      throw Error();
    }
    debugPrint('adding   payment');
    if(this.id==null && this.universalId!=null ) {
      Payment existing = await getPaymentByUni(this.universalId!);
      this.id = existing.id;
    }

    Map<String, dynamic> row = {
      'id': this.id,
      'ref': this.ref,
      'status': this.status,
      'invoice_id': this.invoiceId,
      'total': this.total,
      'payment_date': this.paymentDate,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
    };
    var id;

    if(this.id==null) {
      final id = await dbHelper.insert("payment", row);
    }else{
      dbHelper.update('payment',row);
      id = this.id;
    }


    debugPrint('inserted payment row id: $id');
    return id;
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






Future<List<Payment>> getInvoicePayments(int id) async {
  final maps = await dbHelper.findInvoicePayments("payment", id);

  return List.generate(maps.length, (i) {
    return Payment(
      id : maps[i]['id'],
      ref : maps[i]['ref'],
      status : maps[i]['status'],
      total : maps[i]['total'],
      paymentDate : maps[i]['payment_date'],
      invoiceId : maps[i]['invoice_id'],

      universalId : maps?[i]["universal_id"],
      // isOptimised : maps?[i]["is_optimised"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,


    );
  });

}

Future<Payment> getPaymentByUni(int id, {bool? copy}) async {
  final maps = await dbHelper.findByIdUni("payment", id);
  return Payment(
    id : maps?['id'],
    ref : maps?['ref'],
    status : maps?['status'],
    total : maps?['total'],
    paymentDate : maps?['payment_date'],
    invoiceId : maps?['invoice_id'],
    universalId : maps?["universal_id"],
    isSynced : maps?["is_synced"]==1?true:false,
    originId : maps?["origin_id"],
    version : maps?["version"],
    isConfirmed : maps?["is_confirmed"]==1?true:false,

  );

}
