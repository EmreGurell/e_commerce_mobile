import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/image_text_widgets/vertical_image_text_item2.dart';
import 'package:tarhanaciyasarmobil/common/widgets/layouts/grid_layout.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/category_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/all_categories/category_products.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Scaffold(
      appBar: MyAppbar(
          title: Text('Kategoriler',
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
                  mainAxisExtent: 90,
                  crossAxisCount: 2,
                  itemCount: controller.allCategories.length,
                  itemBuilder: (context, index) {
                    final category = controller.allCategories[index];
                    return VerticalImageCategoryItem2(
                        onTap: () =>
                            Get.to(() => CategoryProducts(category: category)),
                        image: category.image,
                        title: category.name,
                        width: double.infinity);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
