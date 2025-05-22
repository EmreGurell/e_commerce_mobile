import 'package:tarhanaciyasarmobil/common/widgets/shimmer/category_shimmer.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/category_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text_item2.dart';

class Categories_Style2 extends StatelessWidget {
  const Categories_Style2({
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
        height: 100,
        child: Padding(
          padding: EdgeInsets.only(left: ProjectSizes.pagePadding),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              if (index == 0) {
                return VerticalImageCategoryItem2(
                  width: 140,
                  isNetworkImage: true,
                  image: category.image,
                  title: category.name,
                  textColor: ProjectColors.neutralBlackColor,
                  backgroundColor: ProjectColors.gray4Color,
                  onTap: () {},
                );
              }
              return VerticalImageCategoryItem2(
                width: 100,
                isNetworkImage: true,
                image: category.image,
                title: category.name,
                textColor: ProjectColors.neutralBlackColor,
                backgroundColor: ProjectColors.gray4Color,
                onTap: () {},
              );
            },
          ),
        ),
      );
    });
  }
}
