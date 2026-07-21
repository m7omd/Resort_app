import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/app_colors.dart';

class ThemeManger {
  static ThemeData appTheme() {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Color(0xffF5F5F5),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: AppColors.black),
        headlineMedium: TextStyle(color: AppColors.iconGrey),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.iconGrey),
        actionsIconTheme: IconThemeData(color: AppColors.iconGrey),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
      ),
      // fontFamily: AppStrings.englishFont,
      inputDecorationTheme: InputDecorationTheme(
        border: buildBorder(),
        enabledBorder: buildBorder(),
        disabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        errorBorder: buildBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 5.0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, color: AppColors.primary, fontSize: 10),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightGrey,
      ),
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.primary,
        primary: AppColors.primary,
        brightness: Brightness.light,
        onPrimary: Colors.white,
        onSecondary: Colors.white,

        primaryContainer: AppColors.lightGrey,
        error: const Color(0xffE02F2F),
        onError: Colors.white,
        background: const Color(0xffF5F5F5),
        onBackground: AppColors.black,
        surface: Colors.white,
        onSurface: AppColors.black,
      ),
    );
  }

  static ThemeData blackTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.primaryDark,
      textTheme: TextTheme(
        bodyMedium: const TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: AppColors.iconGrey),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primaryDark,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: buildBorder(),
        enabledBorder: buildBorder(),
        disabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        errorBorder: buildBorder(),
      ),
      primaryColor: AppColors.primary,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 5.0,
        backgroundColor: const Color(0xff1f1a2a),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightGrey,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.primary,
        primary: AppColors.primary,
        brightness: Brightness.light,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        primaryContainer: AppColors.lightGrey,
        error: const Color(0xffE02F2F),
        onError: Colors.white,
        background: AppColors.primaryDark,
        onBackground: Colors.white,
        surface: AppColors.primaryDark,
        onSurface: Colors.white,
      ),
    );
  }
}

///////////////////////////////////////////////////

OutlineInputBorder buildBorder() {
  return const OutlineInputBorder(borderSide: BorderSide(color: Colors.white));
}

OutlineInputBorder buildMainBuild() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white, width: 1),
    borderRadius: BorderRadius.circular(8),
  );
}

OutlineInputBorder buildErrorBorder() {
  return OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(8));
}

TextStyle mainTFFTextStyle(context, {Color? color, bool isEnabled = true}) =>
    Theme.of(context).textTheme.bodyMedium!.copyWith(
      // fontFamily: AppStrings.arabicFont,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.black,
      fontSize: 15,
    );

TextStyle hintTFFTextStyle({Color? color}) =>
    TextStyle(color: color ?? AppColors.iconGrey, fontSize: 14, fontWeight: FontWeight.w600);

TextStyle labelTFFTextStyle(bool isFloating) =>
    TextStyle(color: AppColors.grey, fontWeight: FontWeight.w600, fontSize: 16);
