import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../db/databaseHelper.dart';
import '../enums/status_enum.dart';
import '../types/compare_res.dart';
import 'Category.dart';
import 'Currency.dart';
import 'Employee.dart';
import 'Wallet.dart';

class Product {
  int?    id;
  String? name;
  double? price;
  String? sku;
  int? stock;
  int? categoryId;
  int? businessId;
  Category? category;


  String? createdDate;
  String? createdBy;
  String? lastModifiedBy;
  String? lastModifiedBate;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;


  Product({
    this.id,
    this.name,
    this.price,
    this.sku,
    this.category,

    this.stock,
    this.categoryId,
    this.businessId,

    this.createdDate,
    this.createdBy,
    this.lastModifiedBy,
    this.lastModifiedBate,

    this.universalId,
    this.isSynced,
    this.originId,
    this.version,
    this.isConfirmed
  });

 Product.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   name = json['name'];
   price = json['price'];
   sku = json['sku'];
   stock = json['stock'];
   categoryId = json['categoryId'];
   businessId = json['businessId'];

   createdDate = json['createdDate'];
   createdBy = json['createdBy'];
   version = json['version'];
   lastModifiedBy = json['lastModifiedBy'];
   lastModifiedBate = json['lastModifiedBate'];
   // deletedAt = json['deletedAt'];
  }
 Product.fromSyncJson(Map<String, dynamic> json) {
   id = json['originId'];
   version = json['version'];
   isConfirmed = json['isConfirmed'];
   universalId = json['id'];


   name = json['name'];
   price = json['price'];
   sku = json['sku'];
   stock = json['stock'];
   categoryId = json['categoryId'];
   businessId = json['businessId'];

   createdDate = json['createdDate'];
   createdBy = json['createdBy'];
   version = json['version'];
   lastModifiedBy = json['lastModifiedBy'];
   lastModifiedBate = json['lastModifiedBate'];
   // deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['sku'] = this.sku;
    data['stock'] = this.stock;
    data['categoryId'] = this.categoryId;
    data['businessId'] = this.businessId;
    // data['currencyFull'] = this.currencyFull?.map((item) => item.toJson());
    return data;
  }
  Map<String, dynamic> toSyncJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = (this.isConfirmed??false)? (this.universalId??null): null;
    data['originId'] = this.id;
    data['isSynced'] = this.isSynced??false;
    data['version'] = (this.isConfirmed??false)?this.version:null;
    data['isConfirmed'] = this.isConfirmed??null;

    data['name'] = this.name;
    data['price'] = this.price;
    data['sku'] = this.sku;
    data['stock'] = this.stock;
    data['categoryId'] = this.categoryId;
    data['businessId'] = this.businessId;
    return data;
  }


  Future<int> save() async {
    Map<String, dynamic> row = {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "sku": this.sku,
      "stock": this.stock,
      "category_id": this.categoryId,
      "business_id": this.businessId,

      "created_date": this.createdDate,
      "created_by": this.createdBy,
      "version": this.version,
      "last_modified_by": this.lastModifiedBy,
      "last_modified_date": this.lastModifiedBate,
      // "deleted_at": this.deletedAt,
    };
    var id;
    if(this.id==null) {
      id = await dbHelper.insert("product", row);
    }else{
      dbHelper.update('product',row);
      id = this.id;
    }


    debugPrint('inserted product row id: $id');
    return id;
  }
  Future<void> saveSynced() async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    Map<String, dynamic> row = {
      "name": this.name,
      "price": this.price,
      "sku": this.sku,
      "stock": this.stock,
      "category_id": this.categoryId,
      "business_id": this.businessId,


      "created_date": this.createdDate,
      "created_by": this.createdBy,
      "version": this.version,
      "last_modified_by": this.lastModifiedBy,
      "last_modified_date": this.lastModifiedBate,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
    };


    var id;
    if(this.id==null) {
      id = await dbHelper.insert("product", row);
    }else{
      dbHelper.update('product',row);
      id = this.id;
    }


    debugPrint('inserted product row id: $id');
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
      "name": this.name,
      "id": this.id,
      "price": this.price,
      "sku": this.sku,
      "stock": this.stock,
      "category_id": this.categoryId,
      "business_id": this.businessId,

      "created_date": this.createdDate,
      "created_by": this.createdBy,
      "version": this.version,
      "last_modified_by": this.lastModifiedBy,
      "last_modified_date": this.lastModifiedBate,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
    };

    var id;
    if(this.id==null) {
      id = await dbHelper.insert("product", row);
    }else{
      dbHelper.update('product',row);
      id = this.id;
    }

    debugPrint('inserted product row id: $id');
  }


  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('product');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }


  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('product');
    final rowsDeleted = await dbHelper.softDelete('product',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }



  Future<List<CompareRes>> compare() async {
    // Invoice? newInv = await getInvoiceByUni(this.universalId);
    // Invoice? oldInv = await getInvoiceByUni(this.universalId, copy: true);

    List<CompareRes> comps = [] ;
    CompareRes comp = new CompareRes();

    // if(newInv.invoiceStatus != oldInv.invoiceStatus && this.invoiceStatus != oldInv.invoiceStatus && newInv.invoiceStatus != this.invoiceStatus){
    //   comp.localValue = newInv.invoiceStatus;
    //   comp.oldValue = this.invoiceStatus;
    //   comp.field = "invoiceStatus";
    //   comps.add(comp);
    //  }
    //todo: Merge non conflicting fields


    return comps;

  }


}

