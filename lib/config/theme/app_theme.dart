import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final appTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.kPrimaryColor),
    primaryColor: AppColor.kPrimaryColor,
    scaffoldBackgroundColor: AppColor.kPrimaryColor,
    listTileTheme: const ListTileThemeData(textColor: AppColor.kSecondColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.kDarkColor,
            foregroundColor: AppColor.kLightColor)),
    appBarTheme: const AppBarTheme(
        shadowColor: AppColor.kPrimaryColor,
        foregroundColor: AppColor.kDarkColor,
        backgroundColor: AppColor.kPrimaryColor,
        surfaceTintColor: Colors.black),
  );
}
