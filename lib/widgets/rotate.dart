// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:car_help/core/utils/api_config.dart';

// class Rotate extends StatelessWidget {
//   final Widget child;
//   final bool isReverse;

//   const Rotate({
//     required this.child,
//     this.isReverse = false,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if(isReverse){
//       return Transform.rotate(
//         angle: ApiConfig.isArabic ? 180 * pi / 180 : 0 ,
//         child: child,
//       );
//     }else{
//       return Transform.rotate(
//         angle: ApiConfig.isArabic ? 0 : 180 * pi / 180,
//         child: child,
//       );

//     }
//   }
// }
