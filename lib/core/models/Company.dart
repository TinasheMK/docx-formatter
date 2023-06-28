import 'package:flutter/cupertino.dart';

import '../../main.dart';
import 'Director.dart';
import 'Secretary.dart';



class Company {
  int? id;
  String? companyName;
  String? street;
  String? city;
  String? country;
  List<Director>? directors;
  List<Secretary>? secretaries;


  Company({
    this.companyName,
    this.street,
    this.city,
    this.country,
    this.directors,
    this.secretaries,
    this.id
  });

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

    data['id'] = this.id;
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
      "company_name": this.companyName,
      "street": this.street,
      "city": this.city,
      "country": this.country,
    };
    final id = await dbHelper.insert("company", row);
    this.id = id;
    var dirs = this.directors;
    var secs = this.secretaries;

    for(int i=0; i<30; i++){{
      try {
        dirs?[i]?.saveAndAttach(id);
        secs?[i]?.saveAndAttach(id);
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


Future<List<Company>> getCompanies() async {
  final maps = await dbHelper.queryAllRows("company");

  return List.generate(maps.length, (i) {
    print(maps[i].toString());
    print('Extracting data');
    return Company(
        id : maps[i]['id'],
        companyName : maps[i]['company_name'],
        street : maps[i]['street'],
        city : maps[i]['city'],
        country : maps[i]['country'],

    );
  });
}



