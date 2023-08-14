import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../enums/status_enum.dart';
import 'Currency.dart';
import 'Director.dart';
import 'Employee.dart';
import 'Secretary.dart';
import 'Wallet.dart';

class Stage {
  int?    id;
  String? name;
  String? description;


  String? type;

  Stage({
    this.id,
    this.name,
    this.description,

    this.type
  });

 Stage.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   name = json['name'];
   description = json['description'];

   type = json['type'];
  }
 Stage.fromSyncJson(Map<String, dynamic> json) {
   id = json['originId'];


   name = json['name'];
   description = json['description'];

   type = json['type'];
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
    data['originId'] = this.id;

    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "id": this.id,
      "name": this.name,
      "description": this.description,

      "type": this.type,
    };
    var id;
    if(this.id==null) {
      id = await dbHelper.insert("stage", row);
    }else{
      dbHelper.update('stage',row);
      id = this.id;
    }

    this.id = id;

    for(int i=0; i<30; i++){{
      try {
      }catch(err) {}

    }
    }


    debugPrint('inserted stage row id: $id');
  }
  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('stage');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }


  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('stage');
    final rowsDeleted = await dbHelper.softDelete('stage',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }






}

Future<List<Stage>> getStages() async {
  final maps = await dbHelper.softQueryAllRows("stage");

  return List.generate(maps.length, (i) {
    return Stage(
      id : maps[i]['id'],
      name : maps[i]['name'],
      description : maps[i]['description'],
      type : maps?[i]["type"],

    );
  });
}
Future<List<Stage>> getStagesForSync() async {
  final maps = await dbHelper.getReadyForSyc("stage");

  return List.generate(maps.length, (i) {
    return Stage(
      id : maps[i]['id'],
      name : maps[i]['name'],
      description : maps[i]['description'],

      type : maps?[i]["type"],

    );
  });
}

Future<Stage?> getStage(int id) async {
  var maps = await dbHelper.findById("stage", id);
  List<Director> directors = await getDirectors(maps?['id']);
  List<Secretary> secretaries = await getSecretaries(maps?['id']);

    return Stage(
      id : maps?['id'],
      name : maps?['name'],
      description : maps?['description'],

    );

}
Future<Stage?> getStageByUni(int id, {bool? copy}) async {
  var maps ;

  if(copy != null && copy==true){
    maps = await dbHelper.findByIdUni("stage", id);
    if(maps == null){
      return null;
    }
  }else{
    maps = await dbHelper.findByIdUni("stage", id);

    if(maps == null){
      return null;
    }
  }

    return Stage(
      id : maps?['id'],
      name : maps?['name'],
      description : maps?['description'],

      type : maps?["type"],

    );

}



