import 'package:tarhanaciyasarmobil/features/authentication/controllers/login/login_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: ProjectColors.gray4Color,
              ),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () => controller.googleSignIn(),
              icon: Image(
                width: ProjectSizes.IconM,
                height: ProjectSizes.IconM,
                image: AssetImage(ImagePaths.googleIcon),
              )),
        ),
        const SizedBox(
          width: ProjectSizes.spaceBtwItems,
        ),
    /*    Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: ProjectColors.gray4Color,
              ),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: Image(
                width: ProjectSizes.IconM,
                height: ProjectSizes.IconM,
                image: AssetImage(ImagePaths.facebookIcon),
              )),
        )*/
      ],
    );
  }
}
