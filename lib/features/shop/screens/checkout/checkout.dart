import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/rounded_container.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/cart/coupon_code.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/order_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = PricingCalculator.calculateTotalPrice(subTotal, 'TR');
    return Scaffold(
      appBar: MyAppbar(
        showBackArrow: true,
        title: Text(
          'Sipariş Önizlemesi',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(
            children: [
              const RoundedContainer(
                  backgroundColor: Colors.transparent,
                  height: 175,
                  child: CartItems(
                    dismissable: false,
                    showAddRemoveButtons: false,
                  )),
              const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
              const PromoCode(),
              const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
              RoundedContainer(
                borderColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.transparent,
                showBorder: true,
                padding: const EdgeInsets.only(
                    top: ProjectSizes.small * 2,
                    left: ProjectSizes.small * 2,
                    right: ProjectSizes.small * 2),
                child: const Column(
                  children: [
                    BillingAmountSection(),
                    Divider(),
                    SizedBox(
                      height: ProjectSizes.spaceBtwItems / 4,
                    ),
                    BillingPaymentSection(),
                    SizedBox(
                      height: ProjectSizes.spaceBtwItems / 2,
                    ),
                    Divider(),
                    SizedBox(
                      height: ProjectSizes.spaceBtwItems / 2,
                    ),
                    BillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ProjectSizes.pagePadding),
        child: ElevatedButton(
            onPressed: subTotal > 0
                ? () => orderController.processOrder(totalAmount)
                : () => Loaders.warningSnackBar(
                    title: 'Sepet Boş',
                    message:
                        'Sipariş verebilmek için ürünleri sepetinize ekleyiniz.'),
            child: Text(
                'Tutar ${PricingCalculator.calculateTotalPrice(subTotal, 'TR')} TL')),
      ),
    );
  }
}
