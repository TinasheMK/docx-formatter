import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../enums/status_enum.dart';
import 'Currency.dart';
import 'Director.dart';
import 'Employee.dart';
import 'Secretary.dart';
import 'Wallet.dart';

class Objective {
  int?    id;
  String? name;
  String? description;
  String? set;


  String? createdDate;
  String? createdBy;
  String? lastModifiedBy;
  String? lastModifiedBate;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;


  Objective({
    this.id,
    this.name,
    this.description,
    this.set,

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

 Objective.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   name = json['name'];
   description = json['description'];

   createdDate = json['createdDate'];
   createdBy = json['createdBy'];
   version = json['version'];
   lastModifiedBy = json['lastModifiedBy'];
   lastModifiedBate = json['lastModifiedBate'];
   // deletedAt = json['deletedAt'];
  }
 Objective.fromSyncJson(Map<String, dynamic> json) {
   id = json['originId'];
   version = json['version'];
   isConfirmed = json['isConfirmed'];
   universalId = json['id'];


   name = json['name'];
   description = json['description'];

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
    data['description'] = this.description;
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
    data['description'] = this.description;
    return data;
  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "id": this.id,
      "name": this.name,
      "description": this.description,

      "created_date": this.createdDate,
      "created_by": this.createdBy,
      "version": this.version,
      "last_modified_by": this.lastModifiedBy,
      "last_modified_date": this.lastModifiedBate,
      // "deleted_at": this.deletedAt,
    };
    var id;
    if(this.id==null) {
      id = await dbHelper.insert("objective", row);
    }else{
      dbHelper.update('objective',row);
      id = this.id;
    }

    this.id = id;

    for(int i=0; i<30; i++){{
      try {
      }catch(err) {}

    }
    }


    debugPrint('inserted objective row id: $id');
  }
  Future<void> saveSynced() async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    Map<String, dynamic> row = {
      "name": this.name,
      "description": this.description,


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
      id = await dbHelper.insert("objective", row);
    }else{
      dbHelper.update('objective',row);
      id = this.id;
    }


    debugPrint('inserted objective row id: $id');
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
      "description": this.description,

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
      id = await dbHelper.insert("objective", row);
    }else{
      dbHelper.update('objective',row);
      id = this.id;
    }

    debugPrint('inserted objective row id: $id');
  }


  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('objective');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }


  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('objective');
    final rowsDeleted = await dbHelper.softDelete('objective',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }






}

Future<List<Objective>> getObjectives() async {
  final maps = await dbHelper.softQueryAllRows("objective");

  return List.generate(maps.length, (i) {
    return Objective(
      id : maps[i]['id'],
      name : maps[i]['name'],
      description : maps[i]['description'],

      universalId : maps?[i]["universal_id"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });
}
Future<List<Objective>> getObjectivesForSync() async {
  final maps = await dbHelper.getReadyForSyc("objective");

  return List.generate(maps.length, (i) {
    return Objective(
      id : maps[i]['id'],
      name : maps[i]['name'],
      description : maps[i]['description'],

      universalId : maps?[i]["universal_id"],
      isSynced : maps?[i]["is_synced"]==1?true:false,
      originId : maps?[i]["origin_id"],
      version : maps?[i]["version"],
      isConfirmed : maps?[i]["is_confirmed"]==1?true:false,

    );
  });
}

Future<Objective?> getObjective(int id) async {
  var maps = await dbHelper.findById("objective", id);
  List<Director> directors = await getDirectors(maps?['id']);
  List<Secretary> secretaries = await getSecretaries(maps?['id']);

    return Objective(
      id : maps?['id'],
      name : maps?['name'],
      description : maps?['description'],

    );

}
Future<Objective?> getObjectiveByUni(int id, {bool? copy}) async {
  var maps ;

  if(copy != null && copy==true){
    maps = await dbHelper.findByIdUni("objective", id);
    if(maps == null){
      return null;
    }
  }else{
    maps = await dbHelper.findByIdUni("objective", id);

    if(maps == null){
      return null;
    }
  }

    return Objective(
      id : maps?['id'],
      name : maps?['name'],
      description : maps?['description'],

      universalId : maps?["universal_id"],
      isSynced : maps?["is_synced"]==1?true:false,
      originId : maps?["origin_id"],
      version : maps?["version"],
      isConfirmed : maps?["is_confirmed"]==1?true:false,

    );

}



