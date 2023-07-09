import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/init/provider_list.dart';
import 'package:smart_admin_dashboard/core/db/databaseHelper.dart';
import 'package:smart_admin_dashboard/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;

import 'core/utils/shared_pref_service.dart';
final dbHelper = DatabaseHelper();
final globalThemeDark = false;

Future<void> main() async {
  try {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;
    }
  }catch(e){}

  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();


  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesServiceProvider.overrideWithValue(
            SharedPreferencesService(sharedPreferences),
          ),
        ],
        child: MyApp(),
      ),
  );
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
      title: 'Invoicer',
      theme:

      ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0),
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.black),),
        tabBarTheme: TabBarTheme(labelColor: Colors.black, indicatorColor: defaultColor, dividerColor: defaultColor),
        scaffoldBackgroundColor: bgColorLight,
        primaryColor: Colors.black,
        dialogBackgroundColor: secondaryColor,
        canvasColor: secondaryColor,
      ),

      // ThemeData.dark().copyWith(
      //   appBarTheme: AppBarTheme(backgroundColor: bgColor, foregroundColor: Colors.white, elevation: 0),
      //   textButtonTheme: TextButtonThemeData
      //     (style: TextButton.styleFrom(
      //       foregroundColor: Colors.white,
      //       backgroundColor: bgColor),
      //   ),
      //   tabBarTheme: TabBarTheme(labelColor: Colors.white, indicatorColor: defaultColor, dividerColor: defaultColor),
      //   scaffoldBackgroundColor: bgColor,
      //   primaryColor: Colors.white,
      //   // primaryColorDark: Colors.black,
      //
      //   dialogBackgroundColor: secondaryColor,
      //   canvasColor: secondaryColor,
      // ),
      home: Login(title: "Welcome to the Admin & Dashboard Panel"),
    );
  }
}
