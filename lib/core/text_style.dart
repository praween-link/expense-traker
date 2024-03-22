import 'package:flutter/material.dart';

import 'color/app_colors.dart';

class TextStyles {
  /// App Bar

  static TextStyle appBarTitle() => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.1,
      );

  /// Button
  static TextStyle buttonText({Color? color}) => TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors.white);

  ///

  static TextStyle normalText(
          {Color? color, bool isGrey = false, FontWeight? fontWeight}) =>
      TextStyle(
          fontWeight: fontWeight,
          fontSize: 14,
          color: color ?? AppColors.textDark);
  static TextStyle mediumText(
          {Color? color, bool isGrey = false, FontWeight? fontWeight}) =>
      TextStyle(
          fontWeight: fontWeight,
          fontSize: 16,
          color: color ?? AppColors.textDark);
  static TextStyle largText(
          {Color? color,
          bool isGrey = false,
          FontWeight? fontWeight,
          double? fontSize}) =>
      TextStyle(
          fontWeight: fontWeight,
          fontSize: 18,
          color: color ?? AppColors.textDark);

  static TextStyle smallText(
          {Color? color, FontWeight? fontWeight, bool isGrey = false}) =>
      TextStyle(
          fontWeight: fontWeight,
          fontSize: 12,
          color: color ?? AppColors.textDark);
  static TextStyle verySmallText(
          {Color? color,
          bool isGrey = false,
          FontStyle? fontStyle,
          double? height}) =>
      TextStyle(
        fontSize: 10,
        color: color ?? AppColors.textDark,
        fontStyle: fontStyle,
        height: height,
      );
}
