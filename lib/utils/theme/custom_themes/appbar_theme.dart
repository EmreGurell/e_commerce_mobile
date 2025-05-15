import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';

import 'package:flutter/material.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: ProjectColors.whiteColor, size: 24),
      actionsIconTheme:
          IconThemeData(color: ProjectColors.neutralBlackColor, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ProjectColors.neutralBlackColor));

  static const darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme:
          IconThemeData(color: ProjectColors.neutralBlackColor, size: 24),
      actionsIconTheme:
          IconThemeData(color: ProjectColors.whiteColor, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ProjectColors.whiteColor));
}
