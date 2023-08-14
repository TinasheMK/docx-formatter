
import 'package:flutter/cupertino.dart';

import '../../main.dart';

class Category {
  int?    id;
  String? name;
  String? description;

  int?   universalId;
  int?   originId;
  bool?   isSynced;
  int?   version;
  bool?   isConfirmed;



  Category({
    this.id,
    this.name,
    this.description,

    this.universalId,
    this.isSynced,
    this.originId,
    this.version,
    this.isConfirmed

  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];

  }
  Category.fromSycJson(Map<String, dynamic> json) {
    // id = json['originId'];
    universalId = json['id'];
    name = json['name'];
    description = json['description'];

    version = json['version'];
    isConfirmed = json['isConfirmed'];

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

    data['id'] = this.universalId??null;
    data['originId'] = this.id??0;

    data['name'] = this.name;
    data['nameId'] = null;
    data['description'] = this.description;
    // if(data['originId']==null){
    //   print("No origin id");
    // }
    return data;
  }


  Future<int> save() async {
    debugPrint('adding   category');
    if(this.id==null && this.universalId!=null ) {
      Category existing = await getCategoryByUni(this.universalId!);
      this.id = existing.id;
    }

    Map<String, dynamic> row = {
      'id': this.id,
      'name': this.name,
      'description': this.description,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
    };

    print(row);
    var id;

    if(this.id==null) {
      id = await dbHelper.insert("category", row);
      this.id = id;
      print('the id is $id');
    }else{
      dbHelper.update('category',row);
      id = this.id;
    }


    this.id = id;
    debugPrint('inserted category row id: $id');
    return id;
  }
  Future<int> saveSyncedAndAttach() async {
    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    debugPrint('adding   category');
    if(this.id==null && this.universalId!=null ) {
      Category existing = await getCategoryByUni(this.universalId!);
      this.id = existing.id;
    }

    Map<String, dynamic> row = {
      'id': this.id,
      'name': this.name,
      'description': this.description,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
    };

    print(row);
    var id;

    if(this.id==null) {
      id = await dbHelper.insert("category", row);
      this.id = id;
      print('the id is $id');
    }else{
      dbHelper.update('category',row);
      id = this.id;
    }


    this.id = id;
    debugPrint('inserted category row id: $id');
    return id;
  }
  Future<int> updateSyncedAndAttach() async {

    if(this.universalId==null){
      print("Universal id is required");
      throw Error();
    }
    if(this.id!=null){
      print("id is not required");
      throw Error();
    }
    debugPrint('adding   category');
    if(this.id==null && this.universalId!=null ) {
      Category existing = await getCategoryByUni(this.universalId!);
      this.id = existing.id;
    }

    Map<String, dynamic> row = {
      'id': this.id,
      'name': this.name,
      'description': this.description,

      "universal_id" : this.universalId,
      "is_synced" : (this.isSynced??false)?1:0,
      "origin_id" : this.originId,
      "version" : this.version,
      "is_confirmed" : (this.isConfirmed??false)?1:0,
    };

    print(row);
    var id;

    if(this.id==null) {
      id = await dbHelper.insert("category", row);
      this.id = id;
      print('the id is $id');
    }else{
      dbHelper.update('category',row);
      id = this.id;
    }


    this.id = id;
    debugPrint('inserted category row id: $id');
    return id;
  }

  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('category');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void update() async {
    // row to update
    Map<String, dynamic> row = {
      'name': this.name,
      'description': this.description,
    };
    final rowsAffected = await dbHelper.update('category',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('business');
    final rowsDeleted = await dbHelper.delete('category',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }

}

//Get invoice items for invoice
Future<List<Category>> getCategorys() async {
  final maps = await dbHelper.softQueryAllRows("category");

  return List.generate(maps.length, (i) {
    return Category(
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


Future<Category> getCategory(int id, {bool? copy}) async {
  final maps = await dbHelper.findById("category", id);
  return Category(
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
Future<Category> getCategoryByUni(int id, {bool? copy}) async {
  final maps = await dbHelper.findByIdUni("category", id);
  return Category(
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
