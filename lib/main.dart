import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/init/provider_list.dart';
import 'package:smart_admin_dashboard/core/utils/databaseHelper.dart';
import 'package:smart_admin_dashboard/screens/dashboard/home_screen.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;
final dbHelper = DatabaseHelper();

Future<void> main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();


  runApp(MyApp());
}

Widget build(BuildContext context) {
  return MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: FutureBuilder(
        builder: (context, snapshot) {
          return MyApp();
        },
      ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Dashboard - Admin Panel v0.1 ',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: bgColor, elevation: 0),
        scaffoldBackgroundColor: bgColor,
        primaryColor: greenColor,
        dialogBackgroundColor: secondaryColor,
        primaryColorDark: greenColor,
        // textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
        //     .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: HomeScreen(),
      // home: Login(title: "Wellcome to the Admin & Dashboard Panel"),
    );
  }
}
