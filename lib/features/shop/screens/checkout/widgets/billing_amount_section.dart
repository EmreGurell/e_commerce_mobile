import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;

    return Column(
      children: [
        /// SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ara Toplam', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$$subTotal', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Kargo Ücreti', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${PricingCalculator.calculateShippingCost(subTotal, 'TR')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Vergi Ücreti', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${PricingCalculator.calculateTax(subTotal, 'TR')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sipariş Toplamı',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${PricingCalculator.calculateTotalPrice(subTotal, 'TR')}',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
      ],
    );
  }
}
