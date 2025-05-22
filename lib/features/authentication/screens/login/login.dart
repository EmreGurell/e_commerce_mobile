import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/common/styles/spacing_styles.dart';
import 'package:tarhanaciyasarmobil/common/widgets/login_signup_widgets/custom_divider.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/login/widgets/login_form.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/login/widgets/login_header.dart';
import 'package:tarhanaciyasarmobil/common/widgets/login_signup_widgets/social_media_buttons.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/texts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyles.paddingWithAppbarHeight,
          child: Column(
            children: [
              const LoginHeader(),
              const LoginForm(),
              CustomDivider(text: ProjectTexts.orSignInWith.capitalize!),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              const SocialMediaButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
