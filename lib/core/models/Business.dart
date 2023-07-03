import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../db/databaseHelper.dart';
import '../enums/status_enum.dart';
import '../types/compare_res.dart';
import 'Employee.dart';

class Business {
  int?    id;
  String? businessName;
  String? street;
  String? city;
  String? logo;
  int? color;
  String? country;
  String? telephone;
  String? email;
  String? set;
  Status? status;
  List<Employee>? employees;

  String? createdDate;
  String? createdBy;
  String? lastModifiedBy;
  String? lastModifiedBate;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;


  Business({
    this.id,
    this.businessName,
    this.street,
    this.city,
    this.logo,
    this.color,
    this.set,
    this.country,
    this.telephone,
    this.email,
    this.status,
    this.employees,
    this.universalId,
    this.isSynced,
    this.originId,
    this.version,
    this.isConfirmed,

    this.createdDate,
    this.createdBy,
    this.lastModifiedBy,
    this.lastModifiedBate,

  });

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    street = json['street'];
    city = json['city'];
    logo = json['logo'];
    color = json['color'];
    country = json['country'];
    telephone = json['telephone'];
    email = json['email'];
    status = json['status'];
    employees = json['employees'];
  }
  Business.fromSyncJson(Map<String, dynamic> json) {
    id = json['originId'];
    version = json['version'];
    isConfirmed = json['isConfirmed'];
    universalId = json['id'];

    businessName = json['businessName'];
    street = json['street'];
    city = json['city'];
    logo = json['logo'];
    color = json['color'];
    country = json['country'];
    telephone = json['telephone'];
    email = json['email'];
    status = json['status'];
    employees = json['employees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['businessName'] = this.businessName;
    data['street'] = this.street;
    data['city'] = this.city;
    data['logo'] = this.logo;
    data['color'] = this.color;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['employees'] = this.employees?.map((item) => item.toJson());
    return data;
  }
  Map<String, dynamic> toSyncJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = (this.isConfirmed??false)? (this.universalId??null): null;
    data['originId'] = this.id;
    data['isSynced'] = this.isSynced??false;
    data['version'] = (this.isConfirmed??false)?this.version:null;
    data['isConfirmed'] = this.isConfirmed??null;


    data['businessName'] = this.businessName;
    data['street'] = this.street;
    data['city'] = this.city;
    data['logo'] = this.logo;
    data['color'] = this.color;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['employees'] = this.employees?.map((item) => item.toJson());
    return data;
  }


  Future<int> save() async {
    Map<String, dynamic> row = {
      "business_name": this.businessName,
      "street": this.street,
      "id": this.id,
      "city": this.city,
      "logo": this.logo,
      "color": this.color,
      "country": this.country,
      "telephone": this.telephone,
      "email": this.email,
      "status": this.status,


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
      id = await dbHelper.insert("business", row);
    }else{
      dbHelper.update('business',row);
      id = this.id;
    }




    var emps = this.employees;
    for(int i=0; i<30; i++){
      {
        try {
          emps?[i]?.saveAndAttach(id);
        }catch(err) {}

      }
    }


    debugPrint('inserted business row id: $id');
    this.id = id;
    return id;

  }
  Future<int> saveSynced() async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    Map<String, dynamic> row = {
      "business_name": this.businessName,
      "street": this.street,
      "id": this.id,
      "city": this.city,
      "logo": this.logo,
      "color": this.color,
      "country": this.country,
      "telephone": this.telephone,
      "email": this.email,
      "status": this.status,


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
      id = await dbHelper.insert("business", row);
    }else{
      dbHelper.update('business',row);
      id = this.id;
    }




    var emps = this.employees;
    for(int i=0; i<30; i++){
      {
        try {
          emps?[i]?.saveAndAttach(id);
        }catch(err) {}

      }
    }


    debugPrint('inserted business row id: $id');
    this.id = id;
    return id;

  }
  Future<int> updateSynced() async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    if(this.id==null){
      print("id is required");
      throw Error();
    }
    Map<String, dynamic> row = {
      "business_name": this.businessName,
      "street": this.street,
      "id": this.id,
      "city": this.city,
      "logo": this.logo,
      "color": this.color,
      "country": this.country,
      "telephone": this.telephone,
      "email": this.email,
      "status": this.status,


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
      id = await dbHelper.insert("business", row);
    }else{
      dbHelper.update('business',row);
      id = this.id;
    }




    var emps = this.employees;
    for(int i=0; i<30; i++){
      {
        try {
          emps?[i]?.saveAndAttach(id);
        }catch(err) {}

      }
    }


    debugPrint('inserted business row id: $id');
    this.id = id;
    return id;

  }

  Future<void> saveAndAttach(int businessId) async {
    debugPrint('adding   director');

    Map<String, dynamic> row = {
      'city': this.city,
      'logo': this.logo,
      'color': this.color,
      'country': this.country,
      'street': this.street,
      'email': this.email,
      'business_id': businessId
    };
    final id = await dbHelper.insert("director", row);
    this.id = id;
    debugPrint('inserted director row id: $id');
  }


  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('business');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void update() async {
    // row to update
    Map<String, dynamic> row = {
      "business_name": this.businessName,
      "street": this.street,
      "city": this.city,
      "logo": this.logo,
      "color": this.color,
      "country": this.country,
      "telephone": this.telephone,
      "email": this.email,
      "id" : this.id
    };
    final rowsAffected = await dbHelper.update('business',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('business');
    final rowsDeleted = await dbHelper.softDelete('business',this.id!);
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

Future<List<Business>> getBusinesss() async {
  final maps = await dbHelper.softQueryAllRows("business");

  return List.generate(maps.length, (i) {
    return Business(
      id : maps?[i]['id'],
      businessName : maps?[i]['business_name'],
      street : maps?[i]['street'],
      city : maps?[i]['city'],
      logo : maps?[i]['logo'],
      color : maps?[i]['color'],
      country : maps?[i]['country'],
      telephone : maps?[i]['telephone'],
      email : maps?[i]['email'],
      status : maps?[i]['status'],
      employees : maps?[i]['employees'],

      universalId : maps?[i]["universal_id"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });
}
Future<List<Business>> getBusinessesForSync() async {
  final maps = await dbHelper.getReadyForSyc("business");

  return List.generate(maps.length, (i) {
    return Business(
      id : maps?[i]['id'],
      businessName : maps?[i]['business_name'],
      street : maps?[i]['street'],
      city : maps?[i]['city'],
      logo : maps?[i]['logo'],
      color : maps?[i]['color'],
      country : maps?[i]['country'],
      telephone : maps?[i]['telephone'],
      email : maps?[i]['email'],
      status : maps?[i]['status'],
      employees : maps?[i]['employees'],

      universalId : maps?[i]["universal_id"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });
}

Future<Business?> getBusiness(int id) async {
  final maps = await dbHelper.findById("business", id);

  return Business(
    id : maps?['id'],
    businessName : maps?['business_name'],
    street : maps?['street'],
    city : maps?['city'],
    logo : maps?['logo'],
    color : maps?['color'],
    country : maps?['country'],
    telephone : maps?['telephone'],
    email : maps?['email'],
    status : maps?['status'],
    employees : maps?['employees'],

  );

}
Future<Business?> getBusinessByUni(int id, {bool? copy}) async {
  final maps ;

  if(copy != null && copy==true){
    maps = await dbHelper.findByIdUni("client", id);
    if(maps == null){
      return null;
    }
  }else{
    maps = await dbHelper.findByIdUni("client", id);

    if(maps == null){
      return null;
    }
  }

  return Business(
    id : maps?['id'],
    businessName : maps?['business_name'],
    street : maps?['street'],
    city : maps?['city'],
    logo : maps?['logo'],
    color : maps?['color'],
    country : maps?['country'],
    telephone : maps?['telephone'],
    email : maps?['email'],
    status : maps?['status'],
    employees : maps?['employees'],

    universalId : maps?["universal_id"],
    isSynced : maps?["is_synced"]==1?true:false,
    originId : maps?["origin_id"],
    version : maps?["version"],
    isConfirmed : maps?["is_confirmed"]==1?true:false,

  );

}
