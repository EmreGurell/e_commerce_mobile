import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldTheme {
  CustomTextFieldTheme._();

  static InputDecorationTheme lightTextFieldTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: ProjectColors.grayColor,
    suffixIconColor: ProjectColors.grayColor,
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    hintStyle: const TextStyle()
        .copyWith(fontSize: 14, color: ProjectColors.neutralBlackColor),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.black.withOpacity(.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide: const BorderSide(width: 1, color: ProjectColors.grayColor)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide: const BorderSide(width: 1, color: ProjectColors.grayColor)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide:
            const BorderSide(width: 1, color: ProjectColors.neutralBlackColor)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide: const BorderSide(width: 1, color: ProjectColors.redColor)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide: const BorderSide(width: 1, color: ProjectColors.red2Color)),
  );
  static InputDecorationTheme darkTextFieldTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: ProjectColors.whiteColor,
    suffixIconColor: ProjectColors.whiteColor,
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
    hintStyle: const TextStyle()
        .copyWith(fontSize: 14, color: ProjectColors.whiteColor),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: ProjectColors.whiteColor),
    border: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide:
            const BorderSide(width: 1, color: ProjectColors.whiteColor)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide:
            const BorderSide(width: 1, color: ProjectColors.whiteColor)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide:
            const BorderSide(width: 1, color: ProjectColors.whiteColor)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide: const BorderSide(width: 1, color: ProjectColors.redColor)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius:
            BorderRadius.circular(ProjectBorderRadius.InputFieldRadius.value()),
        borderSide: const BorderSide(width: 1, color: ProjectColors.red2Color)),
  );
}
