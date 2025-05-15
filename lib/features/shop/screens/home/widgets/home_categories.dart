import 'package:tarhanaciyasarmobil/common/widgets/image_text_widgets/vertical_image_text_item.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/category_shimmer.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/category_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return const CategoryShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'Veri Bulunamadı!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: ProjectColors.whiteColor),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return VerticalImageCategoryItem(
              isNetworkImage: true,
              image: category.image,
              title: category.name,
              textColor: ProjectColors.whiteColor,
              backgroundColor: ProjectColors.whiteColor,
              onTap: () {},
            );
          },
        ),
      );
    });
  }
}
