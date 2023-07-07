import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_admin_dashboard/core/types/Conflict.dart';
import 'package:smart_admin_dashboard/screens/login/login_screen.dart';
import 'package:smart_admin_dashboard/screens/receipt/receipts_home_screen.dart';

import '../../../core/utils/UserPreference.dart';
import '../../../core/utils/shared_pref_service.dart';
import '../../../core/widgets/app_button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../core/providers/invoice/provider/invoice_provider.dart';
  import '../../client/clients_home_screen.dart';
import '../../invoice/invoices_home_screen.dart';
import '../../invoice/invoices_screen.dart';
import '../../product/products_home_screen.dart';
import '../../quote/quotes_home_screen.dart';
import '../home_screen.dart';
import 'ConflictSelectionSection.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final sharedPref = watch(sharedPreferencesServiceProvider);
    final invoiceProvider = watch(invoiceNotifierProvider);



    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [


            DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: defaultPadding * 3,
                    ),
                    Image.asset(
                      "assets/logo/logo_icon.png",
                      scale: 5,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Text("Invoicer")
                  ],
                )),



            invoiceProvider.when(
              initial: () => syncWidget(error:false),
              loading: () =>
                  Center(child: CircularProgressIndicator()),
              data: (data) {
                print(data);

                print("Conflict detected.");


                Conflict conflict = new Conflict();
                conflict.object = data;
                conflict.objectType = "invoice";

                SchedulerBinding.instance!
                    .addPostFrameCallback((_) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                            title: Center(
                              child: Text("Resolve Conflicts"),
                            ),
                            content: SingleChildScrollView(
                              // color: secondaryColor,
                              // height: 70,
                              child: Column(
                                children: [
                                  Text(
                                      "The following conflicts were encountered while syncing data. Select to resolve.",
                                    style: const TextStyle(color: Colors.greenAccent, fontSize: 14),
                                  ),

                                  SizedBox(
                                    height: 16,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     SizedBox(
                                  //       width: 150,
                                  //       child: Text("Incoming Changes") ,
                                  //     ),
                                  //     SizedBox(
                                  //       width: 20,
                                  //     ),
                                  //     SizedBox(
                                  //       width: 150,
                                  //       child: Text("Your changes"),),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: 1000,
                                    height: 900,
                                    child:
                                    SingleChildScrollView(

                                        child:ConflictSelectionSection(conflict: conflict)
                            ),
                                  ),


                                ],
                              ),
                            ));
                      });
                });


                return syncWidget(error: false);
              },

              loaded: (loaded) {


                // SchedulerBinding.instance!
                //     .addPostFrameCallback((_) {
                //   Navigator.pop(context, true);
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text(loaded.toString()),
                //   ));
                // });



                return syncWidget(error: false);
              },
              error: (e) {

                // print("I am king but error eoccured");
                log(e.toString());

                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  context.read(invoiceNotifierProvider.notifier).resetState();
                });



                return syncWidget(error: true,);
              },
            ),


            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(source: 'side menu',)),
                );
              },
            ),
            DrawerListTile(
              title: "Invoices",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                );
              },
            ),
            DrawerListTile(
              title: "Quotations",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuoteHomeScreen()),
                );
              },
            ),
            DrawerListTile(
              title: "Receipts",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReceiptsHomeScreen()),
                );
              },
            ),
            DrawerListTile(
              title: "Products",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsHomeScreen()),
                );
              },
            ),
            // DrawerListTile(
            //   title: "Quotes",
            //   svgSrc: "assets/icons/menu_task.svg",
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => TaxHomeScreen()),
            //     );
            //   },
            // ),
            DrawerListTile(
              title: "Clients",
              svgSrc: "assets/icons/menu_doc.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
                );
              },
            ),
            DrawerListTile(
              title: "Logout",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () async {
                await sharedPref.resetUserCredentials();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(UserPreference.skip,
                    false);






                Navigator.pop(context, true);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login(title: "You logged out.")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}


class syncWidget extends StatefulWidget {
  @override
  syncWidgetState createState() => syncWidgetState();
  syncWidget({
    required this.error
  });

  bool error;
}

// class _FormMaterialBackupState extends State<FormMaterialBackup> {

class syncWidgetState extends State<syncWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.error);
  }


  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: 80,
      child: AppButton(
        type: widget.error? ButtonType.PRIMARY :ButtonType.PLAIN,
        text: widget.error?"sync err" : "sync",
        onPressed: () async {
            await context
                .read(invoiceNotifierProvider.notifier)
                .syncInvoices();

        },
      ),
    );
  }
}

