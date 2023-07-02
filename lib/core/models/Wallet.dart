import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../../screens/generator/databaseHelper.dart';
import '../providers/enums/status_enum.dart';
import 'Employee.dart';

class Wallet {
  int?    id;
  double? balance;
  String? currency;
  int? clientId;



  Wallet({
    this.id,
    this.balance,
    this.currency,
    this.clientId

  });

 Wallet.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   balance = json['balance'];
   currency = json['currency'];
   clientId = json['clientId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['balance'] = this.balance;
    data['currency'] = this.currency;
    data['clientId'] = this.clientId;

    return data;
  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "balance": this.balance??0,
      "currency": this.currency,
      "client_id": this.clientId,

    };
    final id = await dbHelper.insert("wallet", row);
    this.id = id;


    debugPrint('inserted wallet row id: $id');
  }



  Future<void> query() async {
    final allRows = await dbHelper.queryAllRows('wallet');
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  // void update() async {
  //   Map<String, dynamic> row = {
  //     "balance": this.balance,
  //     "id" : this.id
  //   };
  //   final rowsAffected = await dbHelper.update('wallet',row);
  //   debugPrint('updated $rowsAffected row(s)');
  // }

  void deposit(double amount) async {
    if(this.balance == null) this.balance =0;

    var newBalance = this.balance! + amount;

    Map<String, dynamic> row = {
      "balance": newBalance,
      "id" : this.id
    };
    final rowsAffected = await dbHelper.update('wallet',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    final rowsDeleted = await dbHelper.softDelete('wallet',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }



}

Future<List<Wallet>> getWallets() async {
  final maps = await dbHelper.queryAllRows("wallet");

  return List.generate(maps.length, (i) {
    return Wallet(
      id : maps?[i]['id'],
      balance : maps?[i]['balance'],
      currency : maps?[i]['currency'],
      clientId : maps?[i]['client_id'],

    );
  });
}

Future<Wallet> getWallet(id) async {
  final maps= await dbHelper.findById("wallet", id);

    return Wallet(
      id : maps?['id'],
      balance : maps?['balance'],
      currency : maps?['currency'],
      clientId : maps?['client_id'],

    );

}
