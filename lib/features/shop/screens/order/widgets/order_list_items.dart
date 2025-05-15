import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/rounded_container.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/animation_loaders.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/order_controller.dart';
import 'package:tarhanaciyasarmobil/navigation_menu.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          /// Nothing Found Widget
          final emptyWidget = AnimationLoaderWidget(
            text: 'Whoops! No Orders Yet!',
            animation: ImagePaths.orderCompletedAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => NavigationMenu()),
          ); // TAnimationLoaderWidget

          /// Helper Function: Handle Loader, No Record, OR ERROR Message
          final response = CloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot,
            nothingFound: emptyWidget,
          );
          if (response != null) return response;

          /// Congratulations 🎉 Record found.
          final orders = snapshot.data!;

          return ListView.separated(
              itemCount: orders.length,
              shrinkWrap: true,
              separatorBuilder: (_, index) => const SizedBox(
                    height: ProjectSizes.spaceBtwItems,
                  ),
              itemBuilder: (_, index) {
                final order = orders[index];

                return RoundedContainer(
                  borderColor: ProjectColors.whiteColor,
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(ProjectSizes.spaceBtwItems),
                  showBorder: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.truck),
                          const SizedBox(
                            width: ProjectSizes.spaceBtwItems / 2,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderStatusText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: ProjectColors.blueColor,
                                          fontWeightDelta: 1),
                                ),
                                Text(order.formattedOrderDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall)
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Iconsax.arrow_right_34))
                        ],
                      ),
                      const SizedBox(
                        height: ProjectSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          const Icon(Iconsax.tag),
                          const SizedBox(
                            width: ProjectSizes.spaceBtwItems / 2,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sipariş',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                Text(order.id,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ],
                            ),
                          ),
                          const Icon(Iconsax.calendar),
                          const SizedBox(
                            width: ProjectSizes.spaceBtwItems / 2,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Teslimat Tarihi',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                Text(order.formattedDeliveryDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
        });
  }
}
