import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomChipTheme {
  static ChipThemeData lightChipThemeData = ChipThemeData(
    disabledColor: ProjectColors.gray3Color.withOpacity(.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: ProjectColors.green2Color,
    padding: const EdgeInsets.symmetric(horizontal: 2),
    showCheckmark: false,
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
