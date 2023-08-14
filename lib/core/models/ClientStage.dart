import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../enums/status_enum.dart';
import 'Currency.dart';
import 'Director.dart';
import 'Employee.dart';
import 'Secretary.dart';
import 'Wallet.dart';

class ClientStage {
  int?    client_id;
  String? notes;
  String? status;


  String? type;
  int? stageId;

  ClientStage({
    this.client_id,
    this.notes,
    this.status,

    this.type,
    this.stageId
  });

 ClientStage.fromJson(Map<String, dynamic> json) {
   client_id = json['client_id'];
   notes = json['notes'];
   status = json['status'];

   type = json['type'];
   type = json['stage_id'];
   stageId = json['type'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.client_id;
    data['notes'] = this.notes;
    data['status'] = this.status;
    return data;
  }

  save() async {
    Map<String, dynamic> row = {
      "client_id": this.client_id,
      "notes": this.notes,
      "status": this.status,

      "type": this.type,
      "type": this.stageId,
      "stage_id": this.type,
    };
    var client_id;
    if(this.client_id==null) {
      client_id = await dbHelper.insert("stage", row);
    }else{
      dbHelper.update('stage',row);
      client_id = this.client_id;
    }

    this.client_id = client_id;

    for(int i=0; i<30; i++){{
      try {
      }catch(err) {}

    }
    }


    debugPrint('inserted stage row client_id: $client_id');
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
    final rowsDeleted = await dbHelper.softDelete('stage',this.client_id!);
    debugPrint('deleted $rowsDeleted row(s): row $client_id');
  }






}

Future<List<ClientStage>> getClientStages() async {
  final maps = await dbHelper.softQueryAllRows("stage");

  return List.generate(maps.length, (i) {
    return ClientStage(
      client_id : maps[i]['client_id'],
      notes : maps[i]['notes'],
      status : maps[i]['status'],
      type : maps?[i]["type"],
      stageId : maps?[i]["stage_id"],

    );
  });
}
Future<List<ClientStage>> getClientStagesForSync() async {
  final maps = await dbHelper.getReadyForSyc("stage");

  return List.generate(maps.length, (i) {
    return ClientStage(
      client_id : maps[i]['client_id'],
      notes : maps[i]['notes'],
      status : maps[i]['status'],

      type : maps?[i]["type"],
      stageId : maps?[i]["stage_id"],

    );
  });
}

Future<ClientStage?> getClientStage(int client_id) async {
  var maps = await dbHelper.findById("stage", client_id);
  List<Director> directors = await getDirectors(maps?['client_id']);
  List<Secretary> secretaries = await getSecretaries(maps?['client_id']);

    return ClientStage(
      client_id : maps?['client_id'],
      notes : maps?['notes'],
      status : maps?['status'],

    );

}
Future<ClientStage?> getClientStageByUni(int client_id, {bool? copy}) async {
  var maps ;

  if(copy != null && copy==true){
    maps = await dbHelper.findByIdUni("stage", client_id);
    if(maps == null){
      return null;
    }
  }else{
    maps = await dbHelper.findByIdUni("stage", client_id);

    if(maps == null){
      return null;
    }
  }

    return ClientStage(
      client_id : maps?['client_id'],
      notes : maps?['notes'],
      status : maps?['status'],
      stageId : maps?["type"],
    );

}



