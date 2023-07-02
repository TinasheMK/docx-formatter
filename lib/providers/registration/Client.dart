import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../../screens/generator/databaseHelper.dart';
import '../../core/providers/enums/status_enum.dart';
import 'Currency.dart';
import 'Employee.dart';
import 'Wallet.dart';

class Client {
  int?    id;
  String? companyName;
  String? street;
  String? city;
  String? country;
  String? telephone;
  String? email;
  String? set;
  String? currency;
  Currency? currencyFull;
  Status? status;
  String? createdDate;
  String? createdBy;
  String? lastModifiedBy;
  String? lastModifiedBate;
  List<Employee>? employees;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;


  Client({
    this.id,
    this.companyName,
    this.street,
    this.city,
    this.set,
    this.currency,
    this.currencyFull,
    this.country,
    this.telephone,
    this.email,
    this.status,
    this.employees,
    this.createdDate,
    this.createdBy,
    this.lastModifiedBy,
    this.lastModifiedBate,

    this.universalId,
    this.isSynced,
    this.originId,
    this.version,
    this.isConfirmed
  });

 Client.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   companyName = json['companyName'];
   street = json['street'];
   city = json['city'];
   country = json['country'];
   telephone = json['telephone'];
   email = json['email'];
   status = json['status'];
   employees = json['employees'];
   currencyFull = json['currencyFull'];
   currency = json['currency'];

   createdDate = json['createdDate'];
   createdBy = json['createdBy'];
   version = json['version'];
   lastModifiedBy = json['lastModifiedBy'];
   lastModifiedBate = json['lastModifiedBate'];
   // deletedAt = json['deletedAt'];
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
    data['currency'] = this.currency;
    data['employees'] = this.employees?.map((item) => item.toJson());
    // data['currencyFull'] = this.currencyFull?.map((item) => item.toJson());
    return data;
  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "company_name": this.companyName,
      "street": this.street,
      "city": this.city,
      "country": this.country,
      "telephone": this.telephone,
      "email": this.email,
      "status": this.status,
      "currency": this.currency,

      "created_date": this.createdDate,
      "created_by": this.createdBy,
      "version": this.version,
      "last_modified_by": this.lastModifiedBy,
      "last_modified_date": this.lastModifiedBate,
      // "deleted_at": this.deletedAt,
    };
    final id = await dbHelper.insert("client", row);
    this.id = id;
    var emps = this.employees;
    for(int i=0; i<30; i++){{
      try {
        emps?[i]?.saveAndAttach(id);
      }catch(err) {}

      }
    }


    debugPrint('inserted client row id: $id');
  }

  Future<void> saveAndAttach(int companyId) async {
    debugPrint('adding   director');

    Map<String, dynamic> row = {
      'city': this.city,
      'country': this.country,
      'street': this.street,
      'email': this.email,
      'currency': this.currency,
      'company_id': companyId
    };
    final id = await dbHelper.insert("director", row);
    this.id = id;
    debugPrint('inserted director row id: $id');
  }


  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('client');
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
      "country": this.country,
      "telephone": this.telephone,
      "email": this.email,
      "currency": this.currency,
      "id" : this.id
    };
    final rowsAffected = await dbHelper.update('client',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('client');
    final rowsDeleted = await dbHelper.softDelete('client',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }


  Future<Wallet> getWallet(String currency) async {

    final maps = await dbHelper.findClientWallet("wallet", this.id!, currency);

    if (maps == null){
      Wallet wallet =  new Wallet(
        currency : currency,
        clientId : this.id,
      );
      wallet.save();
      getWallet(wallet.currency!);
    }

    return Wallet(
      id : maps!['id'],
      balance : maps!['balance'],
      currency : maps?['currency'],
      clientId : maps?['client_id'],

    );

  }


}

Future<List<Client>> getClients() async {
  final maps = await dbHelper.softQueryAllRows("client");

  return List.generate(maps.length, (i) {
    return Client(
      id : maps[i]['id'],
      companyName : maps[i]['company_name'],
      street : maps[i]['street'],
      city : maps[i]['city'],
      country : maps[i]['country'],
      telephone : maps[i]['telephone'],
      email : maps[i]['email'],
      status : maps[i]['status'],
      currency : maps[i]['currency'],
      employees : maps[i]['employees'],

    );
  });
}
Future<List<Client>> searchClients(String query) async {
  final maps = await dbHelper.searchClients(query);

  return List.generate(maps.length, (i) {
    return Client(
      id : maps[i]['id'],
      companyName : maps[i]['company_name'],
      street : maps[i]['street'],
      city : maps[i]['city'],
      country : maps[i]['country'],
      telephone : maps[i]['telephone'],
      email : maps[i]['email'],
      status : maps[i]['status'],
      currency : maps[i]['currency'],
      employees : maps[i]['employees'],

    );
  });
}

Future<Client> getClient(id) async {
  var maps = await dbHelper.findById("client", id);

    return Client(
      id : maps?['id'],
      companyName : maps?['company_name'],
      street : maps?['street'],
      city : maps?['city'],
      country : maps?['country'],
      telephone : maps?['telephone'],
      email : maps?['email'],
      status : maps?['status'],
      currency : maps?['currency'],
      employees : maps?['employees'],

    );

}



