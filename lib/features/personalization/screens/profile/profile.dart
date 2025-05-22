import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/primary_header_container.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/user_controller.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: Column(
        children: [
          PrimaryHeaderContainer(
            child: Column(
              children: [
                MyAppbar(
                  title: Text(
                    'Profilim',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: ProjectColors.whiteColor),
                  ),
                  showBackArrow: true,
                  centerTitle: true,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: ProjectSizes.spaceBtwItems * 2,
                    ),
                    Obx(() => RoundedImage(
                          fit: BoxFit.fill,
                          borderRadius: 100,
                          applyImageRadius: true,
                          isNetworkImage:
                              controller.user.value.profilePicture != null
                                  ? true
                                  : false,
                          imageUrl: controller.user.value.profilePicture ??
                              ImagePaths.onboardingImage4,
                          width: 100,
                          height: 100,
                        )),
                    const SizedBox(
                      height: ProjectSizes.spaceBtwItems,
                    ),
                    TextButton(
                      onPressed: () => controller.uploadProfilePicture(),
                      child: Text(
                        'Profil Fotoğrafını Değiştir',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: ProjectColors.whiteColor),
                      ),
                    ),
                    const SizedBox(
                      height: ProjectSizes.spaceBtwItems * 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ProjectSizes.pagePadding),
            child: Column(
              children: [
                const SectionHeading(
                  showActionButton: false,
                  title: 'Profil Bilgileri',
                ),
                const SizedBox(
                  height: ProjectSizes.spaceBtwItems,
                ),
                ProfileMenu(
                  title: "Ad Soyad",
                  value: controller.user.value.fullName,
                  onTap: () => Get.to(() => const ChangeName()),
                ),
                const Divider(
                  color: ProjectColors.gray4Color,
                ),
                const SizedBox(
                  height: ProjectSizes.spaceBtwItems,
                ),
                const SectionHeading(
                  showActionButton: false,
                  title: 'Kişisel Bilgiler',
                ),
                ProfileMenu(
                  title: "Kullanıcı ID",
                  value: controller.user.value.id,
                  onTap: () {},
                  icon: Iconsax.copy,
                ),
                ProfileMenu(
                  title: "E-mail",
                  value: controller.user.value.email,
                  onTap: () {},
                ),
                ProfileMenu(
                  title: "Telefon Numarası",
                  value: controller.user.value.formattedPhoneNumber,
                  onTap: () {},
                ),
                ProfileMenu(
                  title: "Cinsiyet",
                  value: "Erkek",
                  onTap: () {},
                ),
                ProfileMenu(
                  title: "Doğum Tarihi",
                  value: "24-10-2005",
                  onTap: () {},
                ),
                const Divider(
                  color: ProjectColors.gray4Color,
                ),
                const SizedBox(
                  height: ProjectSizes.spaceBtwItems,
                ),
                TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: Text(
                      'Hesabı Sil',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: ProjectColors.redColor),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
