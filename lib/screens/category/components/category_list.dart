import 'dart:convert';
import 'dart:developer';

import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/utils/colorful_tag.dart';
import 'package:smart_admin_dashboard/core/types/recent_user_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../core/models/Category.dart';
import '../../../core/utils/responsive.dart';
import '../categorys_home_screen.dart';
import '../categorys_home_screen.dart';
import '../edit/category_home_screen.dart';
 


class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  List<Category> categorys = [Category.fromJson({})];

  Future<void> _initcategorys() async {
    categorys = await getCategorys();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initcategorys();
  }

  @override
  Widget build(BuildContext context) {
      categorys.removeWhere((element) => element.name == null);

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
            "Category List",
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
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Description"),
                  ),
                  // DataColumn(
                  //   label: Text("Stage"),
                  // ),
                  DataColumn(
                    label: Text("Operation"),
                  ),
                ],
                rows: List.generate(
                  categorys.length,
                  (index) => recentUserDataRow(categorys[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

DataRow recentUserDataRow(Category userInfo, BuildContext context) {
  return DataRow(
    cells: [

      DataCell(
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
              text: userInfo.name != null  ?  RegExp(r'^[A-Za-z_.]+$').hasMatch(userInfo.name![0]) ? userInfo.name!: 'a' : "a",
            ),
            SizedBox(width: 4,),
            Container(
                padding: EdgeInsets.all(5),

                child: Text(userInfo.name != null ? userInfo.name! : ""))
          ],)

      ),
      DataCell(Text(userInfo.description != null ? userInfo.description! : "")),
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
                      return new CategoryHome(title: "Edit Category", code: "edit", categoryId: userInfo.id );
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
                      return new CategoryHome(title: "Edit Category", code: "edit", categoryId: userInfo.id );
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
                                    "Are you sure want to delete '${userInfo.name}'?"),
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
                                              content: Text("Category deleted successfully"),
                                            ));
                                          }catch(e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("An error occured while deleting"),
                                            ));
                                          }
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => CategorysHomeScreen()),
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
                                       "Are you sure want to delete '${userInfo.name}'?"),
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
                                                 content: Text("Category deleted successfully"),
                                               ));
                                             }catch(e){
                                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                 content: Text("An error occured while deleting"),
                                               ));
                                             }
                                             Navigator.of(context).pop();
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => CategorysHomeScreen()),
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
