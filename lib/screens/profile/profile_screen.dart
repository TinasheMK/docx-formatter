import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/providers/registration/Currency.dart';
import 'package:smart_admin_dashboard/screens/profile/components/add_business_profile_home.dart';

import '../../core/utils/UserPreference.dart';
import '../../core/constants/color_constants.dart';
import '../../core/widgets/app_button_widget.dart';
import '../../core/widgets/input_widget.dart';
import '../../providers/registration/Wallet.dart';
import '../../core/utils/responsive.dart';

import '../dashboard/components/header.dart';
import '../invoice/components/header.dart';
import './components/mini_information_card.dart';

import './components/recent_forums.dart';
import './components/recent_users.dart';
import './components/user_details_widget.dart';
import 'package:flutter/material.dart';

// import 'components/memo_list_material.dart';


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
              SizedBox(height: 30,),
              MiniInformation(),
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

                        _registerScreen(context),



                        SizedBox(
                          // height: 600,
                            child: AddBusinessProfileHome(
                            callback: callback
                        )
                        ),
                        // RecentUsers(),
                        CurrencySelector(),

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
    print("clients");
    return Card(
      color: bgColor,
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 16.0, horizontal: 16.0),
            child: Column(
              children: [


                SizedBox(height: 10,),




                ElevatedButton.icon(
                  icon: Icon(
                    Icons.flag,
                    size: 14,
                  ),
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10),
                      primary: Colors.blueAccent),
                  label: Text(activeCurrency ?? "Select Currency"),

                  onPressed: () {

                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                              content: Container(
                                color: secondaryColor,
                                height: 410,
                                child: Column(
                                  children:
                                  List.generate(
                                      currencies.length,
                                          (index) =>


                                          Container(
                                            margin: EdgeInsets.only(bottom: defaultPadding),
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
                                              child: Text(currencies[index].id!, style: TextStyle(color: Colors.white)),
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
                  },)





              ],
            )),
      ),
    );
  }
}
