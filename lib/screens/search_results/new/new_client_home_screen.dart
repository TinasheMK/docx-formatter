//
// import '../../../core/constants/color_constants.dart';
// import '../../../core/widgets/app_button_widget.dart';
// import '../../../core/widgets/input_widget.dart';
// import '../../../providers/registration/Client.dart';
// import '../../../responsive.dart';
// import '../../../screens/home/home_screen.dart';
// import '../../home/components/side_menu.dart';
// import './components/slider_widget.dart';
//
// import 'package:flutter/material.dart';
//
// import 'new_client_screen.dart';
//
// class NewClientHome extends StatefulWidget {
//   NewClientHome({required this.title, required this.code, this.clientId});
//   final String title;
//   final String code;
//   int? clientId;
//   @override
//   _NewClientHomeState createState() => _NewClientHomeState();
// }
//
// class _NewClientHomeState extends State<NewClientHome> with SingleTickerProviderStateMixin {
//
//
//   var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
//       .chain(CurveTween(curve: Curves.ease));
//   var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
//       .chain(CurveTween(curve: Curves.ease));
//
//   AnimationController? _animationController;
//
//   var _isMoved = false;
//
//   bool isChecked = false;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 750),
//     );
//   }
//
//
//
//   @override
//   void dispose() {
//     _animationController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//
//
//     return Scaffold(
//       //key: context.read<MenuController>().scaffoldKey,
//       drawer: SideMenu(),
//       body: SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // We want this side menu only for large screen
//             if (Responsive.isDesktop(context))
//               Expanded(
//                 // default flex = 1
//                 // and it takes 1/6 part of the screen
//                 child: SideMenu(),
//               ),
//             Expanded(
//               // It takes 5/6 part of the screen
//               flex: 5,
//               child: NewClientScreen(title: widget.title, code: widget.code, clientId: widget.clientId,),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
