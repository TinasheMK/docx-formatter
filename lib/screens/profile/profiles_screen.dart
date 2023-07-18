import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/models/Currency.dart';
import 'package:smart_admin_dashboard/screens/profile/components/add_business_profile_home.dart';

import '../../core/utils/UserPreference.dart';
import '../../core/constants/color_constants.dart';
import '../../core/widgets/input_widget.dart';
import '../../core/utils/responsive.dart';
import '../dashboard/components/header.dart';
import './components/profiles_header.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  callback(mem, action) {

  }

  @override
  Widget build(BuildContext context) {
    print("This is profile screen");
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              // SizedBox(height: 30,),
              // ProfilesHeader(),
              // SizedBox(height: 60,),
              // Image.asset("assets/logo/logo_icon.png", scale:4),
              SizedBox(height: defaultPadding),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Card(
                          // color: bgColor,
                          // elevation: 5,
                          margin: EdgeInsets.all(3),
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Profile"),
                                      // Icon(Icons.add)
                                    ],
                                  )),
                            ),
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: _registerScreen(context),
                                        ));
                                  });
                            },
                          ),
                        ),
                        Card(
                          // color: bgColor,
                          // elevation: 5,
                          margin: EdgeInsets.all(3),
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Businesses"),
                                      // Icon(Icons.add)
                                    ],
                                  )),
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddBusinessProfileHome(callback: callback,)),
                              );
                            },
                          ),
                        ),
                        CurrencySelector(),
                        // Card(
                        //   // color: bgColor,
                        //   // elevation: 5,
                        //   margin: EdgeInsets.all(3),
                        //   child: GestureDetector(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(3.0),
                        //       child: Container(
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 10.0, horizontal: 16.0),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text("Theme"),
                        //               // Icon(Icons.add)
                        //             ],
                        //           )),
                        //     ),
                        //     onTap: (){
                        //       // Navigator.pushReplacement(
                        //       //   context,
                        //       //   MaterialPageRoute(builder: (context) => ProfileHome(title: 'New Invoice', code: 'invoice',)),
                        //       // );
                        //     },
                        //   ),
                        // ),


                        // _registerScreen(context),



                        // SizedBox(
                        //   // height: 600,
                        //     child: AddBusinessProfileHome(
                        //     callback: callback
                        // )
                        // ),

                        SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  // if (!Responsive.isMobile(context))
                    //z Expanded(
                    //   flex: 2,
                    //   child: UserDetailsWidget(),
                    // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



Container _registerScreen(BuildContext context) {
  return Container(
    width: double.infinity,
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputWidget(
            keyboardType: TextInputType.emailAddress,
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            onChanged: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },

            topLabel: "User Name",

            hintText: "Enter Name",
            // prefixIcon: FlutterIcons.chevron_left_fea,
          ),
          SizedBox(height: 8.0),
          InputWidget(
            keyboardType: TextInputType.emailAddress,
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            onChanged: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },

            topLabel: "User Email",

            hintText: "Enter E-mail",
            // prefixIcon: FlutterIcons.chevron_left_fea,
          ),
          SizedBox(height: 8.0),
        ],
      ),
    ),
  );
}




class CurrencySelector extends StatefulWidget {
  @override
  _CurrencySelectorState createState() => _CurrencySelectorState();

  CurrencySelector({
    Key? key,
  }) : super(key: key);


}





class _CurrencySelectorState extends State<CurrencySelector> {

  List<Currency> currencies = [];

  String? activeCurrency = "";
  SharedPreferences? prefs;


  Future<void> _init() async {
    currencies = await getCurrencys();
    prefs = await SharedPreferences.getInstance();
    activeCurrency= await prefs?.getString(UserPreference.activeCurrency);

    setState(() {});

  }

  @override
  void initState() {

    _init();
  }


  @override
  Widget build(BuildContext context) {
    print(currencies);
    print("Currencies");
    return Card(
      // color: bgColor,
      // elevation: 5,
      margin: EdgeInsets.all(3),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Currencies"),
                  // Icon(Icons.add)
                ],
              )),
        ),
        onTap: (){
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        children:
                        List.generate(
                            currencies.length,
                                (index) =>


                                Container(
                                  margin: EdgeInsets.only(bottom: 3),
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
                                    child: Text(currencies[index].id!),
                                    onPressed: () {

                                      prefs?.setString(UserPreference.activeCurrency, currencies[index].id ?? "");


                                      setState(() {
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    // Delete
                                  ),

                                )
                        ),


                      ),
                    ));
              });
        },
      ),
    );
  }
}
