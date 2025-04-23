import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/helper/sign_helper.dart';

class AppFont {
  static TextStyle textLarge(BuildContext context) {
    double width = apis.deviceWidth(context);
    final textTheme = Theme.of(context).textTheme;

    final double fontSize = width <= 400 ? 22 : 30;

    return textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColor.kSixthColor,
        fontSize: fontSize);
  }

  static TextStyle textMedium(BuildContext context) {
    double width = apis.deviceWidth(context);
    final textTheme = Theme.of(context).textTheme;

    final double fontSize = width <= 400 ? 12 : 16;

    return textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColor.kSecondColor,
        fontSize: fontSize);
  }

  static TextStyle textSmall(BuildContext context) {
    double width = apis.deviceWidth(context);
    final textTheme = Theme.of(context).textTheme;

    final double fontSize = width <= 400 ? 10 : 12;

    return textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColor.kLightColor,
        fontSize: fontSize);
  }

  static TextStyle tittleStyleSecond(BuildContext context) {
    double width = apis.deviceWidth(context);

    final double fontSize = width <= 400 ? 20 : 25;

    return GoogleFonts.rubikVinyl(
        color: AppColor.kSixthColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);
  }

  static TextStyle tittleStyleFirst(BuildContext context) {
    double width = apis.deviceWidth(context);

    final double fontSize = 25 * (width / 400);

    return GoogleFonts.pattaya(
        color: AppColor.kFifthColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);
  }
}