Future<List<Product>> getProducts() async {
  final maps = await dbHelper.softQueryAllRows("product");

  return List.generate(maps.length, (i) {
    return Product(
      id : maps[i]['id'],
      name : maps[i]['name'],
      price : maps[i]['price'],
      sku : maps[i]['sku'],
      stock : maps[i]['stock'],
      categoryId : maps[i]['category_id'],
      businessId : maps[i]['business_id'],

      universalId : maps?[i]["universal_id"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });
}
Future<List<Product>> getProductsForSync() async {
  final maps = await dbHelper.getReadyForSyc("product");

  return List.generate(maps.length, (i) {
    return Product(
      id : maps[i]['id'],
      name : maps[i]['name'],
      price : maps[i]['price'],
      sku : maps[i]['sku'],
      stock : maps[i]['stock'],
      categoryId : maps[i]['category_id'],
      businessId : maps[i]['business_id'],

      universalId : maps?[i]["universal_id"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });
}
Future<List<Product>> searchProducts(String query) async {
  final maps = await dbHelper.searchProducts(query);

  return List.generate(maps.length, (i) {
    return Product(
      id : maps[i]['id'],
      name : maps[i]['name'],
      price : maps[i]['price'],
      sku : maps[i]['sku'],
      stock : maps[i]['stock'],
      categoryId : maps[i]['category_id'],
      businessId : maps[i]['business_id'],
    );
  });
}

Future<Product?> getProduct(int id) async {
  var maps = await dbHelper.findById("product", id);

    return Product(
      id : maps?['id'],
      name : maps?['name'],
      price : maps?['price'],
      sku : maps?['sku'],
      stock : maps?['stock'],
      categoryId : maps?['categoryId'],
      businessId : maps?['businessId'],

    );

}
Future<Product?> getProductByUni(int id, {bool? copy}) async {
  var maps ;

  if(copy != null && copy==true){
    maps = await dbHelper.findByIdUni("product", id);
    if(maps == null){
      return null;
    }
  }else{
    maps = await dbHelper.findByIdUni("product", id);

    if(maps == null){
      return null;
    }
  }

    return Product(
      id : maps?['id'],
      name : maps?['name'],
      price : maps?['price'],
      sku : maps?['sku'],
      stock : maps?['stock'],
      categoryId : maps?['categoryId'],
      businessId : maps?['businessId'],

      universalId : maps?["universal_id"],
      isSynced : maps?["is_synced"]==1?true:false,
      originId : maps?["origin_id"],
      version : maps?["version"],
      isConfirmed : maps?["is_confirmed"]==1?true:false,

    );

}



