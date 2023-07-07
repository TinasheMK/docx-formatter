
import 'package:smart_admin_dashboard/screens/quote/edit/quote_screen.dart';
import 'package:smart_admin_dashboard/screens/receipt/receipts_home_screen.dart';
import 'package:smart_admin_dashboard/screens/receipt/receipts_home_screen.dart';
import 'package:smart_admin_dashboard/screens/receipt/receipts_home_screen.dart';
import 'package:smart_admin_dashboard/screens/receipt/receipts_home_screen.dart';
import 'package:smart_admin_dashboard/screens/receipt/receipts_home_screen.dart';
import 'package:smart_admin_dashboard/screens/receipt/receipts_home_screen.dart';

import '../../../core/utils/responsive.dart';
import '../../dashboard/components/side_menu.dart';

import 'package:flutter/material.dart';

import '../editCollect/receipt_screen.dart';



class ReceiptHomeScreen extends StatefulWidget {
  ReceiptHomeScreen({required this.title, required this.code, this.invoiceId});
  final String title;
  final int? invoiceId;
  final String code;
  @override
  _ReceiptHomeScreenState createState() => _ReceiptHomeScreenState();
}

class _ReceiptHomeScreenState extends State<ReceiptHomeScreen> with SingleTickerProviderStateMixin {
  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;

  var _isMoved = false;

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
              child: ReceiptScreen(title: widget.title, code: widget.code, invoiceId: widget.invoiceId),
            ),
          ],
        ),
      ),
    );
  }

}
