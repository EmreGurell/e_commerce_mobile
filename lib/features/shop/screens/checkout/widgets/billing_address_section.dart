import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/address_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../common/custom_shapes/containers/rounded_container.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
            buttonColor: Theme.of(context).primaryColor,
            showActionButton: true,
            title: 'Teslimat Adresi',
            buttonTitle: 'Değiştir',
            onPressed: () => addressController.selectNewAddressPopup(context)),
        const SizedBox(height: ProjectSizes.spaceBtwItems),
        Obx(() {
          final address = addressController.selectedAddress.value;

          if (address.id.isEmpty) {
            return const SizedBox.shrink();
          }

          return RoundedContainer(
            padding: const EdgeInsets.all(ProjectSizes.pagePadding),
            width: double.infinity,
            showBorder: true,
            backgroundColor: Colors.white, // Seçili adres stili
            borderColor: Colors.transparent,
            margin: const EdgeInsets.only(bottom: ProjectSizes.spaceBtwItems),
            child: Stack(
              children: [
                const Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    Iconsax.tick_circle5,
                    color: ProjectColors.green2Color,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Adres başlığı (örnek: Ev, İş)
                    Text(
                      address.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(fontFamily: 'Poppins'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: ProjectSizes.spaceBtwItems / 2),

                    /// Telefon numarası
                    Text(
                      address.formattedPhoneNo,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: ProjectSizes.spaceBtwItems / 2),

                    /// Açık adres metni
                    Text(
                      address.toString(), // Veya address.toFormattedString()
                      softWrap: true,
                    ),
                  ],
                )
              ],
            ),
          );
        })
      ],
    );
  }
}
