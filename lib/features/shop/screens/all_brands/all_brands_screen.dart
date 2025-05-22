import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/layouts/grid_layout.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/brand_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/brands/brand_products.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/brands/widgets/brand_card.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      appBar: MyAppbar(
          title: Text('Markalar',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(fontFamily: 'Poppins')),
          showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(
            children: [
              GridLayout(
                  mainAxisExtent: 80,
                  crossAxisCount: 2,
                  itemCount: controller.allBrands.length,
                  itemBuilder: (context, index) => BrandCard(
                      brand: controller.allBrands[index],
                      onTap: () => Get.to(() =>
                          BrandProducts(brand: controller.allBrands[index]))))
            ],
          ),
        ),
      ),
    );
  }
}
