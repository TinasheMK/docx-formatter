import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../../screens/generator/databaseHelper.dart';
import '../providers/enums/status_enum.dart';
import 'Employee.dart';

class Company {
  int?    id;
  String? companyName;
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

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;


  Company({
    this.id,
    this.companyName,
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
    this.isConfirmed
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
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
    data['companyName'] = this.companyName;
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
      "company_name": this.companyName,
      "street": this.street,
      "id": this.id,
      "city": this.city,
      "logo": this.logo,
      "color": this.color,
      "country": this.country,
      "telephone": this.telephone,
      "email": this.email,
      "status": this.status,
    };

    var id;
    if(this.id==null) {
      id = await dbHelper.insert("company", row);
    }else{
      dbHelper.update('company',row);
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


    debugPrint('inserted company row id: $id');
    this.id = id;
    return id;

  }

  Future<void> saveAndAttach(int companyId) async {
    debugPrint('adding   director');

    Map<String, dynamic> row = {
      'city': this.city,
      'logo': this.logo,
      'color': this.color,
      'country': this.country,
      'street': this.street,
      'email': this.email,
      'company_id': companyId
    };
    final id = await dbHelper.insert("director", row);
    this.id = id;
    debugPrint('inserted director row id: $id');
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
      "company_name": this.companyName,
      "street": this.street,
      "city": this.city,
      "logo": this.logo,
      "color": this.color,
      "country": this.country,
      "telephone": this.telephone,
      "email": this.email,
      "id" : this.id
    };
    final rowsAffected = await dbHelper.update('company',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('company');
    final rowsDeleted = await dbHelper.softDelete('company',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }



}

Future<List<Company>> getCompanys() async {
  final maps = await dbHelper.softQueryAllRows("company");

  return List.generate(maps.length, (i) {
    return Company(
      id : maps?[i]['id'],
      companyName : maps?[i]['company_name'],
      street : maps?[i]['street'],
      city : maps?[i]['city'],
      logo : maps?[i]['logo'],
      color : maps?[i]['color'],
      country : maps?[i]['country'],
      telephone : maps?[i]['telephone'],
      email : maps?[i]['email'],
      status : maps?[i]['status'],
      employees : maps?[i]['employees'],

    );
  });
}

Future<Company> getCompany(id) async {
  final maps = await dbHelper.findById("company", id);

  return Company(
    id : maps?['id'],
    companyName : maps?['company_name'],
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
