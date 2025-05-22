import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/search_container.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:tarhanaciyasarmobil/navigation_menu.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';

import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/image_paths.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(132);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAppbar(
          leading: RoundedImage(
              imageUrl: ImagePaths.logoLight,
              isNetworkImage: false,
              width: 55,
              height: 55),
          centerTitle: true,
          showBackArrow: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tarhanacı Yaşar'.toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall!.apply(
                    fontFamily: 'Poppins',
                    color: ProjectColors.neutralBlackColor),
              ),
            ],
          ),
          actions: const [
            ShoppingCartCounter(iconColor: ProjectColors.neutralBlackColor),
          ],
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
        SearchBarContainer(
          onTap: () {
            final navController = Get.find<NavigationController>();
            navController.selectedIndex.value = 1;
          },
          text: ProjectTexts.search,
          icon: Iconsax.search_normal,
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
      ],
    );
  }
}
