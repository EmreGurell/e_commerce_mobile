import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: ProjectColors.whiteColor,
          backgroundColor: ProjectColors.blueColor,
          disabledForegroundColor: ProjectColors.grayColor,
          disabledBackgroundColor: ProjectColors.grayColor,
          side: const BorderSide(color: ProjectColors.blueColor),
          padding: EdgeInsets.symmetric(
              vertical: ProjectPadding.pagePadding.value()),
          textStyle: const TextStyle(
              fontSize: 16,
              color: ProjectColors.whiteColor,
              fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  ProjectBorderRadius.ButtonRadius.value()))));

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: ProjectColors.whiteColor,
          backgroundColor: ProjectColors.blueColor,
          disabledForegroundColor: ProjectColors.grayColor,
          disabledBackgroundColor: ProjectColors.grayColor,
          side: const BorderSide(color: ProjectColors.blueColor),
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
