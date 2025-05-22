import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/animation_loaders.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/checkout/checkout.dart';
import 'package:tarhanaciyasarmobil/navigation_menu.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
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
            text: 'Harika fırsatlar seni bekliyor. \nAlışverişe şimdi başla!',
            animation: ImagePaths.cartAnimation,
            showAction: true,
            actionText: 'Ürünleri Keşfet',
            onActionPressed: () => Get.off(() => NavigationMenu()));

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(ProjectSizes.pagePadding),
              child: CartItems(
                dismissable: true,
              ),
            ),
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        return controller.cartItems.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(ProjectSizes.pagePadding),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(
                      transition: Transition.fade,
                      () => const CheckoutScreen(),
                    ),
                    child: Text(
                        'Tutar ${controller.totalCartPrice.value.toStringAsFixed(2)} TL'),
                  ),
                ),
              );
      }),
    );
  }
}
