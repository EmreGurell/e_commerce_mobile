import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/common/widgets/login_signup_widgets/custom_divider.dart';
import 'package:tarhanaciyasarmobil/common/widgets/login_signup_widgets/social_media_buttons.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(
            children: [
              const SignupTitle(),
              const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
              const SignupForm(),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems * 2,
              ),
              CustomDivider(text: ProjectTexts.orSignInWith.capitalize!),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems * 2,
              ),
              const SocialMediaButtons()
            ],
          ),
        ),
      ),
    );
  }
}

class SignupTitle extends StatelessWidget {
  const SignupTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(ProjectTexts.signUpTitle,
        style: Theme.of(context).textTheme.headlineMedium);
  }
}
