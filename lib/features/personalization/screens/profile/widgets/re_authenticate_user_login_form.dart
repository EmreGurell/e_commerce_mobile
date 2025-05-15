import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/user_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/network_manager.dart';
import 'package:tarhanaciyasarmobil/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(NetworkManager());
    final controller = UserController.instance;
    return Scaffold(
      appBar: MyAppbar(
        title: Text(
          'Kimlik Doğrulaması',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ProjectSizes.spaceBtwItems),
        child: Form(
          key: controller.reAuthFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hesabını silebilmek için hesap bilgilerini gir.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),
              // Email Field
              TextFormField(
                controller: controller.verifyEmail,
                validator: Validator.validateEmail,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: ProjectTexts.email,
                ),
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),

              // Password Field

              Obx(
                () => TextFormField(
                  obscureText: controller.hidePassword.value,
                  controller: controller.verifyPassword,
                  validator: (value) =>
                      Validator.validateEmptyText('Şifre', value),
                  decoration: InputDecoration(
                    labelText: ProjectTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems * 2),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      controller.reAuthenticateEmailAndPasswordUser(),
                  child: const Text('Doğrula'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
