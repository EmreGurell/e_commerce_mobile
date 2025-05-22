import 'package:tarhanaciyasarmobil/features/authentication/screens/login/login.dart';
import 'package:tarhanaciyasarmobil/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.email});
  final String image, title, subtitle;

  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(
            children: [
              // Image
              Image(
                image: AssetImage(image),
                width: HelperFuctions.screenWidth(context) * .6,
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems * 2),

              // Title & Subtitle
              Text(
                email,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems * 2),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text(ProjectTexts.done),
                ),
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),
              TextButton(
                onPressed: () => ForgetPasswordController.instance
                    .resendPasswordResetEmail(email),
                child: const Text(ProjectTexts.resendEmail),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
