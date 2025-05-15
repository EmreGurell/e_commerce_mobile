import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/shimmer_effect_loader.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/user_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return MyAppbar(
      centerTitle: false,
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (controller.profileLoading.value) {
              return const ShimmerEffect(width: 80, height: 15);
            }
            return Text(controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: ProjectColors.whiteColor));
          }),
        ],
      ),
      actions: [
        ShoppingCartCounter(
          iconColor: ProjectColors.whiteColor,
        )
      ],
    );
  }
}
