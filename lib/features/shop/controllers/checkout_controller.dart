import 'package:tarhanaciyasarmobil/common/widgets/list_tiles/payment_tile.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/payment_method_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
        name: 'Online Kredi/Banka Kartı', image: ImagePaths.mastercardLogo);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(ProjectSizes.pagePadding),
                child: Column(
                  children: [
                    const SectionHeading(
                        showActionButton: false, title: 'Ödeme Yöntemini Seç'),
                    const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
                    PaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Online Kredi/Banka Kartı',
                            image: ImagePaths.mastercardLogo)),
                    const SizedBox(
                      height: ProjectSizes.spaceBtwItems / 2,
                    ),
                    //   PaymentTile(
                    //     paymentMethod: PaymentMethodModel(
                    //         name: 'Online Kredi/Banka Kartı',
                    //         image: ImagePaths.mastercardLogo)),
                    // const SizedBox(
                    //   height: ProjectSizes.spaceBtwItems / 2,
                    // ),  PaymentTile(
                    //     paymentMethod: PaymentMethodModel(
                    //         name: 'Online Kredi/Banka Kartı',
                    //         image: ImagePaths.mastercardLogo)),
                    // const SizedBox(
                    //   height: ProjectSizes.spaceBtwItems / 2,
                    // ),  PaymentTile(
                    //     paymentMethod: PaymentMethodModel(
                    //         name: 'Online Kredi/Banka Kartı',
                    //         image: ImagePaths.mastercardLogo)),
                    // const SizedBox(
                    //   height: ProjectSizes.spaceBtwItems / 2,
                    // ),
                  ],
                ),
              ),
            ));
  }
}
