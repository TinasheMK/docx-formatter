import 'dart:convert';
import 'dart:developer';

import 'package:docxform/core/constants/color_constants.dart';
import 'package:docxform/core/utils/colorful_tag.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';

import '../../../core/models/Client.dart';
import '../../../core/models/Stage.dart';
import '../../../main.dart';
import '../../../core/utils/responsive.dart';
import '../../clients/clients_home_screen.dart';
import '../new/new_zimra_home_screen.dart';



class ZimrasList extends StatefulWidget {
  const ZimrasList({Key? key, required this.title}) : super(key: key);

  @override
  _ZimrasListState createState() => _ZimrasListState(title);

  final String title;
}

class _ZimrasListState extends State<ZimrasList> {
  _ZimrasListState(this.title);

  final String title;
  List<Client> clients = [Client.fromJson({})];
  List<Stage> stages = [Stage.fromJson({})];



  Future<void> _initclients() async {
    if(title=="ZIMRA"){
      stages = await getTypeStages('zimra');
    }else{
      stages = await getTypeStages('praz');
    }

    clients = await getClients();

    var stageIds = [];
    stages.forEach((s) { stageIds.add(s.id!);});

    clients.forEach((c) {
      c.stages?.removeWhere((s) =>  !stageIds.contains(s.stageId));
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initclients();
  }

  @override
  Widget build(BuildContext context) {
    clients.removeWhere((element) => element.name == null);

    DataRow recentUserDataRow(Client userInfo, String title, BuildContext context) {
      return DataRow(
        cells: [
          DataCell(Container(
            padding: EdgeInsets.all(5),

            child:
            Row(
              children: [
                TextAvatar(
                  size: 35,
                  backgroundColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 14,
                  upperCase: true,
                  numberLetters: 1,
                  shape: Shape.Rectangle,
                  text: userInfo.name != null ? userInfo.name! : "",
                ),
                SizedBox(width: 15,),
                Text(userInfo.name != null ? userInfo.name! : "")

              ],
            ),


          )),

          DataCell(Text(userInfo.stages?.length != null ? userInfo.stages!.length.toString()+"/"+stages!.length.toString() : "0/"+stages!.length.toString())),

          !Responsive.isMobile(context)
              ? DataCell(Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: getRoleColor(userInfo.name).withOpacity(.2),
                border: Border.all(color: getRoleColor(userInfo.name)),
                borderRadius: BorderRadius.all(Radius.circular(5.0) //
                ),
              ),
              child: Text(userInfo.street??"")))
          // child: Text(userInfo.name != null ? userInfo.name! : "")))
              : DataCell(Text(userInfo.street??"")


          ),


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
                          return new NewZimraHome(title: '${title} Registration', code: 'wiw', companyId: userInfo.id,);
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
                          return new NewZimraHome(title: "Edit ${title} Regitration", code: "edit", companyId: userInfo.id );
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
                //                         "Are you sure want to delete '${userInfo.name}'?"),
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
                //                                   content: Text("Client deleted successfully"),
                //                                 ));
                //                               }catch(e){
                //                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //                                   content: Text("An error occured while deleting"),
                //                                 ));
                //                               }
                //                               Navigator.of(context).pop();
                //                               Navigator.push(
                //                                 context,
                //                                 MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
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
                //                           "Are you sure want to delete '${userInfo.name}'?"),
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
                //                                     content: Text("Client deleted successfully"),
                //                                   ));
                //                                 }catch(e){
                //                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //                                     content: Text("An error occured while deleting"),
                //                                   ));
                //                                 }
                //                                 Navigator.of(context).pop();
                //                                 Navigator.push(
                //                                   context,
                //                                   MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
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
            ),
          ),
        ],
      );
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
          Text(
            "Client List (${widget.title} Registration)",
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
                  // DataColumn(
                  //   label: Text(""),
                  // ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Completed"),
                  ),
                  !Responsive.isMobile(context)?DataColumn(
                    label: Text("Street"),):
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
                      (index) => recentUserDataRow(clients[index],widget.title, context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

