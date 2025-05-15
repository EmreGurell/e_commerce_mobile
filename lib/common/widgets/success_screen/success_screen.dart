import 'package:tarhanaciyasarmobil/common/styles/spacing_styles.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onPressed});

  final String image, title, subtitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyles.paddingWithAppbarHeight * 2,
          child: Column(
            children: [
              Image(
                image: AssetImage(image),
                width: HelperFuctions.screenWidth(context) * .6,
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems * 2,
              ),

              //Title & Subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              Text(subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems * 2,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: onPressed,
                    child: const Text(ProjectTexts.continueText)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
