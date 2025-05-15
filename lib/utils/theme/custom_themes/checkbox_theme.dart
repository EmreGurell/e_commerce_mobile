import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomCheckboxTheme {
  CustomCheckboxTheme._();

  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            ProjectBorderRadius.InputFieldRadius.value())),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProjectColors.whiteColor;
      } else {
        return ProjectColors.neutralBlackColor;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProjectColors.blueColor;
      } else {
        return Colors.transparent;
      }
    }),
  );

  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            ProjectBorderRadius.InputFieldRadius.value())),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProjectColors.whiteColor;
      } else {
        return ProjectColors.neutralBlackColor;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProjectColors.blueColor;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
