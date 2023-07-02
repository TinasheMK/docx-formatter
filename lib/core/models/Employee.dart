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
  int?    companyId;


  Employee(
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
    this.companyId,
      );

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
    companyId = json['companyId'];

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
    data['companyId'] = this.companyId;

    return data;
  }

  Future<void> save() async {
    Map<String, dynamic> row = {

      'lastName': this.lastName,
      'firstName': this.firstName,
      'nationalId': this.nationalId,
      'nationality': this.nationality,
      'postcode': this.postcode,
      'street': this.street,
      'city': this.city,
      'country': this.country,
      'telephone': this.telephone,
      'incDate': this.incDate,
      'email': this.email,
      'companyId': this.companyId,


    };
    final id = await dbHelper.insert("employee", row);
    this.id = id;
    debugPrint('inserted employee row id: $id');
  }

  Future<void> saveAndAttach(int companyId) async {
    debugPrint('adding   director');

    Map<String, dynamic> row = {

      'lastName': this.lastName,
      'firstName': this.firstName,
      'nationalId': this.nationalId,
      'nationality': this.nationality,
      'postcode': this.postcode,
      'street': this.street,
      'city': this.city,
      'country': this.country,
      'telephone': this.telephone,
      'incDate': this.incDate,
      'email': this.email,
      'companyId': companyId,

    };
    final id = await dbHelper.insert("employee", row);
    this.id = id;
    debugPrint('inserted employee row id: $id');
  }

  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('employee');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void update() async {
    // row to update
    Map<String, dynamic> row = {

      'lastName': this.lastName,
      'firstName': this.firstName,
      'nationalId': this.nationalId,
      'nationality': this.nationality,
      'postcode': this.postcode,
      'street': this.street,
      'city': this.city,
      'country': this.country,
      'telephone': this.telephone,
      'incDate': this.incDate,
      'email': this.email,
      'companyId': this.companyId,

    };
    final rowsAffected = await dbHelper.update('employee',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('company');
    final rowsDeleted = await dbHelper.delete('employee',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}