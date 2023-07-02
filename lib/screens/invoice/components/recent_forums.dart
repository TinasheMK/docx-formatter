import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/utils/colorful_tag.dart';
import 'package:smart_admin_dashboard/core/types/recent_user_model.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/screens/invoice/new/new_register_home_screen.dart';
import 'package:smart_admin_dashboard/screens/invoice/register_home_screen.dart';

import '../../../core/models/Client.dart';
import '../../../core/models/Invoice.dart';
import '../../../core/utils/responsive.dart';


class RecentDiscussions extends StatefulWidget {
  const RecentDiscussions({
    Key? key,
  }) : super(key: key);

  @override
  _RecentDiscussionsState createState() => _RecentDiscussionsState();
}


class _RecentDiscussionsState extends State<RecentDiscussions> {


  List<Invoice> invoices = [Invoice.fromJson({})];
  List<Client> clients = [Client.fromJson({})];

  String filter = 'ALL';
  String filter2 = 'CLIENTS';
  String dateSort = 'asc';

  Future<void> _initInvoices() async {
    invoices = await getInvoices(dateSort, filter: filter, clientId: filter2);
    clients = await getClients();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initInvoices();
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "Invoice List",
                style: Theme.of(context).textTheme.subtitle1,
              ),

              Container(
                // margin: EdgeInsets.only(left: defaultPadding/4),
                // padding: EdgeInsets.symmetric(
                //   horizontal: defaultPadding/ 4,
                //   vertical: defaultPadding / 100,
                // ),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.blue),
                ),
                child: TextButton(
                  child: Text(filter2, style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                              content: Container(
                                color: secondaryColor,
                                height: 450,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: defaultPadding),
                                        // padding: EdgeInsets.symmetric(
                                        //   horizontal: defaultPadding,
                                        //   vertical: defaultPadding / 2,
                                        // ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("All CLIENTS", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            filter2 = 'CLIENTS';
                                            _initInvoices();
                                            Navigator.of(context).pop();
                                          },
                                          // Delete
                                        ),

                                      ),
                                      SizedBox(height: 7,),


                                      Column(
                                        children:
                                        List.generate(
                                            clients.length,
                                                (index) =>


                                                Container(
                                                  margin: EdgeInsets.only(bottom: 7),
                                                  // padding: EdgeInsets.symmetric(
                                                  //   horizontal: defaultPadding,
                                                  //   vertical: defaultPadding / 2,
                                                  // ),
                                                  decoration: BoxDecoration(
                                                    color: secondaryColor,
                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                    border: Border.all(color: Colors.white10),
                                                  ),
                                                  child: TextButton(
                                                    child: Text(clients[index].companyName!, style: TextStyle(color: Colors.white)),
                                                    onPressed: () {
                                                      filter2 = clients[index]!.id.toString()!;
                                                      _initInvoices();
                                                      setState(() {
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                    // Delete
                                                  ),

                                                )
                                        ),


                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        });
                  },
                  // Delete
                ),

              ),
              Container(
                // margin: EdgeInsets.only(left: defaultPadding/4),
                // padding: EdgeInsets.symmetric(
                //   horizontal: defaultPadding/4,
                //   vertical: defaultPadding / 100,
                // ),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.blue),
                ),
                child: TextButton(
                  child: Text(filter + ' INVOICES', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                              content: Container(
                                color: secondaryColor,
                                height: 450,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [

                                      Container(
                                        // margin: EdgeInsets.only(left: defaultPadding),
                                        // padding: EdgeInsets.symmetric(
                                        //   horizontal: defaultPadding,
                                        //   vertical: defaultPadding / 2,
                                        // ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("All Invoices", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            filter = 'ALL';
                                            _initInvoices();
                                            Navigator.of(context).pop();
                                          },
                                          // Delete
                                        ),

                                      ),
                                      SizedBox(height: 7,),
                                      Container(
                                        // margin: EdgeInsets.only(left: defaultPadding),
                                        // padding: EdgeInsets.symmetric(
                                        //   horizontal: defaultPadding,
                                        //   vertical: defaultPadding / 2,
                                        // ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("UNPAID Invoices", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            filter = 'UNPAID';
                                            _initInvoices();
                                            Navigator.of(context).pop();
                                          },
                                          // Delete
                                        ),

                                      ),
                                      SizedBox(height: 7,),

                                      Container(
                                        // margin: EdgeInsets.only(left: defaultPadding),
                                        // padding: EdgeInsets.symmetric(
                                        //   horizontal: defaultPadding,
                                        //   vertical: defaultPadding / 2,
                                        // ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("Draft Invoices", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            filter = 'DRAFT';
                                            _initInvoices();
                                            Navigator.of(context).pop();
                                          },
                                          // Delete
                                        ),

                                      ),

                                      SizedBox(height: 7,),

                                      Container(
                                        // margin: EdgeInsets.only(left: defaultPadding),
                                        // padding: EdgeInsets.symmetric(
                                        //   horizontal: defaultPadding,
                                        //   vertical: defaultPadding / 2,
                                        // ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("Paid Invoices", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            filter = 'PAID';
                                            _initInvoices();
                                            Navigator.of(context).pop();
                                          },
                                          // Delete
                                        ),

                                      ),

                                      SizedBox(height: 7,),

                                      Container(
                                        // margin: EdgeInsets.only(left: defaultPadding),
                                        // padding: EdgeInsets.symmetric(
                                        //   horizontal: defaultPadding,
                                        //   vertical: defaultPadding / 2,
                                        // ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("Overdue Invoices", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            filter = 'OVERDUE';
                                            _initInvoices();
                                            Navigator.of(context).pop();
                                          },
                                          // Delete
                                        ),

                                      ),

                                      SizedBox(height: 7,),

                                      Container(
                                        // margin: EdgeInsets.only(left: defaultPadding),
                                        // padding: EdgeInsets.symmetric(
                                        //   horizontal: defaultPadding,
                                        //   vertical: defaultPadding / 2,
                                        // ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("Cancelled Invoices", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            filter = 'CANCELLED';
                                            _initInvoices();
                                            Navigator.of(context).pop();
                                          },
                                          // Delete
                                        ),

                                      ),
                                      SizedBox(height: 7,),

                                      Container(
                                        // margin: EdgeInsets.only(left: defaultPadding),
                                        // padding: EdgeInsets.symmetric(
                                        //   horizontal: defaultPadding,
                                        //   vertical: defaultPadding / 2,
                                        // ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.white10),
                                        ),
                                        child: TextButton(
                                          child: Text("Refunded Invoices", style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            filter = 'REFUNDED';
                                            _initInvoices();
                                            Navigator.of(context).pop();
                                          },
                                          // Delete
                                        ),

                                      ),

                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                              icon: Icon(
                                                Icons.close,
                                                size: 14,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              label: Text("Cancel")),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        });
                  },
                  // Delete
                ),

              ),

            ],
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
                  label: GestureDetector(
                    child: Container(
                      // margin: EdgeInsets.only(left: defaultPadding/4),
                        padding: EdgeInsets.all(defaultPadding/3 ),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.blue),
                        ),
                        child:Text("Date")),
                    onTap: (){
                      if(dateSort=='desc') {
                        dateSort = 'asc';
                      }else if (dateSort=='asc') {
                        dateSort = 'desc';
                      }
                      _initInvoices();
                      setState(() { });
                    },
                  )
                ),
                DataColumn(
                  label: Text("Amount"),
                ),
                DataColumn(
                  label: Text("Actions"),
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
        DataCell(Row(
          children: [
            Responsive.isDesktop(context) ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.withOpacity(0.5),
              ),
              icon: Icon(
                Icons.edit,
                size: 14,
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new NewRegisterHome(title: "Edit Invoice: ${userInfo.id}", code: "edit", invoiceId: userInfo.id );
                    },
                    fullscreenDialog: true));
              },
              // Edit
              label: Text("Edit"),
            ) :

            GestureDetector(
              onTap:(){
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new NewRegisterHome(title: "Edit Invoice: ${userInfo.id}", code: "edit", invoiceId: userInfo.id );
                    },
                    fullscreenDialog: true));
              },
              child:Icon(Icons.edit, color:Colors.blue.withOpacity(0.5)),
            ),
            SizedBox(
              width: 6,
            ),
            // SizedBox(
            //   width: 6,
            // ),
            // Responsive.isDesktop(context)
            //     ? ElevatedButton.icon(
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.red.withOpacity(0.5),
            //   ),
            //   icon: Icon(Icons.delete),
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (_) {
            //           return AlertDialog(
            //               title: Center(
            //                 child: Text("Confirm Deletion"),
            //               ),
            //               content: Container(
            //                 color: secondaryColor,
            //                 height: 70,
            //                 child: Column(
            //                   children: [
            //                     Text(
            //                         "Are you sure want to delete invoice: ${userInfo.id}'?"),
            //                     SizedBox(
            //                       height: 16,
            //                     ),
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         ElevatedButton.icon(
            //                             icon: Icon(
            //                               Icons.close,
            //                               size: 14,
            //                             ),
            //                             style: ElevatedButton.styleFrom(
            //                                 primary: Colors.grey),
            //                             onPressed: () {
            //                               Navigator.of(context).pop();
            //                             },
            //                             label: Text("Cancel")),
            //                         SizedBox(
            //                           width: 20,
            //                         ),
            //                         ElevatedButton.icon(
            //                             icon: Icon(
            //                               Icons.delete,
            //                               size: 14,
            //                             ),
            //                             style: ElevatedButton.styleFrom(
            //                                 primary: Colors.red),
            //                             onPressed: () {
            //                               try{
            //                                 userInfo.delete();
            //                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //                                   content: Text("Invoice deleted successfully"),
            //                                 ));
            //                               }catch(e){
            //                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //                                   content: Text("An error occured while deleting"),
            //                                 ));
            //                               }
            //                               Navigator.of(context).pop();
            //                               Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
            //                               );
            //                             },
            //                             label: Text("Delete"))
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //               ));
            //         });
            //   },
            //   // Delete
            //   label: Text("Delete"),
            // )
            //     : GestureDetector(
            //     onTap: (){
            //       showDialog(
            //           context: context,
            //           builder: (_) {
            //             return AlertDialog(
            //                 title: Center(
            //                   child: Text("Confirm Deletion"),
            //                 ),
            //                 content: Container(
            //                   color: secondaryColor,
            //                   height: 70,
            //                   child: Column(
            //                     children: [
            //                       Text(
            //                           "Are you sure want to delete invoice: '${userInfo.id}'?"),
            //                       SizedBox(
            //                         height: 16,
            //                       ),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           ElevatedButton.icon(
            //                               icon: Icon(
            //                                 Icons.close,
            //                                 size: 14,
            //                               ),
            //                               style: ElevatedButton.styleFrom(
            //                                   primary: Colors.grey),
            //                               onPressed: () {
            //                                 Navigator.of(context).pop();
            //                               },
            //                               label: Text("Cancel")),
            //                           SizedBox(
            //                             width: 20,
            //                           ),
            //                           ElevatedButton.icon(
            //                               icon: Icon(
            //                                 Icons.delete,
            //                                 size: 14,
            //                               ),
            //                               style: ElevatedButton.styleFrom(
            //                                   primary: Colors.red),
            //                               onPressed: () {
            //                                 try{
            //                                   userInfo.delete();
            //                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //                                     content: Text("Invoice deleted successfully"),
            //                                   ));
            //                                 }catch(e){
            //                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //                                     content: Text("An error occured while deleting"),
            //                                   ));
            //                                 }
            //                                 Navigator.of(context).pop();
            //                                 Navigator.push(
            //                                   context,
            //                                   MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
            //                                 );
            //                               },
            //                               label: Text("Delete"))
            //                         ],
            //                       )
            //                     ],
            //                   ),
            //                 ));
            //           });
            //     } ,
            //     child: Icon( Icons.delete, color: Colors.red.withOpacity(0.5),)
            // ),
          ],
        ),),
      ],
    );
  }

}

