import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/update_name_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: MyAppbar(
        showBackArrow: true,
        title: Text(
          'İsim Değiştir',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ProjectSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daha kolay bir doğrulama için lütfen gerçek isminizi kullanınız.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: ProjectSizes.spaceBtwItems * 2,
            ),
            Form(
                key: controller.updateUserFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          Validator.validateEmptyText('İsim', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: ProjectTexts.firstName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(
                      height: ProjectSizes.spaceBtwItems,
                    ),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          Validator.validateEmptyText('Soyisim', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: ProjectTexts.lastName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(
                      height: ProjectSizes.spaceBtwItems * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => controller.updateUserName(),
                          child: const Text('Kaydet')),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
