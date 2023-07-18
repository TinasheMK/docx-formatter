import 'package:flutter_svg/svg.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/utils/colorful_tag.dart';
import 'package:flutter/material.dart';
import '../../../core/models/Client.dart';
import '../../../core/models/Invoice.dart';
import '../../../core/utils/responsive.dart';
import '../edit/invoice_home_screen.dart';


class InvoicesList extends StatefulWidget {
  const InvoicesList({
    Key? key,
  }) : super(key: key);

  @override
  _InvoicesListState createState() => _InvoicesListState();
}


class _InvoicesListState extends State<InvoicesList> {


  List<Invoice> invoices = [Invoice.fromJson({})];
  List<Client> clients = [Client.fromJson({})];

  String filter = 'ALL';
  String filter2 = 'CLIENTS';
  String dateSort = 'asc';

  Future<void> _initInvoices() async {
    invoices = await getInvoices('INVOICE',dateSort, filter: filter, clientId: filter2);
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
    String query = '';

    showClient(){
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
                content: Container(
                  // color: secondaryColor,
                  // height: 450,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            // fillColor: secondaryColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: const BorderRadius.all(Radius.circular(10)
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: () async {
                                clients = await searchClients(query);
                                Navigator.of(context).pop();
                                showClient();
                              },
                              child: Container(
                                padding: EdgeInsets.all(defaultPadding * 0.75),
                                margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/Search.svg",
                                ),
                              ),
                            ),
                          ),
                          onChanged: (value) async {
                            query = value;
                          },
                        ),
                        SizedBox(height: 7,),

                        Container(
                          // margin: EdgeInsets.only(left: defaultPadding),
                          // padding: EdgeInsets.symmetric(
                          //   horizontal: defaultPadding,
                          //   vertical: defaultPadding / 2,
                          // ),
                          decoration: BoxDecoration(
                            // color: secondaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(),
                          ),
                          child: TextButton(
                            child: Text("All CLIENTS", style: TextStyle(color: Theme.of(context).primaryColor)),
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
                                      // color: secondaryColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(),
                                    ),
                                    child: TextButton(
                                      child: Text(clients[index].name!, style: TextStyle(color: Theme.of(context).primaryColor)),
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
    }

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

              Row(children: [
                Container(
                  decoration: BoxDecoration(
                    color: getRoleColor("R").withOpacity(.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    // border: Border.all(color: Colors.white),
                  ),
                  child: TextButton(
                    child: SizedBox(child: Text("Client", style: Theme.of(context).textTheme.titleMedium,),),
                    onPressed: () {
                      showClient();
                    },
                    // Delete
                  ),

                ),
                SizedBox(width: 10,),
                Container(
                  // margin: EdgeInsets.only(left: defaultPadding/4),
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: defaultPadding/4,
                  //   vertical: defaultPadding / 100,
                  // ),
                  decoration: BoxDecoration(
                    color: getRoleColor("R").withOpacity(.2),

                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    // border: Border.all(),
                  ),
                  child: TextButton(
                    child: Text(filter + ' INVOICES', style: Theme.of(context).textTheme.titleMedium,),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                                content: Container(
                                  color: secondaryColor,
                                  // height: 350,
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
                                            // color: secondaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(),
                                          ),
                                          child: TextButton(
                                            child: Text("All Invoices",style: TextStyle(color: Theme.of(context).primaryColor)),
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
                                            // color: secondaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(),
                                          ),
                                          child: TextButton(
                                            child: Text("UNPAID Invoices", style: TextStyle(color: Theme.of(context).primaryColor)),
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
                                            // color: secondaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(),
                                          ),
                                          child: TextButton(
                                            child: Text("Draft Invoices", style: TextStyle(color: Theme.of(context).primaryColor)),
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
                                            // color: secondaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(),
                                          ),
                                          child: TextButton(
                                            child: Text("Paid Invoices", style: TextStyle(color: Theme.of(context).primaryColor)),
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
                                            // color: secondaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(),
                                          ),
                                          child: TextButton(
                                            child: Text("Overdue Invoices", style: TextStyle(color: Theme.of(context).primaryColor)),
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
                                            // color: secondaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(),
                                          ),
                                          child: TextButton(
                                            child: Text("Cancelled Invoices", style: TextStyle(color: Theme.of(context).primaryColor)),
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
                                            // color: secondaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(),
                                          ),
                                          child: TextButton(
                                            child: Text("Refunded Invoices", style: TextStyle(color: Theme.of(context).primaryColor)),
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
              ],)


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
                          // color: secondaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(),
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
        DataCell(
            Container(
            padding: EdgeInsets.all(3),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: getRoleColor(userInfo.client.toString()).withOpacity(.2),
              // border: Border.all(color: Colors.lightBlueAccent),
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
              ),
            ),
            child: Text(userInfo.client != null ? userInfo.client!.name??"" : ""))
        ),
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
                      return new InvoiceHome(title: "Edit Invoice: ${userInfo.id}", code: "edit", invoiceId: userInfo.id );
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
                      return new InvoiceHome(title: "Edit Invoice: ${userInfo.id}", code: "edit", invoiceId: userInfo.id );
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

