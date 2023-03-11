import 'package:flutter/cupertino.dart';
import 'package:smart_admin_dashboard/models/registration/Director.dart';
import 'package:smart_admin_dashboard/models/registration/Secretary.dart';

import '../../main.dart';
import '../../screens/generator/databaseHelper.dart';
import 'InvoiceItem.dart';

class Invoice {
  int? id;
  String? companyName;
  String? street;
  String? city;
  String? country;
  List<InvoiceItem>? invoiceitems;
  List<Secretary>? secretaries;


  Invoice(
        this.companyName,
        this.street,
        this.city,
        this.country,
        this.invoiceitems,
        this.secretaries,
        this.id
      );

 Invoice.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
    invoiceitems = json['invoiceitems'];
    secretaries = json['secretaries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['invoiceitems'] = this.invoiceitems?.map((item) => item.toJson());
    data['secretaries'] = this.secretaries?.map((item) => item.toJson());
    return data;
  }


  Future<void> save() async {
    Map<String, dynamic> row = {
      "name": this.companyName,
      "street": this.street,
      "city": this.city,
      "country": this.country,
    };
    final id = await dbHelper.insert("company", row);
    this.id = id;
    var dirs = this.invoiceitems;
    var secs = this.secretaries;

    for(int i=0; i<30; i++){{
      try {
        dirs?[i]?.saveAndAttach(id);
        secs?[i]?.saveAndAttach(id);
      }catch(err) {}

      }
    }


    debugPrint('inserted company row id: $id');
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
      "name": this.companyName,
      "street": this.street,
      "city": this.city,
      "country": this.country,
    };
    final rowsAffected = await dbHelper.update('company',row);
    debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount('company');
    final rowsDeleted = await dbHelper.delete('company',this.id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}


