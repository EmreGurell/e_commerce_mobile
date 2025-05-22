import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/rounded_container.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/address_controller.dart';
import 'package:tarhanaciyasarmobil/features/personalization/models/address_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.address,
    required this.onTap,
    required this.onDismissed, // yeni eklendi
  });

  final AddressModel address;
  final VoidCallback onTap;
  final DismissDirectionCallback onDismissed; // yeni eklendi

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final isDark = HelperFuctions.isDarkMode(context);

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;

      return Dismissible(
        key: ValueKey(address.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: onDismissed,
        child: InkWell(
          onTap: onTap,
          child: RoundedContainer(
            padding: const EdgeInsets.all(ProjectSizes.pagePadding),
            width: double.infinity,
            showBorder: true,
            backgroundColor: selectedAddress ? Colors.white : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : isDark
                ? ProjectColors.grayColor
                : ProjectColors.gray4Color,
            margin: const EdgeInsets.only(bottom: ProjectSizes.spaceBtwItems),
            child: Stack(
              children: [
                if (selectedAddress)
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
                    Text(
                      address.name,
                      style: Theme.of(context).textTheme.titleLarge!.apply(fontFamily: 'Poppins'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
                    Text(
                      address.formattedPhoneNo,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
                    Text(
                      address.toString(),
                      softWrap: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

