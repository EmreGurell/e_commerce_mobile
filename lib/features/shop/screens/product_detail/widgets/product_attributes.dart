import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/common/widgets/chips/custom_choice_chip.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/variation_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: product.productAttributes!
            .map((attribute) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attribute.name!.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Obx(
                      () => Wrap(
                          spacing: 4,
                          children: attribute.values!.map((attributeValue) {
                            final isSelected =
                                controller.selectedAttributes[attribute.name] ==
                                    attributeValue;
                            final available = controller
                                .getAttributesAvailabilityInVariation(
                                    product.productVariations!, attribute.name!)
                                .contains(attributeValue);
                            return MyChoiceChip(
                                text: attributeValue.toUpperCase(),
                                selected: isSelected,
                                onSelected: available
                                    ? (selected) {
                                        if (selected && available) {
                                          controller.onAttributeSelected(
                                              product,
                                              attribute.name ?? '',
                                              attributeValue);
                                        }
                                      }
                                    : null);
                          }).toList()),
                    )
                  ],
                ))
            .toList());
  }
}
