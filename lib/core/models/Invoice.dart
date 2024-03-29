


// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import '../../../main.dart';
import 'InvoiceItem.dart';
import 'Payment.dart';
import 'Client.dart';
import 'Business.dart';
import 'Currency.dart';
import 'InvoiceItem.dart';

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
  String? invoiceType;
  String? currency;
  Currency? currencyFull;
  int?      clientId;
  Client?   client;
  int?   businessId;

  Business?   business;
  List<Payment>?     payments;
  List<InvoiceItem>? invoiceItems;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;


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
    this.businessId,
    this.invoiceStatus,
    this.invoiceType,
    this.clientId,
    this.client,
    this.business,
    this.payments,
    this.invoiceItems,

    this.universalId,
    this.isSynced,
    this.originId,
    this.version,
    this.isConfirmed
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
    businessId = json['businessId'];
    originId = json['originId'];
    invoiceStatus = json['invoiceStatus'];
    invoiceType = json['invoiceType'];
    clientId = json['clientId'];
    payments = json['payments'];
    invoiceItems = json['invoiceItems'];
    isConfirmed = json['isConfirmed'];

  }
  Invoice.fromPostSyncJson(Map<String, dynamic> json) {
    id = json['originId'];
    version = json['version'];
    isConfirmed = json['isConfirmed'];
    universalId = json['id'];

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
    businessId = 1;
    originId = json['originId'];
    invoiceStatus = json['invoiceStatus'];
    invoiceType = json['invoiceType'];
    clientId = 1;
    // payments = json['payments'];
    // isOptimised = json['isOptimised'];
    // invoiceItems = json['invoiceItems'];
    invoiceItems = List<InvoiceItem>.from(json["invoiceItems"].map((x) => InvoiceItem.fromSycJson(x)));
    payments = List<Payment>.from(json["payments"].map((x) => Payment.fromSyncJson(x)));



  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['originId'] = this.id;
    data['universalId'] = this.universalId??null;
    // data['isOptimised'] = this.isOptimised??null;
    data['isSynced'] = this.isSynced??false;
    data['version'] = this.version;
    data['isConfirmed'] = this.isConfirmed??null;
    data['totalAmount'] = this.totalAmount;
    data['vatPercent'] = this.vatPercent;
    data['vatAmount'] = this.vatAmount;
    data['subTotalAmount'] = this.subTotalAmount;
    data['published'] = this.published;
    data['notes'] = this.notes;
    data['currency'] = this.currency;
    data['businessId'] = this.businessId;
    data['discount'] = this.discount;
    data['invoiceDate'] = this.invoiceDate;
    data['dueDate'] = this.dueDate;
    data['invoiceNumber'] = this.invoiceNumber.toString();
    data['invoiceStatus'] = this.invoiceStatus;
    data['invoiceType'] = this.invoiceType;
    data['clientId'] = this.clientId;
    data['invoiceItems'] = this.invoiceItems?.map((item) => item.toJson())??[];
    data['payments'] = this.payments?.map((item) => item.toJson())??[];
    // data['client'] = this.client.toJson();

    return data;


  }

  Map<String, dynamic> toSyncJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final Map<String, dynamic> client = new Map<String, dynamic>();
    final Map<String, dynamic> business = new Map<String, dynamic>();
    client['id'] = this.client?.universalId??1;
    business['id'] = this.business?.universalId??1;

    data['id'] = (this.isConfirmed??false)? (this.universalId??null): null;
    data['originId'] = this.id;

    data['isSynced'] = this.isSynced??false;
    data['version'] = (this.isConfirmed??false)?this.version:null;
    data['isConfirmed'] = this.isConfirmed??null;

    data['totalAmount'] = this.totalAmount;
    data['vatPercent'] = this.vatPercent;
    data['vatAmount'] = this.vatAmount;
    data['subTotalAmount'] = this.subTotalAmount;
    data['published'] = this.published;
    data['notes'] = this.notes;
    data['currency'] = this.currency;
    data['businessId'] = this.businessId;
    data['discount'] = this.discount;
    data['invoiceDate'] = this.invoiceDate;
    data['dueDate'] = this.dueDate;
    data['invoiceNumber'] = this.invoiceNumber.toString();
    data['invoiceStatus'] = this.invoiceStatus;
    data['invoiceType'] = this.invoiceType;
    // data['clientId'] = this.clientId;
    if(this.invoiceItems!=null&&!this.invoiceItems!.isEmpty)data['invoiceItems'] = this.invoiceItems?.map((item) => item.toSyncJson()).toList();
    if(this.payments!=null&&!this.payments!.isEmpty)data['payments'] = this.payments?.map((item) => item.toSyncJson()).toList();
    data['client'] = client;
    data['business'] = business;

    if(data['originId']==null){
      print("No origin id");
      throw Error();
    }
    if(data['invoiceItems']==null){
      print("No invoice items");
      throw Error();
    }

    return data;


  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "id": this.id,
      "total_amount": this.totalAmount,
      "vat_percent": this.vatPercent,
      "vat_amount": this.vatAmount,
      "sub_total_amount": this.subTotalAmount,
      "published": (this.published??false)?1:0,
      "notes": this.notes,
      "currency": this.currencyFull?.id,
      "business_id": this.businessId,
      "discount": this.discount,
      "invoice_date": this.invoiceDate,
      "due_date": this.dueDate,
      "invoice_number": this.invoiceNumber,
      "invoice_status": this.invoiceStatus,
      "invoice_type": this.invoiceType,
      "client_id": this.clientId,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,


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

    if(this.invoiceItems!=null) {
      for (int i = 0; i < this.invoiceItems!.length; i++) {
        {
          try {
            this.invoiceItems![i].id = await invs?[i].saveAndAttach(id);
          } catch (err) {}
        }
      }
    }

    if(this.payments!=null) {
      for (int i = 0; i < this.payments!.length; i++) {
        {
          debugPrint('\n');
          debugPrint('\n');
          debugPrint(this.payments![i].toJson().toString());
          debugPrint('\n');
          debugPrint('\n');
          debugPrint('\n');
          try {
            this.payments![i].id = await pays?[i].saveAndAttach(id);
          } catch (err) {}
        }
      }
    }

    if(this.invoiceNumber == null){
      this.invoiceNumber = '#'+this.id.toString();
      save();
    };

    debugPrint('inserted invoice row id: $id');
  }

  Future<void> saveSynced() async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }


    Map<String, dynamic> row = {
      "id": this.id,
      "total_amount": this.totalAmount,
      "vat_percent": this.vatPercent,
      "vat_amount": this.vatAmount,
      "sub_total_amount": this.subTotalAmount,
      "published": (this.published??false)?1:0,
      "notes": this.notes,
      "currency": this.currencyFull?.id,
      "business_id": this.businessId,
      "discount": this.discount,
      "invoice_date": this.invoiceDate,
      "due_date": this.dueDate,
      "invoice_number": this.invoiceNumber,
      "invoice_status": this.invoiceStatus,
      "invoice_type": this.invoiceType,
      "client_id": this.clientId,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,


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

    if(this.invoiceItems!=null) {
      for (int i = 0; i < this.invoiceItems!.length; i++) {
        {
          try {
            this.invoiceItems![i].id = await invs?[i].saveSyncedAndAttach(id);
          } catch (err) {}
        }
      }
    }

    if(this.payments!=null) {
      for (int i = 0; i < this.payments!.length; i++) {
        {
          debugPrint('\n');
          debugPrint('\n');
          debugPrint(this.payments![i].toJson().toString());
          debugPrint('\n');
          debugPrint('\n');
          debugPrint('\n');
          try {
            this.payments![i].id = await pays?[i].saveSyncedAndAttach(id);
          } catch (err) {}
        }
      }
    }

    if(this.invoiceNumber == null){
      this.invoiceNumber = '#'+this.id.toString();
      saveSynced();
    };

    debugPrint('inserted invoice row id: $id');
  }

  Future<void> updateSynced() async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    if(this.id==null){
      print("id is required");
      throw Error();
    }

    Map<String, dynamic> row = {
      "id": this.id,
      "total_amount": this.totalAmount,
      "vat_percent": this.vatPercent,
      "vat_amount": this.vatAmount,
      "sub_total_amount": this.subTotalAmount,
      "published": (this.published??false)?1:0,
      "notes": this.notes,
      "currency": this.currencyFull?.id,
      "business_id": this.businessId,
      "discount": this.discount,
      "invoice_date": this.invoiceDate,
      "due_date": this.dueDate,
      "invoice_number": this.invoiceNumber,
      "invoice_status": this.invoiceStatus,
      "invoice_type": this.invoiceType,
      "client_id": this.clientId,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,


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

    if(this.invoiceItems!=null) {
      List<InvoiceItem> pastItems = await getInvoiceItems(id);
      pastItems.forEach((e) {
        e.delete();
      });
      for (int i = 0; i < this.invoiceItems!.length; i++) {
        {
          try {
            this.invoiceItems![i].id = await invs?[i].updateSyncedAndAttach(id);
          } catch (err) {}
        }
      }
    }

    if(this.payments!=null) {
      List<Payment> pastItems = await getInvoicePayments(id);
      pastItems.forEach((e) {
        e.delete();
      });
      for (int i = 0; i < this.payments!.length; i++) {
        {
          debugPrint('\n');
          debugPrint('\n');
          debugPrint(this.payments![i].toJson().toString());
          debugPrint('\n');
          debugPrint('\n');
          debugPrint('\n');
          try {
            this.payments![i].id = await pays?[i].updateSyncedAndAttach(id);
          } catch (err) {}
        }
      }
    }

    if(this.invoiceNumber == null){
      this.invoiceNumber = '#'+this.id.toString();
      updateSynced();
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

enum InvoiceTypes {
  RECEIPT,
  INVOICE,
  QUOTATION,
}



Future<List<Invoice>> getInvoices(String type,String dateSort,  {String? filter, String? clientId}) async {
  var maps;
  print(filter );
  print(clientId);
  print(dateSort);
  if(filter == 'ALL') filter = null;
  if(clientId == 'CLIENTS') clientId = null;
  // if(order == 'id') order = null;
  // if(asc == null) asc = true;

  maps = await dbHelper.queryFilteredInvoices("invoice",type, dateSort, invoiceStatus: filter, clientId: clientId);


  // filter!=null && filter != 'ALL'
  //     ?maps = await dbHelper.queryFilteredInvoices("invoice",filter: filter)
  //     :clientId!=null && clientId != 'CLIENTS'
  //     ?maps = await dbHelper.queryFilteredInvoices("invoice",clientId: clientId)
  //     :maps = await dbHelper.queryFilteredInvoices("invoice");

  List<Invoice> invoices = [];
  for( int i =0; i  <maps?.length; i++)   {

    Client? client = await getClient(maps?[i]['client_id']);

    invoices.add(
        Invoice(

          id : maps?[i]['id'],
          totalAmount : maps?[i]['total_amount'],
          vatPercent : maps?[i]['vat_percent'],
          vatAmount : maps?[i]['vat_amount'],
          subTotalAmount : maps?[i]['sub_total_amount'],
          published : maps?[i]['published']==1?true:false,
          notes : maps?[i]['notes'],
          currency : maps?[i]['currency'],
          businessId : maps?[i]['business_id'],
          discount : maps?[i]['discount'],
          invoiceDate : maps?[i]['invoice_date'],
          dueDate : maps?[i]['due_date'],
          invoiceNumber : maps?[i]['invoice_number'],
          invoiceStatus : maps?[i]['invoice_status'],
          invoiceType : maps?[i]['invoice_type'],
          clientId : maps?[i]['client_id'],
          client: client,
          payments : maps?[i]['payments'],
          invoiceItems : maps?[i]['invoice_items'],
          universalId : maps?[i]["universal_id"],
          isSynced : maps?[i]["is_synced"]==1?true:false,
          originId : maps?[i]["origin_id"],
          version : maps?[i]["version"],
          isConfirmed : maps?[i]["is_confirmed"]==1?true:false,


        ));
  };

  return invoices;
}



Future<List<Invoice>> getInvoicesForSync() async {
  var maps;


  maps = await dbHelper.getReadyForSyc("invoice");


  List<Invoice> invoices = [];
  for( int i =0; i  <maps?.length; i++)   {

    Client? client = await getClient(maps?[i]['client_id']);
    List<InvoiceItem>invoiceItems = await getInvoiceItems(maps?[i]['id']);
    List<Payment>payments = await getInvoicePayments(maps?[i]['id']);
    Business? business = await getBusiness(maps?[i]['business_id']);

    invoices.add(
        Invoice(

          id : maps?[i]['id'],
          totalAmount : maps?[i]['total_amount'],
          vatPercent : maps?[i]['vat_percent'],
          vatAmount : maps?[i]['vat_amount'],
          subTotalAmount : maps?[i]['sub_total_amount'],
          published : maps?[i]['published']==1?true:false,
          notes : maps?[i]['notes'],
          currency : maps?[i]['currency'],
          businessId : maps?[i]['business_id'],
          discount : maps?[i]['discount'],
          invoiceDate : maps?[i]['invoice_date'],
          dueDate : maps?[i]['due_date'],
          invoiceNumber : maps?[i]['invoice_number'],
          invoiceStatus : maps?[i]['invoice_status'],
          invoiceType : maps?[i]['invoice_type'],
          clientId : maps?[i]['client_id'],
          client: client,
          business: business,
          payments :payments,
          invoiceItems : invoiceItems,

          universalId : maps?[i]["universal_id"],
          isSynced : maps?[i]["is_synced"]==1?true:false,
          originId : maps?[i]["origin_id"],
          version : maps?[i]["version"],
          isConfirmed : maps?[i]["is_confirmed"]==1?true:false,


        ));
  };

  return invoices;
}


Future<Invoice> getInvoice(int id) async {
  final maps = await dbHelper.findById("invoice", id);
  Client? client = await getClient(maps?['client_id']);
  List<InvoiceItem> invoiceItems = await getInvoiceItems(maps?['id']);

  return Invoice(
    id : maps?['id'],
    totalAmount : maps?['total_amount'],
    vatPercent : maps?['vat_percent'],
    vatAmount : maps?['vat_amount'],
    subTotalAmount : maps?['sub_total_amount'],
    published : maps?['published']==1?true:false,
    notes : maps?['notes'],
    currency : maps?['currency'],
    discount : maps?['discount'],
    invoiceDate : maps?['invoice_date'],
    dueDate : maps?['due_date'],
    invoiceNumber : maps?['invoice_number'],
    invoiceStatus : maps?['invoice_status'],
    invoiceType : maps?['invoice_type'],
    clientId : maps?['client_id'],
    client: client,
    payments : maps?['payments'],
    businessId : maps?['business_id'],
    universalId : maps?["universal_id"],
    // isOptimised : maps?["is_optimised"],
    isSynced :  maps?["is_synced"]==1?true:false,
    isConfirmed :  maps?["is_confirmed"]==1?true:false,
    originId : maps?["origin_id"],
    version : maps?["version"],
    invoiceItems : invoiceItems,

  );
}

Future<Invoice?> getInvoiceByUni(int id, {bool? copy}) async {
  var maps;
  Client? client;
  List<InvoiceItem> invoiceItems;

  if(copy != null && copy==true){
    maps = await dbHelper.findByIdUni("invoice", id);
    if(maps == null){
      return null;
    }
    client = await getClient(maps?['client_id']);
    invoiceItems = await getInvoiceItems(maps?['id']);
  }else{
    maps = await dbHelper.findByIdUni("invoice", id);

    if(maps == null){
      return null;
    }
    client = await getClient(maps?['client_id']);
    invoiceItems = await getInvoiceItems(maps?['id']);
  }

  var inv =  Invoice(
    id : maps?['id'],
    totalAmount : maps?['total_amount'],
    vatPercent : maps?['vat_percent'],
    vatAmount : maps?['vat_amount'],
    subTotalAmount : maps?['sub_total_amount'],
    published : maps?['published']==1?true:false,
    notes : maps?['notes'],
    currency : maps?['currency'],
    discount : maps?['discount'],
    invoiceDate : maps?['invoice_date'],
    dueDate : maps?['due_date'],
    invoiceNumber : maps?['invoice_number'],
    invoiceStatus : maps?['invoice_status'],
    invoiceType : maps?['invoice_type'],
    clientId : maps?['client_id'],
    client: client,
    payments : maps?['payments'],
    businessId : maps?['business_id'],
    universalId : maps?["universal_id"],
    isSynced : maps?["is_synced"]==1?true:false,
    originId : maps?["origin_id"],
    version : maps?["version"],
    isConfirmed :  maps?["is_confirmed"]==1?true:false,
    invoiceItems : invoiceItems,

  );

  print("Hello there I am invpoice");
  return inv;

}


