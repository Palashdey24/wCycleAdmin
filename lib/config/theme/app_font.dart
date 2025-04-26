import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';

class AppFont {
  static TextStyle textLarge(BuildContext context) {
    double height = DeviceSize.getDeviceHeight(context);
    final textTheme = Theme.of(context).textTheme;

    final double fontSize = height <= 1000 ? 22 : 30;

    return textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColor.kSixthColor,
        fontSize: fontSize);
  }

  static TextStyle textMedium(BuildContext context) {
    double height = DeviceSize.getDeviceHeight(context);
    final textTheme = Theme.of(context).textTheme;

    final double fontSize = height <= 1000 ? 12 : 16;

    return textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColor.kSecondColor,
        fontSize: fontSize);
  }

  static TextStyle textSmall(BuildContext context) {
    double height = DeviceSize.getDeviceHeight(context);
    final textTheme = Theme.of(context).textTheme;

    final double fontSize = height <= 1000 ? 10 : 12;

    return textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColor.kLightColor,
        fontSize: fontSize);
  }

  static TextStyle tittleStyleSecond(BuildContext context) {
    double height = DeviceSize.getDeviceHeight(context);

    final double fontSize = height <= 1000 ? 20 : 25;

    return GoogleFonts.rubikVinyl(
        color: AppColor.kSixthColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);
  }

  static TextStyle tittleStyleFirst(BuildContext context) {
    double height = DeviceSize.getDeviceHeight(context);

    final double fontSize = 25 * (height / 400);

    return GoogleFonts.pattaya(
        color: AppColor.kFifthColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);
  }
}
