import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black.withOpacity(.5)),
  );
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: ProjectColors.whiteColor),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: ProjectColors.whiteColor),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ProjectColors.whiteColor),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ProjectColors.whiteColor),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ProjectColors.whiteColor),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ProjectColors.whiteColor),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ProjectColors.whiteColor),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: ProjectColors.whiteColor),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ProjectColors.whiteColor.withOpacity(.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: ProjectColors.whiteColor),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: ProjectColors.whiteColor.withOpacity(.5)),
  );
}
