import 'package:flutter/cupertino.dart';
import 'package:smart_admin_dashboard/models/registration/Director.dart';
import 'package:smart_admin_dashboard/models/registration/Secretary.dart';

import '../../main.dart';
import '../../screens/generator/databaseHelper.dart';

class Company {
  String? companyName;
  String? street;
  String? city;
  String? country;
  List<Director>? directors;
  List<Secretary>? secretaries;


  Company(
        this.companyName,
        this.street,
        this.city,
        this.country,
        this.directors,
        this.secretaries,
      );

 Company.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
    directors = json['directors'];
    secretaries = json['secretaries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['companyName'] = this.companyName;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['directors'] = this.directors?.map((item) => item.toJson());
    data['secretaries'] = this.secretaries?.map((item) => item.toJson());
    return data;
  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "name": "this.companyName",
      "street": "this.street",
      "city": "this.city",
      "country": "this.country",
    };
    final id = await dbHelper.insert("company", row);
    debugPrint('inserted company row id: $id');
  }
}

//
// void _query() async {
//   final allRows = await dbHelper.queryAllRows();
//   debugPrint('query all rows:');
//   for (final row in allRows) {
//     debugPrint(row.toString());
//   }
// }
//
// void _update() async {
//   // row to update
//   Map<String, dynamic> row = {
//     DatabaseHelper.columnId: 1,
//     DatabaseHelper.columnName: 'Mary',
//     DatabaseHelper.columnAge: 32
//   };
//   final rowsAffected = await dbHelper.update(row);
//   debugPrint('updated $rowsAffected row(s)');
// }
//
// void _delete() async {
//   // Assuming that the number of rows is the id for the last row.
//   final id = await dbHelper.queryRowCount();
//   final rowsDeleted = await dbHelper.delete(id);
//   debugPrint('deleted $rowsDeleted row(s): row $id');
// }
//
//


