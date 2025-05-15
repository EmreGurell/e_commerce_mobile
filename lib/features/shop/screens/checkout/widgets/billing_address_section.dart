import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/address_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
            showActionButton: true,
            title: 'Teslimat Adresi',
            buttonTitle: 'Değiştir',
            onPressed: () => addressController.selectNewAddressPopup(context)),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
        Padding(
            padding: const EdgeInsets.only(left: ProjectSizes.pagePadding),
            child: addressController.selectedAddress.value.id.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ev',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ), //Adres Kartı
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: ProjectColors.grayColor,
                          ),
                          const SizedBox(width: ProjectSizes.spaceBtwItems),
                          Expanded(
                            child: Text(
                              '+905551424003',
                              style: Theme.of(context).textTheme.bodyMedium,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_history,
                            color: ProjectColors.grayColor,
                          ),
                          const SizedBox(width: ProjectSizes.spaceBtwItems),
                          Expanded(
                            child: Text(
                              'asdas',
                              style: Theme.of(context).textTheme.bodyMedium,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                : Text('Adres Seçiniz',
                    style: Theme.of(context).textTheme.bodyMedium)),
      ],
    );
  }
}
