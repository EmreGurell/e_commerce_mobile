import 'package:lottie/lottie.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(
            children: [
              //Image
              Lottie.asset(ImagePaths.deliveredEmail,

                width: HelperFuctions.screenWidth(context) * .6,
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems * 2,
              ),

              //Title & Subtitle
              Text(ProjectTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              Text(email ?? " ",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              Text(ProjectTexts.confirmEmailSubtitle, textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems*3,
              ),

              //Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.checkEmailVerificationStatus(),
                    child: const Text(ProjectTexts.continueText)),
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: Text(
                    ProjectTexts.resendEmail,
                    style: Theme.of(context).textTheme.bodySmall,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
