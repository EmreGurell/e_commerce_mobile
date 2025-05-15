import 'package:tarhanaciyasarmobil/common/widgets/icons/circular_icon.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/shimmer_effect_loader.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/user_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileListTile extends StatelessWidget {
  const UserProfileListTile({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ListTile(
      leading: const CircularIcon(icon: Iconsax.user),
      title: Obx(() {
        if (controller.profileLoading.value) {
          return const ShimmerEffect(
            width: 80,
            height: 15,
          );
        }
        return Text(
          controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: ProjectColors.whiteColor),
        );
      }),
      subtitle: Obx(() {
        if (controller.profileLoading.value) {
          return const ShimmerEffect(
            width: 80,
            height: 15,
          );
        }
        return Text(
          controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .apply(color: ProjectColors.whiteColor),
        );
      }),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: ProjectColors.whiteColor,
          )),
    );
  }
}
