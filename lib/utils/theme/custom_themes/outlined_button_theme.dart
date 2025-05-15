import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButtonTheme {
  CustomOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: ProjectColors.neutralBlackColor,
          backgroundColor: Colors.transparent,
          disabledForegroundColor: ProjectColors.grayColor,
          disabledBackgroundColor: ProjectColors.grayColor,
          side: BorderSide(
              color: ProjectColors.neutralBlackColor.withOpacity(.2)),
          padding: EdgeInsets.symmetric(
              vertical: ProjectPadding.pagePadding.value()),
          textStyle: const TextStyle(
              fontSize: 16,
              color: ProjectColors.whiteColor,
              fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  ProjectBorderRadius.ButtonRadius.value()))));

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          overlayColor: ProjectColors.grayColor,
          elevation: 0,
          foregroundColor: ProjectColors.whiteColor,
          backgroundColor: Colors.transparent,
          disabledForegroundColor: ProjectColors.grayColor,
          disabledBackgroundColor: ProjectColors.grayColor,
          side: const BorderSide(color: ProjectColors.whiteColor),
          padding: EdgeInsets.symmetric(
              vertical: ProjectPadding.pagePadding.value()),
          textStyle: const TextStyle(
              fontSize: 16,
              color: ProjectColors.whiteColor,
              fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  ProjectBorderRadius.ButtonRadius.value()))));
}
