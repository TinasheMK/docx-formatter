// // a handy navigation function
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
//
// // go to [routeTo] widget page
// routeTo(BuildContext context, Widget routeTo,
//     {PageTransitionType transition: PageTransitionType.leftToRight}) {
//   return Navigator.of(context).push(
//     PageTransition(
//       type: transition,
//       child: routeTo,
//     ),
//   );
// }
//
// /// route to next view while clearing navigation history
// routeToWithClear(BuildContext context, Widget routeTo,
//     {PageTransitionType transition: PageTransitionType.leftToRight}) {
//   return Navigator.of(context).pushReplacement(
//     PageTransition(type: transition, child: routeTo),
//   );
// }
//
// routeBack(BuildContext context) {
//   return Navigator.of(context).pop();
// }
//
// routeBackWithClear(BuildContext context) {
//   return Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (c) => SplashView()), (route) => false);
// }
