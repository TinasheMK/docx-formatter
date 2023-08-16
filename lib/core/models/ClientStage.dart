import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../enums/status_enum.dart';
import 'Currency.dart';
import 'Director.dart';
import 'Employee.dart';
import 'Secretary.dart';
import 'Wallet.dart';

class ClientStage {
  int?    id;
  int?    client_id;
  String? notes;
  String? status;


  String? type;
  int? stageId;

  ClientStage({
    this.id,
    this.client_id,
    this.notes,
    this.status,

    this.type,
    this.stageId
  });

 ClientStage.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   client_id = json['clientId'];
   notes = json['notes'];
   status = json['status'];
   type = json['type'];
   stageId = json['stageId'];
   type = json['type'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.client_id;
    data['notes'] = this.notes;
    data['status'] = this.status;
    return data;
  }

  Future<void> saveAndAttach(int clientId) async {
    debugPrint('adding client stage ');

    Map<String, dynamic> row = {
      "id": id,
      "client_id": clientId,
      "notes": this.notes,
      "status": this.status,
      "type": this.type,
      "stage_id": this.stageId,
      "type": this.stageId,
    };

    if(this.id==null) {
      id = await dbHelper.insert("client_stage", row);
    }else{
      dbHelper.update('client_stage',row);
      id = this.id;
    }

    // final id = await dbHelper.insert("client_stage", row);
    // this.id = id;
    debugPrint('inserted client stage row id: $id');
  }

 query() async {
    final allRows = await dbHelper.queryAllRows('stage');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }


 delete() async {
    // Assuming that the number of rows is the client_id for the last row.
    // final client_id = await dbHelper.queryRowCount('stage');
    final rowsDeleted = await dbHelper.softDelete('stage',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }






}

Future<List<ClientStage>> getClientStages(int clientId) async {
  final maps = await dbHelper.stages("client_stage", clientId);

  return List.generate(maps.length, (i) {
    print(maps?[i]["stage_id"]);
    return ClientStage(
      id : maps[i]['id'],
      client_id : maps[i]['client_id'],
      notes : maps[i]['notes'],
      status : maps[i]['status'],
      type : maps?[i]["type"],
      stageId : maps?[i]["stage_id"],

    );
  });
}
Future<List<ClientStage>> getClientStagesForSync() async {
  final maps = await dbHelper.getReadyForSyc("client_stage");

  return List.generate(maps.length, (i) {
    return ClientStage(
      id : maps[i]['id'],
      client_id : maps[i]['client_id'],
      notes : maps[i]['notes'],
      status : maps[i]['status'],

      type : maps?[i]["type"],
      stageId : maps?[i]["stage_id"],

    );
  });
}

Future<ClientStage?> getClientStage(int id) async {
  var maps = await dbHelper.findById("client_stage", id);

    return ClientStage(
      id : maps?['id'],
      client_id : maps?['client_id'],
      notes : maps?['notes'],
      status : maps?['status'],

    );

}
Future<ClientStage?> getClientStageByUni(int client_id, {bool? copy}) async {
  var maps ;

  if(copy != null && copy==true){
    maps = await dbHelper.findByIdUni("client_stage", client_id);
    if(maps == null){
      return null;
    }
  }else{
    maps = await dbHelper.findByIdUni("client_stage", client_id);

    if(maps == null){
      return null;
    }
  }

    return ClientStage(
      id : maps?['id'],
      client_id : maps?['client_id'],
      notes : maps?['notes'],
      status : maps?['status'],
      stageId : maps?["type"],
    );

}



