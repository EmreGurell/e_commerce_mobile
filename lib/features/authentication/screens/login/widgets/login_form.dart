import 'package:tarhanaciyasarmobil/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/signup/signup.dart';
import 'package:tarhanaciyasarmobil/features/controllers/login/login_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ProjectPadding.appBarPadding.value() / 2),
      child: Form(
          key: controller.loginFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.email,
                validator: (value) => Validator.validateEmail(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: ProjectTexts.email),
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) =>
                      Validator.validateEmptyText('Şifre', value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: ProjectTexts.password,
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(!controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye)),
                  ),
                ),
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value)),
                      Text(
                        ProjectTexts.rememberMe,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                  //Forget Password
                  TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: Text(
                      ProjectTexts.forgetPassword,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordSignIn(),
                    child: const Text(ProjectTexts.signIn)),
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: const Text(ProjectTexts.createAccount)),
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems * 2,
              )
            ],
          )),
    );
  }
}
