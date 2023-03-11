import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../../screens/generator/databaseHelper.dart';
import '../enums/status_enum.dart';
import 'Employee.dart';

class Company {
  int?    id;
  String? companyName;
  String? street;
  String? city;
  String? country;
  String? telephone;
  String? email;
  Status? status;
  List<Employee>? employees;


  Company(
      this.id,
      this.companyName,
      this.street,
      this.city,
      this.country,
      this.telephone,
      this.email,
      this.status,
      this.employees,
      );

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
    telephone = json['telephone'];
    email = json['email'];
    status = json['status'];
    employees = json['employees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['employees'] = this.employees?.map((item) => item.toJson());
    return data;
  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "companyName": this.companyName,
      "street": this.street,
      "city": this.city,
      "country": this.country,
      "telephone": this.telephone,
      "email": this.email,
      "status": this.status,
    };
    final id = await dbHelper.insert("company", row);
    this.id = id;
    var emps = this.employees;
    for(int i=0; i<30; i++){{
      try {
        emps?[i]?.saveAndAttach(id);
      }catch(err) {}

    }
    }


    debugPrint('inserted company row id: $id');
  }


  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('company');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void update() async {
    // row to update
    Map<String, dynamic> row = {
      "name": this.companyName,
      "street": this.street,
      "city": this.city,
      "country": this.country,
    };
    final rowsAffected = await dbHelper.update('company',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('company');
    final rowsDeleted = await dbHelper.delete('company',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}


