import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/utils/colorful_tag.dart';
import 'package:smart_admin_dashboard/providers/recent_user_model.dart';
import 'package:flutter/material.dart';

import '../../../providers/registration/Invoice.dart';


class RecentDiscussions extends StatefulWidget {
  const RecentDiscussions({
    Key? key,
  }) : super(key: key);

  @override
  _RecentDiscussionsState createState() => _RecentDiscussionsState();
}


class _RecentDiscussionsState extends State<RecentDiscussions> {


  List<Invoice> invoices = [Invoice.fromJson({})];

  Future<void> _initclients() async {
    invoices = await getInvoices('desc');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initclients();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invoice List",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text("Id"),
                ),DataColumn(
                  label: Text("Client"),
                ),
                DataColumn(
                  label: Text("Invoice Date"),
                ),
                DataColumn(
                  label: Text("Amount"),
                ),
              ],
              rows: List.generate(
                invoices.length,
                (index) => recentUserDataRow(invoices[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentUserDataRow(Invoice userInfo) {
  return DataRow(
    cells: [
      DataCell(Text(userInfo.id.toString()!)),
      DataCell(Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: getRoleColor(userInfo.client.toString()).withOpacity(.2),
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.all(Radius.circular(5.0) //
                ),
          ),
          child: Text(userInfo.client != null ? userInfo.client!.companyName! : ""))),
      DataCell(Text(userInfo.invoiceDate.toString().split(" ")[0])),
      DataCell(Text(userInfo.totalAmount.toString())),
    ],
  );
}
