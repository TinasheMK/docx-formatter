import '../../../core/utils/responsive.dart';
import '../../dashboard/components/side_menu.dart';

import 'package:flutter/material.dart';

import 'new_objective_screen.dart';

class NewObjectiveHome extends StatefulWidget {
  NewObjectiveHome({required this.title, required this.code, this.clientId});
  final String title;
  final String code;
  int? clientId;
  @override
  _NewObjectiveHomeState createState() => _NewObjectiveHomeState();
}

class _NewObjectiveHomeState extends State<NewObjectiveHome> with SingleTickerProviderStateMixin {


  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;

  bool isChecked = false;



  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
  }



  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      //key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: NewObjectiveScreen(title: widget.title, code: widget.code, clientId: widget.clientId,),
            ),
          ],
        ),
      ),
    );
  }

}
