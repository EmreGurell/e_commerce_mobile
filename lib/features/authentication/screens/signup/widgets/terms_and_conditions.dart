import 'package:tarhanaciyasarmobil/features/authentication/controllers/signup/signup_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionCheckbox extends StatelessWidget {
  const TermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final isDark = HelperFuctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(top: ProjectSizes.spaceBtwItems),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Metni düzgün hizalamak için
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value)),
          ),

          /// Wrap kullanarak metnin taşmasını ve alt satıra geçmesini sağlıyoruz
          Expanded(
            child: Wrap(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${ProjectTexts.privacyPolicy} ',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: isDark
                                ? ProjectColors.whiteColor
                                : ProjectColors.financeColor,
                            decoration: TextDecoration.underline,
                            decorationColor: isDark
                                ? ProjectColors.whiteColor
                                : ProjectColors.financeColor),
                      ),
                      TextSpan(
                        text: '${ProjectTexts.and} ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: '${ProjectTexts.termsOfUse} ',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: isDark
                                ? ProjectColors.whiteColor
                                : ProjectColors.financeColor,
                            decoration: TextDecoration.underline,
                            decorationColor: isDark
                                ? ProjectColors.whiteColor
                                : ProjectColors.financeColor),
                      ),
                      TextSpan(
                        text: '${ProjectTexts.agreeTo} ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
