import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/data/repositories/user/user_repository.dart';
import 'package:tarhanaciyasarmobil/features/authentication/models/user_model.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/signup/verify_email.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/network_manager.dart';
import 'package:tarhanaciyasarmobil/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  SignupController();
  @override
  void onInit() {
    super.onInit();
    Get.put(NetworkManager());
  }

  // Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final passwordCheck = TextEditingController();

  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Sign-up method
  Future<void> signup() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          'Bilgileriniz işleniyor..', ImagePaths.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(
            title: 'Bağlantı Hatası', message: 'İnternete bağlı değilsiniz.');
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        Loaders.warningSnackBar(
            title: 'Gizlilik Politikasını kabul et',
            message:
                'Hesap açmak için gizlilik politikasını ve kullanım koşullarını kabul et');
        return;
      }

      // Check if password and confirmation password match
      if (password.text.trim() != passwordCheck.text.trim()) {
        Loaders.warningSnackBar(
            title: 'Şifreler Eşleşmiyor',
            message: 'Lütfen şifrelerinizi kontrol edin.');
        return;
      }

      // Register user in the Firebase Authentication & Save user data in Firebase Firestore
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user data in Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim());

      final userRepository = Get.put(UserRepository());
      try {
        await userRepository.saveUserRecord(newUser);
      } catch (e) {
        Loaders.errorSnackBar(
            title: 'Veri Kaydetme Hatası',
            message: 'Kullanıcı verisi kaydedilirken bir hata oluştu.');
        return;
      }

      // Show Success Message
      Loaders.successSnackBar(
          title: 'Hesabınız başarıyla oluşturuldu',
          message: 'Devam etmek için e-postanızı doğrulayın');

      // Move to Verify Email Screen
      Get.off(() => VerifyEmailScreen(
            email: email.text.trim(),
          )); // Remove previous screens
    } catch (e) {
      // Log the error for debugging
      print("Error: ${e.toString()}");

      // Show some Generic Error to the user
      Loaders.errorSnackBar(title: 'Hay Aksi', message: e.toString());
    } finally {
      // Remove Loader
      FullScreenLoader.stopLoading();
    }
  }
}
