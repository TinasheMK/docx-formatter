import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../../screens/generator/databaseHelper.dart';
import '../providers/enums/status_enum.dart';
import 'Employee.dart';

class Currency {
  String?    id;
  String? symbol;
  String? country;



  Currency({
    this.id,
    this.symbol,
    this.country,

  });

 Currency.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   symbol = json['symbol'];
   country = json['country'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['country'] = this.country;
    return data;
  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "symbol": this.symbol,
      "country": this.country
    };
    final id = await dbHelper.insert("currency", row);
    this.id = id.toString();



    debugPrint('inserted currency row id: $id');
  }


  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('currency');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void update() async {
    // row to update
    Map<String, dynamic> row = {
      "symbol": this.symbol,
      "country": this.country,
      "id" : this.id
    };
    final rowsAffected = await dbHelper.update('currency',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('currency');
    final rowsDeleted = await dbHelper.softDelete('currency',int.parse(this.id!));
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }



}

Future<List<Currency>> getCurrencys() async {
  final maps= await dbHelper.queryAllRows("currency");

  return List.generate(maps.length, (i) {
    return Currency(
      id : maps?[i]['id'],
      symbol : maps?[i]['symbol'],
      country : maps?[i]['country']

    );
  });
}

Future<Currency> getCurrency(id) async {
  final maps = await dbHelper.findByIdStr("currency", id);

    return Currency(
      id : maps?['id'],
      symbol : maps?['symbol'],
      country : maps?['country']

    );

}
