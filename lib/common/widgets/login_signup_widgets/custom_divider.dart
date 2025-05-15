import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = HelperFuctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          // Flexible yerine Expanded kullanıldı
          child: Divider(
            color: isDark ? ProjectColors.grayColor : ProjectColors.gray4Color,
            thickness: .5,
            indent: 30,
            endIndent: 30,
          ),
        ),
        Text(
          ProjectTexts.orSignInWith.capitalize!,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Expanded(
          // Flexible yerine Expanded kullanıldı
          child: Divider(
            color: isDark ? ProjectColors.grayColor : ProjectColors.gray4Color,
            thickness: .5,
            indent: 30,
            endIndent: 30,
          ),
        ),
      ],
    );
  }
}
