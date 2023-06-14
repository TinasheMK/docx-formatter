import 'dart:convert';
import 'dart:developer';

import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/utils/colorful_tag.dart';
import 'package:smart_admin_dashboard/providers/recent_user_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../providers/registration/Client.dart';
import '../../../responsive.dart';
import '../../clients/clients_home_screen.dart';
import '../../clients/new/new_client_home_screen.dart';



class RecentUsers extends StatefulWidget {
  @override
  _RecentUsersState createState() => _RecentUsersState();
}

class _RecentUsersState extends State<RecentUsers> {

  List<Client> clients = [Client.fromJson({})];

  Future<void> _initclients() async {
    clients = await getClients();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initclients();
  }

  @override
  Widget build(BuildContext context) {
      clients.removeWhere((element) => element.companyName == null);

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
            "Client List",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: Text(""),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  !Responsive.isMobile(context)?DataColumn(
                    label: Text("Phone"),):
                  DataColumn(label: Text("")),
                  DataColumn(
                    label: Text("City"),
                  ),
                  // DataColumn(
                  //   label: Text("Stage"),
                  // ),
                  DataColumn(
                    label: Text("Operation"),
                  ),
                ],
                rows: List.generate(
                  clients.length,
                  (index) => recentUserDataRow(clients[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

DataRow recentUserDataRow(Client userInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        TextAvatar(
          size: 35,
          backgroundColor: Colors.white,
          textColor: Colors.white,
          fontSize: 14,
          upperCase: true,
          numberLetters: 1,
          shape: Shape.Rectangle,
          text: userInfo.companyName != null  ?  RegExp(r'^[A-Za-z_.]+$').hasMatch(userInfo.companyName![0]) ? userInfo.companyName!: 'a' : "a",
        ),
      ),
      DataCell(Container(
          padding: EdgeInsets.all(5),

          child: Text(userInfo.companyName != null ? userInfo.companyName! : ""))),
      !Responsive.isMobile(context)
          ? DataCell(Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: getRoleColor(userInfo.telephone).withOpacity(.2),
            border: Border.all(color: getRoleColor(userInfo.companyName)),
            borderRadius: BorderRadius.all(Radius.circular(5.0) //
                ),
          ),
          child: Text(userInfo.telephone != null ? userInfo.telephone! : "")))
          : DataCell(Text("")),
      DataCell(Text(userInfo.city != null ? userInfo.city! : "")),
      // DataCell(Text(userInfo.city != null ? userInfo.city! : "")),
      DataCell(
        Row(
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
                      return new NewClientHome(title: "Edit Client", code: "edit", clientId: userInfo.id );
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
                      return new NewClientHome(title: "Edit Client", code: "edit", clientId: userInfo.id );
                    },
                    fullscreenDialog: true));
              },
              child:Icon(Icons.edit, color:Colors.blue.withOpacity(0.5)),
            ),
            SizedBox(
              width: 6,
            ),
            // Responsive.isDesktop(context) ? ElevatedButton.icon(
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.green.withOpacity(0.5),
            //   ),
            //   icon: Icon(
            //     Icons.visibility,
            //     size: 14,
            //   ),
            //   onPressed: () {},
            //   //View
            //   label: Text("View"),
            // ) : Icon(Icons.remove_red_eye, color: Colors.green.withOpacity(0.5)),
            SizedBox(
              width: 6,
            ),
            Responsive.isDesktop(context)
                ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.red.withOpacity(0.5),
              ),
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                          title: Center(
                            child: Text("Confirm Deletion"),
                          ),
                          content: Container(
                            color: secondaryColor,
                            height: 70,
                            child: Column(
                              children: [
                                Text(
                                    "Are you sure want to delete '${userInfo.companyName}'?"),
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
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () {
                                          try{
                                            userInfo.delete();
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Client deleted successfully"),
                                            ));
                                          }catch(e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("An error occured while deleting"),
                                            ));
                                          }
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
                                          );
                                        },
                                        label: Text("Delete"))
                                  ],
                                )
                              ],
                            ),
                          ));
                    });
              },
              // Delete
              label: Text("Delete"),
            )
                : GestureDetector(
                 onTap: (){
                   showDialog(
                       context: context,
                       builder: (_) {
                         return AlertDialog(
                             title: Center(
                               child: Text("Confirm Deletion"),
                             ),
                             content: Container(
                               color: secondaryColor,
                               height: 100,
                               child: Column(
                                 children: [
                                   Text(
                                       "Are you sure want to delete '${userInfo.companyName}'?"),
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
                                       SizedBox(
                                         width: 20,
                                       ),
                                       ElevatedButton.icon(
                                           icon: Icon(
                                             Icons.delete,
                                             size: 14,
                                           ),
                                           style: ElevatedButton.styleFrom(
                                               primary: Colors.red),
                                           onPressed: () {
                                             try{
                                               userInfo.delete();
                                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                 content: Text("Client deleted successfully"),
                                               ));
                                             }catch(e){
                                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                 content: Text("An error occured while deleting"),
                                               ));
                                             }
                                             Navigator.of(context).pop();
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
                                             );
                                           },
                                           label: Text("Delete"))
                                     ],
                                   )
                                 ],
                               ),
                             ));
                       });
                 } ,
                child: Icon( Icons.delete, color: Colors.red.withOpacity(0.5),)
            ),
          ],
        ),
      ),
    ],
  );
}
