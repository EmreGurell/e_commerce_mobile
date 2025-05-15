import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomChipTheme {
  static ChipThemeData lightChipThemeData = ChipThemeData(
    disabledColor: ProjectColors.grayColor.withOpacity(.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: ProjectColors.blueColor,
    padding: EdgeInsets.all(ProjectBorderRadius.ImageAndCardRadius.value()),
    checkmarkColor: ProjectColors.whiteColor,
  );
  static ChipThemeData darkChipThemeData = ChipThemeData(
    disabledColor: ProjectColors.grayColor,
    labelStyle: const TextStyle(color: ProjectColors.whiteColor),
    selectedColor: ProjectColors.blueColor,
    padding: EdgeInsets.all(ProjectBorderRadius.ImageAndCardRadius.value()),
    checkmarkColor: ProjectColors.whiteColor,
  );
}
