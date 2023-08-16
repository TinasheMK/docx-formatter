import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../enums/status_enum.dart';
import 'ClientStage.dart';
import 'Currency.dart';
import 'Director.dart';
import 'Employee.dart';
import 'Secretary.dart';
import 'Wallet.dart';

class Client {
  int?    id;
  String? name;
  String? street;
  String? city;
  String? country;
  String? telephone;
  String? email;
  String? set;
  String? currency;
  Currency? currencyFull;
  Status? status;
  List<Employee>? employees;
  List<ClientStage>? stages;
  List<ClientStage>? prazStages;
  List<Director>? directors;
  List<Secretary>? secretaries;


  String? createdDate;
  String? createdBy;
  String? lastModifiedBy;
  String? lastModifiedBate;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;


  Client({
    this.id,
    this.name,
    this.street,
    this.city,
    this.stages,
    this.prazStages,
    this.set,
    this.currency,
    this.currencyFull,
    this.country,
    this.telephone,
    this.email,
    this.status,
    this.employees,
    this.directors,
    this.secretaries,

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
   name = json['name'];
   stages = json['stages'];
   prazStages = json['prazStages'];
   street = json['street'];
   city = json['city'];
   country = json['country'];
   telephone = json['telephone'];
   email = json['email'];
   status = json['status'];
   employees = json['employees'];
   directors = json['directors'];
   secretaries = json['secretaries'];
   currencyFull = json['currencyFull'];
   currency = json['currency'];

   createdDate = json['createdDate'];
   createdBy = json['createdBy'];
   version = json['version'];
   lastModifiedBy = json['lastModifiedBy'];
   lastModifiedBate = json['lastModifiedBate'];
   // deletedAt = json['deletedAt'];
  }
 Client.fromSyncJson(Map<String, dynamic> json) {
   id = json['originId'];
   version = json['version'];
   isConfirmed = json['isConfirmed'];
   universalId = json['id'];
   stages = json['stages'];
   prazStages = json['prazStages'];


   name = json['name'];
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
    data['name'] = this.name;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['stages'] = this.stages;
    data['prazStages'] = this.prazStages;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['currency'] = this.currency;
    data['employees'] = this.employees?.map((item) => item.toJson());
    data['directors'] = this.directors?.map((item) => item.toJson());
    data['secretaries'] = this.secretaries?.map((item) => item.toJson());
    // data['currencyFull'] = this.currencyFull?.map((item) => item.toJson());
    return data;
  }
  Map<String, dynamic> toSyncJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = (this.isConfirmed??false)? (this.universalId??null): null;
    data['originId'] = this.id;
    data['isSynced'] = this.isSynced??false;
    data['version'] = (this.isConfirmed??false)?this.version:null;
    data['isConfirmed'] = this.isConfirmed??null;

    data['name'] = this.name;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['stages'] = this.stages;
    data['prazStages'] = this.prazStages;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['currency'] = this.currency;
    data['employees'] = this.employees?.map((item) => item.toJson());
    data['directors'] = this.directors?.map((item) => item.toJson());
    data['secretaries'] = this.secretaries?.map((item) => item.toJson());
    // data['currencyFull'] = this.currencyFull?.map((item) => item.toJson());
    return data;
  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "id": this.id,
      "name": this.name,
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
    var id;
    if(this.id==null) {
      id = await dbHelper.insert("client", row);
    }else{
      dbHelper.update('client',row);
      id = this.id;
    }

    this.id = id;
    var dirs = this.directors;
    var secs = this.secretaries;

    this.stages?.forEach((e) {
      e.saveAndAttach(id);
    });


    for(int i=0; i<30; i++){{
      try {
        dirs?[i]?.saveAndAttach(id);
        secs?[i]?.saveAndAttach(id);
      }catch(err) {}

    }
    }


    debugPrint('inserted client row id: $id');
  }
  Future<void> saveSynced() async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    Map<String, dynamic> row = {
      "name": this.name,
      "street": this.street,
      "city": this.city,
      "country": this.country,
      "stages": this.stages,
      "prazStages": this.prazStages,
      "telephone": this.telephone,
      "email": this.email,
      "status": this.status,
      "currency": this.currency,


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
      id = await dbHelper.insert("client", row);
    }else{
      dbHelper.update('client',row);
      id = this.id;
    }


