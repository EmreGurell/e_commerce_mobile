import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/address_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: MyAppbar(
        showBackArrow: true,
        title: Text(
          ProjectTexts.addNewAdress,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: Form(
            key: controller.addNewAddressKey,
            child: Column(
              children: [
                Column(
                  children: [
                    const ContactInfo(),
                    const SizedBox(height: ProjectSizes.spaceBtwItems),
                    const AddressInfo(),
                    const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => controller.addNewAddresses(),
                            child: const Text('Kaydet')))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Column(
      children: [
        const SectionHeading(
          showActionButton: false,
          title: ProjectTexts.contactInfo,
        ),
        const Divider(),
        const SizedBox(height: ProjectSizes.spaceBtwItems),
        TextFormField(
          textInputAction: TextInputAction.next,
          validator: (value) => Validator.validateEmptyText('Ad', value),
          controller: controller.name,
          decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.user),
              labelText: ProjectTexts.firstName),
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems),
        TextFormField(
          textInputAction: TextInputAction.next,
          validator: (value) => Validator.validatePhoneNumber(value),
          controller: controller.phoneNumber,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
              hintText: ProjectTexts.phoneNumberHint,
              prefixIcon: Icon(Iconsax.mobile),
              labelText: ProjectTexts.phoneNumber),
        ),
      ],
    );
  }
}

class AddressInfo extends StatelessWidget {
  const AddressInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Column(
      children: [
        const SectionHeading(
          showActionButton: false,
          title: ProjectTexts.addressInfo,
        ),
        const Divider(),
        const SizedBox(height: ProjectSizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.validateEmptyText('İl', value),
                controller: controller.city,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.buildings_24),
                    labelText: ProjectTexts.city),
              ),
            ),
            const SizedBox(width: ProjectSizes.spaceBtwItems),
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    Validator.validateEmptyText('ilçe', value),
                controller: controller.district,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_4),
                    labelText: ProjectTexts.district),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: ProjectSizes.spaceBtwItems,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    Validator.validateEmptyText('Posta Kodu', value),
                controller: controller.postalCode,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.code),
                    labelText: ProjectTexts.postalCode),
              ),
            ),
            const SizedBox(width: ProjectSizes.spaceBtwItems),
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    Validator.validateEmptyText('Mahalle', value),
                controller: controller.neighbourhood,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_34),
                    labelText: ProjectTexts.neighbourhood),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: ProjectSizes.spaceBtwItems,
        ),
        TextFormField(
          validator: (value) => Validator.validateEmptyText('Adres', value),
          controller: controller.address,
          decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.location),
              labelText: ProjectTexts.address),
        ),
      ],
    );
  }
}
