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
  });
  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final isDark = HelperFuctions.isDarkMode(context);
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: RoundedContainer(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          width: double.infinity,
          showBorder: true,
          backgroundColor: address.selectedAddress
              ? ProjectColors.blueColor.withOpacity(.3)
              : Colors.transparent,
          borderColor: address.selectedAddress
              ? Colors.transparent
              : isDark
                  ? ProjectColors.grayColor
                  : ProjectColors.gray4Color,
          margin: const EdgeInsets.only(bottom: ProjectSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                    address.selectedAddress ? Iconsax.tick_circle5 : null,
                    color: address.selectedAddress
                        ? isDark
                            ? ProjectColors.whiteColor
                            : ProjectColors.neutralBlackColor.withOpacity(.6)
                        : null),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems / 2,
                  ),
                  Text(
                    address.formattedPhoneNo,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems / 2,
                  ),
                  Text(
                    address.toString(),
                    softWrap: true,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
