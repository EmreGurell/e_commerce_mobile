import 'package:tarhanaciyasarmobil/features/authentication/screens/signup/widgets/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarhanaciyasarmobil/features/authentication/controllers/signup/signup_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/validators/validator.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey, // GlobalKey<FormState>
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First and Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: controller.firstName,
                  validator: (value) =>
                      Validator.validateEmptyText('Ad', value),
                  decoration: const InputDecoration(
                      labelText: ProjectTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: ProjectSizes.spaceBtwItems),
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: controller.lastName,
                  validator: (value) =>
                      Validator.validateEmptyText('Soyad', value),
                  decoration: const InputDecoration(
                      labelText: ProjectTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: ProjectSizes.spaceBtwItems),

          // Email
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: controller.email,
            validator: (value) => Validator.validateEmail(value),
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct),
                labelText: ProjectTexts.email),
          ),
          const SizedBox(height: ProjectSizes.spaceBtwItems),

          // Phone Number
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            controller: controller.phoneNumber,
            validator: (value) => Validator.validatePhoneNumber(value),
            decoration: const InputDecoration(
                hintText: ProjectTexts.phoneNumberHint,
                prefixIcon: Icon(Iconsax.call),
                labelText: ProjectTexts.phoneNumber),
          ),
          const SizedBox(height: ProjectSizes.spaceBtwItems),

          // Password
          Obx(() => TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller.password,
                validator: (value) => Validator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: ProjectTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(!controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              )),
          const SizedBox(height: ProjectSizes.spaceBtwItems),

          // Password-Check
          Obx(() => TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller.passwordCheck,
                validator: (value) =>
                    Validator.validateEmptyText('Şifre kontrolü', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: ProjectTexts.repeatPassword,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(!controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              )),
          const SizedBox(height: ProjectSizes.spaceBtwItems),

          // Terms & Conditions Checkbox
          const TermsAndConditionCheckbox(),

          // Signup Button
          const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(ProjectTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
