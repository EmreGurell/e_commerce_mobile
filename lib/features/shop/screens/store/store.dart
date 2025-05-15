import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/rounded_container.dart';
import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/search_container.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/tabbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/layouts/grid_layout.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/brand_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/category_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/store/widgets/category_tab.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    if (categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    final isDark = HelperFuctions.isDarkMode(context);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: MyAppbar(
          centerTitle: false,
          title: Text(ProjectTexts.storeAppBarTitle,
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [ShoppingCartCounter()],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: isDark
                    ? ProjectColors.neutralBlackColor
                    : ProjectColors.whiteColor,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(ProjectSizes.pagePadding),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: ProjectSizes.spaceBtwItems),
                      const SearchBarContainer(
                        padding: EdgeInsets.zero,
                        showBorder: true,
                        showBackground: false,
                        text: ProjectTexts.search,
                        icon: Iconsax.search_normal,
                      ),
                      const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
                      SectionHeading(
                        showActionButton: true,
                        title: 'Featured Products',
                        buttonTitle: 'View All',
                        onPressed: () {},
                      ),
                      const SizedBox(height: ProjectSizes.spaceBtwItems / 1.5),
                      GridLayout(
                        itemCount: 4,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: RoundedContainer(
                              padding: const EdgeInsets.all(ProjectSizes.IconS),
                              showBorder: true,
                              backgroundColor: Colors.transparent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    padding: const EdgeInsets.all(
                                        ProjectSizes.IconS),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? ProjectColors.neutralBlackColor
                                          : ProjectColors.whiteColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Image(
                                      image: AssetImage(ImagePaths.banner1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                bottom: MyTabBar(
                  tabs: categories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories
                .map((category) => CategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
