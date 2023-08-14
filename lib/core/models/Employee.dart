import 'package:flutter/cupertino.dart';

import '../../main.dart';

class Employee {
  int?    id;
  String? lastName;
  String? firstName;
  String? nationalId;
  String? nationality;
  String? postcode;
  String? street;
  String? city;
  String? country;
  String? telephone;
  String? incDate;
  String? email;
  int?    businessId;


  String? createdDate;
  String? createdBy;
  String? lastModifiedBy;
  String? lastModifiedBate;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;



  Employee({
    this.id,
    this.lastName,
    this.firstName,
    this.nationalId,
    this.nationality,
    this.postcode,
    this.street,
    this.city,
    this.country,
    this.telephone,
    this.incDate,
    this.email,
    this.businessId,

      this.universalId,
      this.isSynced,
      this.originId,
      this.version,
      this.isConfirmed,

      this.createdDate,
      this.createdBy,
      this.lastModifiedBy,
      this.lastModifiedBate,
}      );

  Employee.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    nationalId = json['nationalId'];
    nationality = json['nationality'];
    postcode = json['postcode'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
    telephone = json['telephone'];
    incDate = json['incDate'];
    email = json['email'];
    businessId = json['businessId'];

  }
  Employee.fromSyncJson(Map<String, dynamic> json) {
    id = json['originId'];
    version = json['version'];
    isConfirmed = json['isConfirmed'];
    universalId = json['id'];


    lastName = json['lastName'];
    firstName = json['firstName'];
    nationalId = json['nationalId'];
    nationality = json['nationality'];
    postcode = json['postcode'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
    telephone = json['telephone'];
    incDate = json['incDate'];
    email = json['email'];
    businessId = json['businessId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['nationalId'] = this.nationalId;
    data['nationality'] = this.nationality;
    data['postcode'] = this.postcode;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    data['incDate'] = this.incDate;
    data['email'] = this.email;
    data['businessId'] = this.businessId;

    return data;
  }
  Map<String, dynamic> toSyncJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = (this.isConfirmed??false)? (this.universalId??null): null;
    data['originId'] = this.id;

    data['isSynced'] = this.isSynced??false;
    data['version'] = (this.isConfirmed??false)?this.version:null;
    data['isConfirmed'] = this.isConfirmed??null;


    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['nationalId'] = this.nationalId;
    data['nationality'] = this.nationality;
    data['postcode'] = this.postcode;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    data['incDate'] = this.incDate;
    data['email'] = this.email;
    data['businessId'] = this.businessId;

    if(data['originId']==null){
      print("No origin id");
      throw Error();
    }

    return data;
  }

  Future<void> save() async {
    Map<String, dynamic> row = {

      'last_name': this.lastName,
      'first_name': this.firstName,
      'national_id': this.nationalId,
      'nationality': this.nationality,
      'postcode': this.postcode,
      'street': this.street,
      'city': this.city,
      'country': this.country,
      'telephone': this.telephone,
      'email': this.email,
      'business_id': this.businessId,


    };
    final id = await dbHelper.insert("employee", row);
    this.id = id;
    debugPrint('inserted employee row id: $id');
  }

  Future<void> saveAndAttach(int businessId) async {
    debugPrint('adding   director');

    Map<String, dynamic> row = {

      'last_name': this.lastName,
      'first_name': this.firstName,
      'national_id': this.nationalId,
      'nationality': this.nationality,
      'postcode': this.postcode,
      'street': this.street,
      'city': this.city,
      'country': this.country,
      'telephone': this.telephone,
      'email': this.email,
      'businessId': businessId,

    };
    final id = await dbHelper.insert("employee", row);
    this.id = id;
    debugPrint('inserted employee row id: $id');
  }
  Future<void> saveSyncedAndAttact(int businessId) async {
    debugPrint('adding   director');
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    Map<String, dynamic> row = {

      'last_name': this.lastName,
      'first_name': this.firstName,
      'national_id': this.nationalId,
      'nationality': this.nationality,
      'postcode': this.postcode,
      'street': this.street,
      'city': this.city,
      'country': this.country,
      'telephone': this.telephone,
      'email': this.email,
      'business_id': businessId,

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
      id = await dbHelper.insert("employee", row);
    }else{
      dbHelper.update('employee',row);
      id = this.id;
    }    this.id = id;
    debugPrint('inserted employee row id: $id');
  }
  Future<void> updateSyncedAndAttach(int businessId) async {
    debugPrint('adding   employee');
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    if(this.id!=null){
      print("id is not required");
      throw Error();
    }
    if(this.id==null && this.universalId!=null ) {
      Employee existing = await getEmployeeByUni(this.universalId!);
      this.id = existing.id;
    }
    Map<String, dynamic> row = {

      'last_name': this.lastName,
      'first_name': this.firstName,
      'national_id': this.nationalId,
      'nationality': this.nationality,
      'postcode': this.postcode,
      'street': this.street,
      'city': this.city,
      'country': this.country,
      'telephone': this.telephone,
      'email': this.email,
      'business_id': businessId,

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
      id = await dbHelper.insert("employee", row);
    }else{
      dbHelper.update('employee',row);
      id = this.id;
    }    this.id = id;
    debugPrint('inserted employee row id: $id');
  }

  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('employee');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }



  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('business');
    final rowsDeleted = await dbHelper.delete('employee',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}


//Get employee items for employee
Future<List<Employee>> getEmployees(int id) async {
  final maps = await dbHelper.queryAllRows('employee');

  return List.generate(maps.length, (i) {
    return Employee(
      id :  maps?[i]['id'],
      lastName :  maps?[i]['last_name'],
      firstName :  maps?[i]['first_name'],
      nationalId :  maps?[i]['national_id'],
      nationality :  maps?[i]['nationality'],
      postcode :  maps?[i]['postcode'],
      street :  maps?[i]['street'],
      city :  maps?[i]['city'],
      country :  maps?[i]['country'],
      telephone :  maps?[i]['telephone'],
      email :  maps?[i]['email'],
      businessId :  maps?[i]['business_id'],

      universalId : maps?[i]["universal_id"],
      // isOptimised : maps?[i]["is_optimised"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });

}


Future<Employee> getEmployeeByUni(int id, {bool? copy}) async {
  final maps = await dbHelper.findByIdUni("employee", id);
  return Employee(
    id :  maps?['id'],
    lastName :  maps?['last_name'],
    firstName :  maps?['first_name'],
    nationalId :  maps?['national_id'],
    nationality :  maps?['nationality'],
    postcode :  maps?['postcode'],
    street :  maps?['street'],
    city :  maps?['city'],
    country :  maps?['country'],
    telephone :  maps?['telephone'],
    email :  maps?['email'],
    businessId :  maps?['business_id'],
    universalId : maps?["universal_id"],
    isSynced : maps?["is_synced"]==1?true:false,
    originId : maps?["origin_id"],
    version : maps?["version"],
    isConfirmed : maps?["is_confirmed"]==1?true:false,

  );

}