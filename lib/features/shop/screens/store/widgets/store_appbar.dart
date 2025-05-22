import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/search_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/store/widgets/search_field.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';

class StoreScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StoreScreenAppBar({super.key, required this.controller});
  final MySearchController controller;
  @override
  Size get preferredSize => const Size.fromHeight(132);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAppbar(
          centerTitle: true,
          showBackArrow: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mağaza'.toUpperCase(),
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
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
          child: SearchField(controller: controller),
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
      ],
    );
  }
}
