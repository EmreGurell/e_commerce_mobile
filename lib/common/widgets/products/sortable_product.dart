import 'package:tarhanaciyasarmobil/common/widgets/layouts/grid_layout.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/all_products_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SortableProducts extends StatelessWidget {
  const SortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);

    return Column(
      children: [
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: [
            'Ad',
            'Artan Fiyat',
            'Azalan Fiyat',
            'İndirim',
            'En Yeni',
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(
          height: ProjectSizes.spaceBtwItems,
        ),
        Obx(
          () => GridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) => ProductCardVertical(
                    product: controller.products[index],
                  )),
        )
      ],
    );
  }
}
