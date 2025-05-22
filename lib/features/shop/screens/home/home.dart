import 'package:tarhanaciyasarmobil/common/widgets/layouts/grid_layout.dart';
import 'package:tarhanaciyasarmobil/common/widgets/login_signup_widgets/custom_divider.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/banner_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/brand_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/category_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/product_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/all_brands/all_brands_screen.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/all_categories/all_categories_screen.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/all_products/all_products.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/brands/brand_products.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/brands/widgets/brand_card.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/home/widgets/home_categories.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/home/widgets/slider_with_dots.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final brandController = Get.put(BrandController());
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
      appBar: const HomeScreenAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.onInit();
          BannerController.instance.onInit();
          CategoryController.instance.onInit();
          brandController.onInit();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SliderWithDots(),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              SectionHeading(
                buttonColor: ProjectColors.greenColor,
                title: ProjectTexts.popularCategories,
                buttonTitle: ProjectTexts.viewAllProducts,
                onPressed: () => Get.to(() => const AllCategoriesScreen(),
                    transition: Transition.downToUp),
                showActionButton: true,
                textColor: ProjectColors.neutralBlackColor,
              ),
              const HomeCategories(),
              const SizedBox(height: ProjectSizes.spaceBtwItems),
              SectionHeading(
                buttonColor: ProjectColors.greenColor,
                title: ProjectTexts.featuredProducts,
                buttonTitle: ProjectTexts.viewAllProducts,
                onPressed: () => Get.to(
                    () => AllProducts(
                          futureMethod: controller.fetchAllFeaturedProducts(),
                          title: 'Öne Çıkan Ürünler',
                        ),
                    transition: Transition.downToUp),
                showActionButton: true,
                textColor: ProjectColors.neutralBlackColor,
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ProjectSizes.pagePadding),
                child: Column(
                  children: [
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const VerticalProductShimmer();
                      }
                      if (controller.featuredProducts.isEmpty) {
                        return const Center(
                          child: Text('Veri Bulunamadı'),
                        );
                      }
                      return GridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (_, index) => ProductCardVertical(
                            product: controller.featuredProducts[index]),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),

              SectionHeading(
                buttonColor: ProjectColors.greenColor,
                title: 'Popüler Markalar',
                buttonTitle: 'Tümünü Gör',
                onPressed: () => Get.to(() => const AllBrandsScreen()),
                showActionButton: true,
                textColor: ProjectColors.neutralBlackColor,
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),

// Marka listesi horizontal olabilir — örnek:
              SizedBox(
                height: 100,
                child: Obx(() {
                  final brands = brandController.featuredBrands;
                  if (brands.isEmpty) {
                    return const Center(child: Text("Marka bulunamadı"));
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: ProjectSizes.small),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: ProjectSizes.pagePadding),
                    itemCount: brands.length,
                    itemBuilder: (context, index) {
                      final brand = brands[index];
                      return SizedBox(
                          width: 200,
                          child: BrandCard(
                              brand: brand,
                              onTap: () => BrandProducts(brand: brand)));
                    },
                  );
                }),
              ),

              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),

              const CustomDivider(
                text: 'o',
                textColor: ProjectColors.gray4Color,
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              SectionHeading(
                buttonColor: ProjectColors.greenColor,
                title: 'En Çok Satan Ürünler',
                buttonTitle: ProjectTexts.viewAllProducts,
                onPressed: () => Get.to(() => AllProducts(
                      futureMethod: controller.fetchAllFeaturedProducts(),
                      title: 'En Çok Satan Ürünler',
                    )),
                showActionButton: false,
                textColor: ProjectColors.neutralBlackColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ProjectSizes.pagePadding),
                child: Column(
                  children: [
                    const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const VerticalProductShimmer();
                      }
                      if (controller.featuredProducts.isEmpty) {
                        return const Center(
                          child: Text('Veri Bulunamadı'),
                        );
                      }
                      return GridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (_, index) => ProductCardVertical(
                            product: controller.featuredProducts[index]),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
