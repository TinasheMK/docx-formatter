import 'package:flutter/cupertino.dart';
import 'package:smart_admin_dashboard/providers/registration/Company.dart';

import '../main.dart';

Future<List<Company>> getClients() async {
  final allRows = await dbHelper.queryAllRows('company');
  debugPrint('query all rows:');
  for (final row in allRows) {
    debugPrint(row.toString());
  }
  List<Company> companies =
  allRows.map((item) => Company.fromJson(item)).toList();
  return companies;
}
