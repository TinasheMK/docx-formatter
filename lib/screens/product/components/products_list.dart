import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/utils/colorful_tag.dart';
import 'package:flutter/material.dart';
import '../../../core/models/Client.dart';
import '../../../core/models/Product.dart';
import '../../../core/utils/responsive.dart';
import '../edit/product_home_screen.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({
    Key? key,
  }) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}


class _ProductsListState extends State<ProductsList> {


  List<Product> products = [Product.fromJson({})];
  List<Client> clients = [Client.fromJson({})];

  String filter = 'ALL';
  String filter2 = 'CLIENTS';
  String dateSort = 'asc';

  Future<void> _initProducts() async {
    products = await getProducts();
    clients = await getClients();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initProducts();
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
                "Product List",
                style: Theme.of(context).textTheme.subtitle1,
              ),

              // Row(children: [
              //   Container(
              //     decoration: BoxDecoration(
              //       color: getRoleColor("R").withOpacity(.2),
              //       borderRadius: const BorderRadius.all(Radius.circular(10)),
              //       // border: Border.all(color: Colors.white),
              //     ),
              //     child: TextButton(
              //       child: SizedBox(child: Text(filter2, style: Theme.of(context).textTheme.titleMedium,),),
              //       onPressed: () {
              //         showDialog(
              //             context: context,
              //             builder: (_) {
              //               return AlertDialog(
              //                   content: Container(
              //                     // color: secondaryColor,
              //                     // height: 450,
              //                     child: SingleChildScrollView(
              //                       child: Column(
              //                         children: [
              //                           Container(
              //                             // margin: EdgeInsets.only(left: defaultPadding),
              //                             // padding: EdgeInsets.symmetric(
              //                             //   horizontal: defaultPadding,
              //                             //   vertical: defaultPadding / 2,
              //                             // ),
              //                             decoration: BoxDecoration(
              //                               // color: secondaryColor,
              //                               borderRadius: const BorderRadius.all(Radius.circular(10)),
              //                               border: Border.all(),
              //                             ),
              //                             child: TextButton(
              //                               child: Text("All CLIENTS", style: TextStyle(color: Theme.of(context).primaryColor)),
              //                               onPressed: () {
              //                                 filter2 = 'CLIENTS';
              //                                 _initProducts();
              //                                 Navigator.of(context).pop();
              //                               },
              //                               // Delete
              //                             ),
              //
              //                           ),
              //                           SizedBox(height: 7,),
              //
              //
              //                           Column(
              //                             children:
              //                             List.generate(
              //                                 clients.length,
              //                                     (index) =>
              //
              //
              //                                     Container(
              //                                       margin: EdgeInsets.only(bottom: 7),
              //                                       // padding: EdgeInsets.symmetric(
              //                                       //   horizontal: defaultPadding,
              //                                       //   vertical: defaultPadding / 2,
              //
              //                                       // ),
              //                                       decoration: BoxDecoration(
              //                                         // color: secondaryColor,
              //                                         borderRadius: const BorderRadius.all(Radius.circular(10)),
              //                                         border: Border.all(),
              //                                       ),
              //                                       child: TextButton(
              //                                         child: Text(clients[index].name!, style: TextStyle(color: Theme.of(context).primaryColor)),
              //                                         onPressed: () {
              //                                           filter2 = clients[index]!.id.toString()!;
              //                                           _initProducts();
              //                                           setState(() {
              //                                           });
              //                                           Navigator.of(context).pop();
              //                                         },
              //                                         // Delete
              //                                       ),
              //
              //                                     )
              //                             ),
              //
              //
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ));
              //             });
              //       },
              //       // Delete
              //     ),
              //
              //   ),
              //   SizedBox(width: 10,),
              //   Container(
              //     // margin: EdgeInsets.only(left: defaultPadding/4),
              //     // padding: EdgeInsets.symmetric(
              //     //   horizontal: defaultPadding/4,
              //     //   vertical: defaultPadding / 100,
              //     // ),
              //     decoration: BoxDecoration(
              //       color: getRoleColor("R").withOpacity(.2),
              //
              //       borderRadius: const BorderRadius.all(Radius.circular(10)),
              //       // border: Border.all(),
              //     ),
              //     child: TextButton(
              //       child: Text(filter + ' INVOICES', style: Theme.of(context).textTheme.titleMedium,),
              //       onPressed: () {
              //         showDialog(
              //             context: context,
              //             builder: (_) {
              //               return AlertDialog(
              //                   content: Container(
              //                     color: secondaryColor,
              //                     // height: 350,
              //                     child: SingleChildScrollView(
              //                       child: Column(
              //                         children: [
              //
              //                           Container(
              //                             // margin: EdgeInsets.only(left: defaultPadding),
              //                             // padding: EdgeInsets.symmetric(
              //                             //   horizontal: defaultPadding,
              //                             //   vertical: defaultPadding / 2,
              //                             // ),
              //                             decoration: BoxDecoration(
              //                               // color: secondaryColor,
              //                               borderRadius: const BorderRadius.all(Radius.circular(10)),
              //                               border: Border.all(),
              //                             ),
              //                             child: TextButton(
              //                               child: Text("All Products",style: TextStyle(color: Theme.of(context).primaryColor)),
              //                               onPressed: () {
              //                                 filter = 'ALL';
              //                                 _initProducts();
              //                                 Navigator.of(context).pop();
              //                               },
              //                               // Delete
              //                             ),
              //
              //                           ),
              //                           SizedBox(height: 7,),
              //                           Container(
              //                             // margin: EdgeInsets.only(left: defaultPadding),
              //                             // padding: EdgeInsets.symmetric(
              //                             //   horizontal: defaultPadding,
              //                             //   vertical: defaultPadding / 2,
              //                             // ),
              //                             decoration: BoxDecoration(
              //                               // color: secondaryColor,
              //                               borderRadius: const BorderRadius.all(Radius.circular(10)),
              //                               border: Border.all(),
              //                             ),
              //                             child: TextButton(
              //                               child: Text("UNPAID Products", style: TextStyle(color: Theme.of(context).primaryColor)),
              //                               onPressed: () {
              //                                 filter = 'UNPAID';
              //                                 _initProducts();
              //                                 Navigator.of(context).pop();
              //                               },
              //                               // Delete
              //                             ),
              //
              //                           ),
              //                           SizedBox(height: 7,),
              //
              //                           Container(
              //                             // margin: EdgeInsets.only(left: defaultPadding),
              //                             // padding: EdgeInsets.symmetric(
              //                             //   horizontal: defaultPadding,
              //                             //   vertical: defaultPadding / 2,
              //                             // ),
              //                             decoration: BoxDecoration(
              //                               // color: secondaryColor,
              //                               borderRadius: const BorderRadius.all(Radius.circular(10)),
              //                               border: Border.all(),
              //                             ),
              //                             child: TextButton(
              //                               child: Text("Draft Products", style: TextStyle(color: Theme.of(context).primaryColor)),
              //                               onPressed: () {
              //                                 filter = 'DRAFT';
              //                                 _initProducts();
              //                                 Navigator.of(context).pop();
              //                               },
              //                               // Delete
              //                             ),
              //
              //                           ),
              //
              //                           SizedBox(height: 7,),
              //
              //                           Container(
              //                             // margin: EdgeInsets.only(left: defaultPadding),
              //                             // padding: EdgeInsets.symmetric(
              //                             //   horizontal: defaultPadding,
              //                             //   vertical: defaultPadding / 2,
              //                             // ),
              //                             decoration: BoxDecoration(
              //                               // color: secondaryColor,
              //                               borderRadius: const BorderRadius.all(Radius.circular(10)),
              //                               border: Border.all(),
              //                             ),
              //                             child: TextButton(
              //                               child: Text("Paid Products", style: TextStyle(color: Theme.of(context).primaryColor)),
              //                               onPressed: () {
              //                                 filter = 'PAID';
              //                                 _initProducts();
              //                                 Navigator.of(context).pop();
              //                               },
              //                               // Delete
              //                             ),
              //
              //                           ),
              //
              //                           SizedBox(height: 7,),
              //
              //                           Container(
              //                             // margin: EdgeInsets.only(left: defaultPadding),
              //                             // padding: EdgeInsets.symmetric(
              //                             //   horizontal: defaultPadding,
              //                             //   vertical: defaultPadding / 2,
              //                             // ),
              //                             decoration: BoxDecoration(
              //                               // color: secondaryColor,
              //                               borderRadius: const BorderRadius.all(Radius.circular(10)),
              //                               border: Border.all(),
              //                             ),
              //                             child: TextButton(
              //                               child: Text("Overdue Products", style: TextStyle(color: Theme.of(context).primaryColor)),
              //                               onPressed: () {
              //                                 filter = 'OVERDUE';
              //                                 _initProducts();
              //                                 Navigator.of(context).pop();
              //                               },
              //                               // Delete
              //                             ),
              //
              //                           ),
              //
              //                           SizedBox(height: 7,),
              //
              //                           Container(
              //                             // margin: EdgeInsets.only(left: defaultPadding),
              //                             // padding: EdgeInsets.symmetric(
              //                             //   horizontal: defaultPadding,
              //                             //   vertical: defaultPadding / 2,
              //                             // ),
              //                             decoration: BoxDecoration(
              //                               // color: secondaryColor,
              //                               borderRadius: const BorderRadius.all(Radius.circular(10)),
              //                               border: Border.all(),
              //                             ),
              //                             child: TextButton(
              //                               child: Text("Cancelled Products", style: TextStyle(color: Theme.of(context).primaryColor)),
              //                               onPressed: () {
              //                                 filter = 'CANCELLED';
              //                                 _initProducts();
              //                                 Navigator.of(context).pop();
              //                               },
              //                               // Delete
              //                             ),
              //
              //                           ),
              //                           SizedBox(height: 7,),
              //
              //                           Container(
              //                             // margin: EdgeInsets.only(left: defaultPadding),
              //                             // padding: EdgeInsets.symmetric(
              //                             //   horizontal: defaultPadding,
              //                             //   vertical: defaultPadding / 2,
              //                             // ),
              //                             decoration: BoxDecoration(
              //                               // color: secondaryColor,
              //                               borderRadius: const BorderRadius.all(Radius.circular(10)),
              //                               border: Border.all(),
              //                             ),
              //                             child: TextButton(
              //                               child: Text("Refunded Products", style: TextStyle(color: Theme.of(context).primaryColor)),
              //                               onPressed: () {
              //                                 filter = 'REFUNDED';
              //                                 _initProducts();
              //                                 Navigator.of(context).pop();
              //                               },
              //                               // Delete
              //                             ),
              //
              //                           ),
              //
              //                           SizedBox(
              //                             height: 16,
              //                           ),
              //                           Row(
              //                             mainAxisAlignment: MainAxisAlignment.center,
              //                             children: [
              //                               ElevatedButton.icon(
              //                                   icon: Icon(
              //                                     Icons.close,
              //                                     size: 14,
              //                                   ),
              //                                   onPressed: () {
              //                                     Navigator.of(context).pop();
              //                                   },
              //                                   label: Text("Cancel")),
              //                             ],
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ));
              //             });
              //       },
              //       // Delete
              //     ),
              //
              //   ),
              // ],)


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
                  label: Text("Name"),
                ),
                DataColumn(
                    label: GestureDetector(
                      child: Container(
                        // margin: EdgeInsets.only(left: defaultPadding/4),
                          padding: EdgeInsets.all(defaultPadding/3 ),
                          decoration: BoxDecoration(
                            // color: secondaryColor,
                            // borderRadius: const BorderRadius.all(Radius.circular(10)),
                            // border: Border.all(),
                          ),
                          child:Text("SKU")),
                      onTap: (){
                        // if(dateSort=='desc') {
                        //   dateSort = 'asc';
                        // }else if (dateSort=='asc') {
                        //   dateSort = 'desc';
                        // }
                        // _initProducts();
                        setState(() { });
                      },
                    )
                ),
                DataColumn(
                  label: Text("Price"),
                ),
                DataColumn(
                  label: Text("Actions"),
                ),
              ],
              rows: List.generate(
                products.length,
                    (index) => recentUserDataRow(products[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow recentUserDataRow(Product userInfo) {
    return DataRow(
      cells: [
        DataCell(Text(userInfo.id.toString()!)),
        DataCell(Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: getRoleColor(userInfo.name.toString()).withOpacity(.2),
              // border: Border.all(color: Colors.lightBlueAccent),
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
              ),
            ),
            child: Text(userInfo.name != null ? userInfo.name??"" : ""))),
        DataCell(Text(userInfo.sku.toString())),
        DataCell(Text(userInfo.price.toString().split(" ")[0])),
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
                      return new ProductHome(title: "Edit Product: ${userInfo.id}", code: "edit", invoiceId: userInfo.id );
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
                      return new ProductHome(title: "Edit Product: ${userInfo.id}", code: "edit", invoiceId: userInfo.id );
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
            //                                   content: Text("Product deleted successfully"),
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
            //                                     content: Text("Product deleted successfully"),
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

