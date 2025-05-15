import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/icons/circular_icon.dart';
import 'package:tarhanaciyasarmobil/common/widgets/layouts/grid_layout.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/animation_loaders.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/favourites_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/home/home.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Scaffold(
      appBar: MyAppbar(
        centerTitle: false,
        title: Text(
          ProjectTexts.wishlist,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen()))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(children: [
            Obx(
              () => FutureBuilder(
                  future: controller.favoriteProducts(),
                  builder: (context, snapshot) {
                    final emptyWidget = AnimationLoaderWidget(
                        text: 'İstek Listesi boş',
                        animation: ImagePaths.docerAnimation,
                        showAction: true);
                    const loader = VerticalProductShimmer(
                      itemCount: 6,
                    );
                    final widget = CloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: emptyWidget);
                    if (widget != null) return widget;
                    final products = snapshot.data!;
                    return GridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) =>
                            ProductCardVertical(product: products[index]));
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
