import 'package:flutter/cupertino.dart';

import '../../main.dart';

class Secretary {
  String? name;
  String? lastName;
  int? id;
  String? nationality;
  String? nationalId;
  String? street;
  String? city;
  String? country;
  String? particulars;
  String? incDate;
  String? email;
  int? companyId;


  Secretary(this.name,
      this.lastName,
      this.id,
      this.nationalId,
      this.city,
      this.country,
      this.nationality,
      this.street,
      this.particulars,
      this.incDate,
      this.companyId,
      this.email
      );

  Secretary.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['lastName'];
    id = json['id'];
    nationality = json['nationality'];
    nationalId = json['nationalId'];
    street = json['street'];
    city = "Harare";
    country = "Zimbabwe";
    particulars = json['particulars'];
    incDate = json['incDate'];
    companyId = json['companyId'];
    email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['id'] = this.id;
    data['city'] = this.city;
    data['country'] = this.country;
    data['nationality'] = this.nationality;
    data['nationalId'] = this.nationalId;
    data['street'] = this.street;
    data['particulars'] = this.particulars;
    data['incDate'] = this.incDate;
    data['companyId'] = this.companyId;
    data['email'] = this.email;

    return data;
  }

  Future<void> save() async {
    Map<String, dynamic> row = {
      'name': this.name,
      'last_name': this.lastName,
      'city': this.city,
      'country': this.country,
      'nationality': this.nationality,
      'national_id': this.nationalId,
      'street': this.street,
      'particulars': this.particulars,
      'incDate': this.incDate,
      'company_id': this.companyId,
      'email': this.email,

    };
    final id = await dbHelper.insert("secretary", row);
    this.id = id;
    debugPrint('inserted secretary row id: $id');
  }

  Future<void> saveAndAttach(int companyId) async {
    debugPrint('adding secretary ');

    Map<String, dynamic> row = {
      'name': this.name,
      'last_name': this.lastName,
      'city': this.city,
      'country': this.country,
      'nationality': this.nationality,
      'national_id': this.nationalId,
      'street': this.street,
      'particulars': this.particulars,
      'incDate': this.incDate,
      'email': this.email,
      'company_id': companyId
    };
    final id = await dbHelper.insert("secretary", row);
    this.id = id;
    debugPrint('inserted secretary row id: $id');
  }

  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('secretary');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void update() async {
    // row to update
    Map<String, dynamic> row = {
      'name': this.name,
      'lastName': this.lastName,
      'id': this.id,
      'city': this.city,
      'country': this.country,
      'nationality': this.nationality,
      'nationalId': this.nationalId,
      'street': this.street,
      'particulars': this.particulars,
      'incDate': this.incDate,
      'email': this.email
    };
    final rowsAffected = await dbHelper.update('secretary',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('company');
    final rowsDeleted = await dbHelper.delete('secretary',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}