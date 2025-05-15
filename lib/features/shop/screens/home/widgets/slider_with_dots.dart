import 'package:carousel_slider/carousel_slider.dart';
import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/circular_container.dart';
import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/shimmer_effect_loader.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/banner_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderWithDots extends StatelessWidget {
  const SliderWithDots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // HomeController'ı Get.put() ile başlatıyoruz
    final controller = Get.put(BannerController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const ShimmerEffect(width: double.infinity, height: 190);
      }
      if (controller.banners.isEmpty) {
        return const Center(
          child: Text('Veri Bulunamadı'),
        );
      } else {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
                viewportFraction: 1,
                height: 200,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                autoPlay: true,
              ),
              items: controller.banners.map((banner) {
                return RoundedImage(
                  imageUrl: banner.imageUrl,
                  isNetworkImage: true,
                  width: double.infinity,
                  height: 200,
                  borderRadius: ProjectSizes.IconL,
                  fit: BoxFit.cover,
                  applyImageRadius: true,
                  onPressed: () => Get.toNamed(banner.targetScreen),
                  padding: const EdgeInsets.symmetric(
                      horizontal: ProjectSizes.spaceBtwItems),
                );
              }).toList(),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.banners.length,
                  (index) => CircularContainer(
                    width: 25,
                    height: 3,
                    opacity: .8,
                    backgroundColor:
                        controller.carouselCurrentIndex.value == index
                            ? ProjectColors.finance2Color
                            : ProjectColors.gray4Color,
                    margin: const EdgeInsets.only(right: ProjectSizes.small),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
