import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/images_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';

class ProductImageSlider extends StatelessWidget {
  final ProductModel product;
  ProductImageSlider({Key? key, required this.product}) : super(key: key);

  final _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    if (controller.selectedProductImage.value.isEmpty && images.isNotEmpty) {
      controller.selectedProductImage.value = images[0];
    }

    return SizedBox(
      height: 550,
      child: Stack(
        children: [
          // Ana büyük resim carousel slider
          Positioned.fill(
            child: Obx(() {
              final currentIndex =
                  images.indexOf(controller.selectedProductImage.value);

              return CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 550,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    controller.selectedProductImage.value = images[index];
                  },
                ),
                items: images.map((imageUrl) {
                  return GestureDetector(
                    onTap: () => controller.showEnlargedImage(imageUrl),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                      progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: Theme.of(context).primaryColor,
                      ),
                      errorWidget: (_, __, ___) => const Icon(Icons.error),
                    ),
                  );
                }).toList(),
              );
            }),
          ),

          // Sol üst köşeye küçük resimler sütunu
          Positioned(
            top: ProjectSizes.pagePadding,
            left: ProjectSizes.pagePadding,
            bottom: ProjectSizes.pagePadding,
            width: 75, // Küçük resimler için genişlik
            child: Obx(() {
              final selectedImage = controller.selectedProductImage.value;
              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: images.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
                itemBuilder: (_, index) {
                  final image = images[index];
                  final isSelected = selectedImage == image;
                  return RoundedImage(
                    applyImageRadius: true,
                    borderRadius: 5,
                    onPressed: () {
                      controller.selectedProductImage.value = image;
                      _carouselController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    isNetworkImage: true,
                    imageUrl: image,
                    width: 70, // Küçük thumbnail boyutu
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 1.5,
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
