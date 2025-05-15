import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/animation_loaders.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/checkout/checkout.dart';
import 'package:tarhanaciyasarmobil/navigation_menu.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: MyAppbar(
        showBackArrow: true,
        title:
            Text('Sepetim', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Obx(() {
        final emptyWidget = AnimationLoaderWidget(
            text: 'Hay Aksi! Sepetiniz BOŞ',
            animation: ImagePaths.cartAnimation,
            showAction: true,
            actionText: 'Alışverişe başla',
            onActionPressed: () => Get.off(() => NavigationMenu()));

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(ProjectSizes.pagePadding),
              child: CartItems(),
            ),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? SizedBox()
          : Row(children: [
              SizedBox(
                  width: DeviceUtility.getScreenWidth(context) * .7,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const CheckoutScreen()),
                    child: Obx(() =>
                        Text('Tutar \$${controller.totalCartPrice.value}')),
                  ))
            ]),
    );
  }
}
