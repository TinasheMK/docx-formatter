import 'package:flutter/cupertino.dart';

import '../../main.dart';

class Director {
  String? name;
  String? lastName;
  int? id;
  String? nationalId;
  String? nationality;
  String? street;
  String? city;
  String? country;
  String? particulars;
  String? incDate;
  String? email;
  int? companyId;
  late bool shareholder;
  int? shares;


  Director({
    this.id,
    this.name,
    this.lastName,
    this.nationalId,
    this.city,
    this.country,
    this.nationality,
    this.street,
    this.particulars,
    this.incDate,
    this.companyId,
    this.email,
    required this.shareholder,
    this.shares
  });

  Director.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['lastName'];
    id = json['id'];
    nationality = json['nationality'];
    nationalId = json['nationalId'];
    street = json['street'];
    city = 'Harare';
    country = "Zimbabwe";
    particulars = json['particulars'];
    incDate = json['incDate'];
    companyId = json['companyId'];
    email = json['email'];
    shareholder = false;
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
    debugPrint('adding   director');

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
      'shares': this.shares,
      'shareholder': this.shareholder==true?1:0,
      'company_id': companyId
    };
    if(this.id==null){
      final id = await dbHelper.insert("director", row);
      this.id = id;
      debugPrint('inserted director row id: $id');
    }else{
      final id = await dbHelper.update("director", row);
      this.id = id;
      debugPrint('updated director row id: $id');
    }

  }

  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('director');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('company');
    final rowsDeleted = await dbHelper.delete('director',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}

//Get invoice items for invoice
Future<List<Director>> getDirectors(int id) async {
  final maps = await dbHelper.findInvoiceItems("director", id);

  return List.generate(maps.length, (i) {
    return Director(
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
      shares : maps?[i]["shares"],
      shareholder : maps?[i]["shareholder"]==1?true:false,
      companyId : maps?[i]["company_id"],

    );
  });

}
