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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(
            children: [
              CartItems(
                showAddRemoveButtons: false,
              ),
              SizedBox(height: ProjectSizes.spaceBtwItems * 2),
              PromoCode(),
              SizedBox(height: ProjectSizes.spaceBtwItems * 2),
              RoundedContainer(
                backgroundColor: Colors.transparent,
                showBorder: true,
                padding: EdgeInsets.all(ProjectSizes.small * 2),
                child: Column(
                  children: [
                    BillingAmountSection(),
                    Divider(),
                    SizedBox(
                      height: ProjectSizes.spaceBtwItems,
                    ),
                    BillingPaymentSection(),
                    SizedBox(
                      height: ProjectSizes.spaceBtwItems,
                    ),
                    Divider(),
                    SizedBox(
                      height: ProjectSizes.spaceBtwItems,
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
                'Tutar \$${PricingCalculator.calculateTotalPrice(subTotal, 'TR')}')),
      ),
    );
  }
}
