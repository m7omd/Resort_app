import 'package:flutter/material.dart';

// abstract class AppTextStyles {
//   static const textStyle18_600 = TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.w600,
//   );
//   static const textStyle18_600White = TextStyle(
//     color: Colors.white,
//     fontSize: 18,
//     fontWeight: FontWeight.w600,
//   );
//   static const textStyle18_900 = TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.w900,
//   );
//   static const textStyle20_400 = TextStyle(
//     fontSize: 20,
//     fontWeight: FontWeight.w400,
//   );
//   static const textStyle20_700 = TextStyle(
//     fontSize: 20,
//     fontWeight: FontWeight.w700,
//   );
//   static const textStyle20_700White = TextStyle(
//     color: Colors.white,
//     fontSize: 20,
//     fontWeight: FontWeight.w700,
//   );
//   static const textStyle30 = TextStyle(
//     fontSize: 30,
//     fontWeight: FontWeight.w900,
//     letterSpacing: 1.2,
//   );
//   static const textStyle14_700White = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w700,
//     color: Colors.white,
//   );
//   static const textStyle14_500White = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w500,
//     color: Colors.white,
//   );
//   static const textStyle14_400 = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//   );
//   static const textStyle14_600Grey = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w600,
//     color: Colors.grey,
//   );
//   static const textStyle14_700Black = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w700,
//   );
//   static const textStyle14_800Black = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w800,
//   );
//   static const textStyle14_800White = TextStyle(
//     color: Colors.white,
//     fontSize: 14,
//     fontWeight: FontWeight.w800,
//   );
//   static const textStyle12_700Grey = TextStyle(
//     fontWeight: FontWeight.w700,
//     fontSize: 12,
//     color: Colors.grey,
//   );
//   static const textStyle13_600Grey = TextStyle(
//     fontWeight: FontWeight.w600,
//     fontSize: 13,
//     color: Colors.grey,
//   );
//   static const textStyle13_600 = TextStyle(
//     fontWeight: FontWeight.w600,
//     fontSize: 13,
//   );
//   static const textStyle12_700 = TextStyle(
//     fontSize: 12,
//     fontWeight: FontWeight.w700,
//   );
//   static const textStyle12_900 = TextStyle(
//     fontSize: 12,
//     fontWeight: FontWeight.w900,
//   );
//   static const textStyle12_500 = TextStyle(
//     fontSize: 12,
//     fontWeight: FontWeight.w500,
//   );
//   static const textStyle10_800 = TextStyle(
//     fontSize: 10,
//     fontWeight: FontWeight.w800,
//   );
//   static const textStyle12_600 = TextStyle(
//     fontSize: 12,
//     fontWeight: FontWeight.w600,
//   );
//   static const textStyle12_400Grey = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey);
//   static const textStyle16_400 = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w400,
//   );
//   static const textStyle16_800 = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w800,
//   );
//   static const textStyle16_700 = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w700,
//   );
//   static const textStyle16_700Grey = TextStyle(
//     color: Colors.grey,
//     fontSize: 16,
//     fontWeight: FontWeight.w700,
//   );
//   static const textStyle16_800White = TextStyle(
//     fontSize: 16,
//     color: Colors.white,
//     fontWeight: FontWeight.w800,
//   );
//   static const textStyle12_600White = TextStyle(
//     fontSize: 12,
//     color: Colors.white,
//     fontWeight: FontWeight.w600,
//   );
//   static const textStyle12_400White = TextStyle(
//     fontSize: 12,
//     color: Colors.white,
//     fontWeight: FontWeight.w400,
//   );
//   static const textStyle24_700 = TextStyle(
//     fontSize: 24,
//     fontWeight: FontWeight.w700,
//     color: Colors.black,
//   );
//
//
//
// );
//
//
//
// }
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const headingLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );

  static  TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    // fontFamily: 'SegoeUI',
    color: AppColors.primary
    ,
  );

  static const subtitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    // fontFamily: 'SegoeUI',
    color: Colors.black87,
    height: 0,
    letterSpacing: 0
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );

  static const bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    // fontFamily: 'SegoeUI',

    color: Colors.black,
  );
  static const textstyle14_bold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );
  static const textstyle14_semibold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );
  static const textstyle14_regular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );
  static const textstyle13_regular = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );

  static const textstyle16_bold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
    height: 0
  );
  static const textstyle16_regular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );
  static  TextStyle textstyle18_regular = TextStyle(
    fontSize: 18,
    color: Colors.grey.shade600,
  );
  static const textstyle12_bold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );
  static const textstyle18_regular_black = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );
  static const textstyle18_bold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );
  static const textstyle12_semibold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );
  static const textstyle12_regular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );

  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    // fontFamily: 'SegoeUI',
    color: Colors.black,
  );

  static const buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    // fontFamily: 'SegoeUI',
    color: Colors.white,
  );

  static const label = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'SegoeUI', color: Colors.black);
}
