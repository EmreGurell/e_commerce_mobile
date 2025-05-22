import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/rounded_container.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/checkout_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final bool isDark = HelperFuctions.isDarkMode(context);
    return Column(
      children: [
        SectionHeading(buttonColor: Theme.of(context).primaryColor,
            showActionButton: true,
            title: 'Ödeme Yöntemi',
            buttonTitle: 'Değiştir',
            onPressed: () => controller.selectPaymentMethod(context)),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              RoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: isDark
                    ? ProjectColors.gray4Color
                    : ProjectColors.whiteColor,
                padding: const EdgeInsets.all(ProjectSizes.small),
                child: Image(
                  image:
                      AssetImage(controller.selectedPaymentMethod.value.image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: ProjectSizes.spaceBtwItems / 2,
              ),
              Text(controller.selectedPaymentMethod.value.name)
            ],
          ),
        )
      ],
    );
  }
}
