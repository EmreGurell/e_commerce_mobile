import 'package:tarhanaciyasarmobil/common/widgets/icons/circular_icon.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/favourites_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    super.key,
    required this.productId,
  });
  final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => CircularIcon(
          color:
              controller.isFavourite(productId) ? ProjectColors.redColor : null,
          icon: controller.isFavourite(productId)
              ? Iconsax.heart5
              : Iconsax.heart,
          onPressed: () => controller.toggleFavoriteProduct(productId)),
    );
  }
}
