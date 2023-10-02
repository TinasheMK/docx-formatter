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


  Secretary(
      {this.name,
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
      this.email});

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


  Future<void> saveAndAttach(int companyId) async {
    debugPrint('adding secretary ');

    Map<String, dynamic> row = {
      'id': this.id,
      'name': this.name,
      'last_name': "",
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

    if(this.id==null){
      final id = await dbHelper.insert("secretary", row);
      this.id = id;
      debugPrint('inserted secretary row id: $id');
    }else{
      final id = await dbHelper.update("secretary", row);
      this.id = id;
      debugPrint('updated secretary row id: $id');
    }

  }

  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('secretary');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('company');
    final rowsDeleted = await dbHelper.delete('secretary',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}

Future<List<Secretary>> getSecretaries(int id) async {
  final maps = await dbHelper.findInvoiceItems("secretary", id);

  return List.generate(maps.length, (i) {
    return Secretary(
      id : maps[i]['id'],
      name : maps[i]['name'],
      lastName : maps[i]['last_name'],
      city : maps[i]['city'],
      country : maps[i]['country'],
      nationality : maps[i]['nationality'],
      nationalId : maps[i]['national_id'],
      street : maps[i]['street'],
      particulars : maps[i]['particulars'],
      incDate : maps[i]['incDate'],
      email : maps?[i]["email"],
      companyId : maps?[i]["company_id"],

    );
  });

}