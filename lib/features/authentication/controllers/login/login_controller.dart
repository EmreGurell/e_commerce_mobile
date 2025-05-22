import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/user_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/network_manager.dart';
import 'package:tarhanaciyasarmobil/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    // Null check for localStorage
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      // Show loading dialog
      FullScreenLoader.openLoadingDialog(
          "Giriş Yapılıyor...", ImagePaths.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(
            title: 'Bağlantı Yok',
            message: 'Lütfen internet bağlantınızı kontrol edin.');
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check & Save Credentials
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Attempt login with Firebase Authentication
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      FullScreenLoader.stopLoading();

      // Redirect after successful login
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
          title: 'Hay aksi',
          message: 'Giriş işlemi sırasında bir hata oluştu. ${e.toString()}');
    }
  }

  Future<void> googleSignIn() async {
    try {
      // Show loading dialog
      FullScreenLoader.openLoadingDialog(
          'Giriş Yapılıyor...', ImagePaths.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(
            title: 'Bağlantı Yok',
            message: 'Lütfen internet bağlantınızı kontrol edin.');
        return;
      }

      // Attempt Google Sign-In
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save user data
      await userController.saveUserRecord(userCredentials);

      FullScreenLoader.stopLoading();

      // Redirect after successful sign-in
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
          title: 'Hay aksi',
          message:
              'Google ile giriş sırasında bir hata oluştu. ${e.toString()}');
    }
  }
}
