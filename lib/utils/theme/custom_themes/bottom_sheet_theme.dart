import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';

import 'package:flutter/material.dart';

class CustomBottomSheetTheme {
  CustomBottomSheetTheme._();

  static final lightBottomSheetThemeTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: ProjectColors.scaffoldLight,
      modalBackgroundColor: ProjectColors.scaffoldLight,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              ProjectBorderRadius.ImageAndCardRadius.value())));

  static final darkBottomSheetThemeTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: ProjectColors.neutralBlackColor,
      modalBackgroundColor: ProjectColors.neutralBlackColor,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              ProjectBorderRadius.ImageAndCardRadius.value())));
}
