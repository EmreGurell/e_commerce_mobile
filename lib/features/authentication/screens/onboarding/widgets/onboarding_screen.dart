import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    this.subtitle,
    this.title,
  });
  final subtitle, title, image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ProjectPadding.pagePadding.value()),
      child: Column(
        children: [
          Image(
              width: HelperFuctions.screenWidth(context) * .8,
              height: HelperFuctions.screenHeight(context) * .6,
              image: AssetImage(image)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: ProjectSizes.spaceBtwItems),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
