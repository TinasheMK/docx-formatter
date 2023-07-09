import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_admin_dashboard/screens/profile/profiles_home_screen.dart';

import '../../../core/utils/UserPreference.dart';
import '../../../core/models/Client.dart';
import '../../search_results/clients_home_screen.dart';

class Header extends StatelessWidget {
  Header({
    Key? key
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        if (!Responsive.isMobile(context))
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HelloWidget(),
              SizedBox(
                height: 8,
              ),
              Text(
                "Wellcome to your dashboard",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: GestureDetector(
        onTap:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileHomeScreen()),
          );
        } ,
        child: Row(
          children: [
            Icon(Icons.person),
            if (!Responsive.isMobile(context))
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text("User"),
              ),
            // Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
String query = '';
class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () async {
            print(query);
            List<Client> clients = [];
            if(query!='')clients = await searchClients(query);
            clients.forEach((e) {
              print(e.toJson());
            });

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchResultsHomeScreen(clients: clients)),
            );
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
      onChanged: (value){
        query = value;
        print(query);
      },
    );
  }
}



class HelloWidget extends StatefulWidget {
  @override
  _HelloWidgetState createState() => _HelloWidgetState();
}

class _HelloWidgetState extends State<HelloWidget> {



  String user = "" ;

  init() async {
    var prefs = await SharedPreferences.getInstance();
    user = (await prefs!.getString(UserPreference.firstName))?? "";
    setState(() {

    });
  }

  @override
  void initState() {
    init();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello, "+ user! +" 👋",
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

