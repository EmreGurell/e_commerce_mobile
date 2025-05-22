import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/theme/custom_themes/appbar_theme.dart';
import 'package:tarhanaciyasarmobil/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:tarhanaciyasarmobil/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:tarhanaciyasarmobil/utils/theme/custom_themes/chip_theme.dart';
import 'package:tarhanaciyasarmobil/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:tarhanaciyasarmobil/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:tarhanaciyasarmobil/utils/theme/custom_themes/text_field_theme.dart';
import 'package:tarhanaciyasarmobil/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.light(),
      useMaterial3: true,
      fontFamily: 'Nunito',
      brightness: Brightness.light,
      primaryColor: ProjectColors.greenColor,
      scaffoldBackgroundColor: ProjectColors.scaffoldLight,
      textTheme: CustomTextTheme.lightTextTheme,
      chipTheme: CustomChipTheme.lightChipThemeData,
      appBarTheme: CustomAppBarTheme.lightAppBarTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: CustomTextFieldTheme.lightTextFieldTheme,
      bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetThemeTheme,
      checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
      outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: ProjectColors.neutralBlackColor,
      textTheme: CustomTextTheme.darkTextTheme,
      chipTheme: CustomChipTheme.darkChipThemeData,
      appBarTheme: CustomAppBarTheme.darkAppBarTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: CustomTextFieldTheme.darkTextFieldTheme,
      bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetThemeTheme,
      checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
      outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme);
}