    debugPrint('inserted client row id: $id');
  }
  Future<void> updateSynced() async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    if(this.id==null){
      print("id is required");
      throw Error();
    }

    Map<String, dynamic> row = {
      "name": this.name,
      "id": this.id,
      "street": this.street,
      "city": this.city,
      "country": this.country,
      "stages": this.stages,
      "prazStages": this.prazStages,
      "telephone": this.telephone,
      "email": this.email,
      "status": this.status,
      "currency": this.currency,
      // "business_id": this.currency,

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
      id = await dbHelper.insert("client", row);
    }else{
      dbHelper.update('client',row);
      id = this.id;
    }

    debugPrint('inserted client row id: $id');
  }


  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('client');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }


  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('client');
    final rowsDeleted = await dbHelper.softDelete('client',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }

}

Future<List<Client>> getClients() async {
  final maps = await dbHelper.softQueryAllRows("client");

  return List.generate(maps.length, (i) {
    return Client(
      id : maps[i]['id'],
      name : maps[i]['name'],
      street : maps[i]['street'],
      city : maps[i]['city'],
      country : maps[i]['country'],
      telephone : maps[i]['telephone'],
      email : maps[i]['email'],
      status : maps[i]['status'],
      currency : maps[i]['currency'],
      employees : maps[i]['employees'],

      universalId : maps?[i]["universal_id"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });
}
Future<List<Client>> getClientsForSync() async {
  final maps = await dbHelper.getReadyForSyc("client");

  return List.generate(maps.length, (i) {
    return Client(
      id : maps[i]['id'],
      name : maps[i]['name'],
      street : maps[i]['street'],
      city : maps[i]['city'],
      country : maps[i]['country'],
      telephone : maps[i]['telephone'],
      email : maps[i]['email'],
      status : maps[i]['status'],
      currency : maps[i]['currency'],
      employees : maps[i]['employees'],

      universalId : maps?[i]["universal_id"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });
}
Future<List<Client>> searchClients(String query) async {
  final maps = await dbHelper.searchClients(query);

  return List.generate(maps.length, (i) {
    return Client(
      id : maps[i]['id'],
      name : maps[i]['name'],
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

Future<Client?> getClient(int id) async {
  var maps = await dbHelper.findById("client", id);
  List<Director> directors = await getDirectors(maps?['id']);
  List<ClientStage> stages = await getClientStages(maps?['id']);
  // List<ClientStage> prazStages = await getClientStages(maps?['id']);
  List<Secretary> secretaries = await getSecretaries(maps?['id']);

    return Client(
      id : maps?['id'],
      name : maps?['name'],
      street : maps?['street'],
      city : maps?['city'],
      country : maps?['country'],
      telephone : maps?['telephone'],
      email : maps?['email'],
      status : maps?['status'],
      currency : maps?['currency'],
      employees : maps?['employees'],
      stages: stages,
      // prazStages: prazStages,
      directors : directors,
      secretaries : secretaries,

    );

}

Future<Client?> getClientByUni(int id, {bool? copy}) async {
  var maps ;

  if(copy != null && copy==true){
    maps = await dbHelper.findByIdUni("client", id);
    if(maps == null){
      return null;
    }
  }else{
    maps = await dbHelper.findByIdUni("client", id);

    if(maps == null){
      return null;
    }
  }

    return Client(
      id : maps?['id'],
      name : maps?['name'],
      street : maps?['street'],
      city : maps?['city'],
      country : maps?['country'],
      telephone : maps?['telephone'],
      email : maps?['email'],
      status : maps?['status'],
      currency : maps?['currency'],
      employees : maps?['employees'],

      universalId : maps?["universal_id"],
      isSynced : maps?["is_synced"]==1?true:false,
      originId : maps?["origin_id"],
      version : maps?["version"],
      isConfirmed : maps?["is_confirmed"]==1?true:false,

    );

}



