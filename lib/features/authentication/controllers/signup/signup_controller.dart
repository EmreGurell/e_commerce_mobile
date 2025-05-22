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
      FullScreenLoader.openLoadingDialog(
        'Bilgileriniz işleniyor..',
        ImagePaths.docerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(
          title: 'Bağlantı Yok',
          message: 'Lütfen internet bağlantınızı kontrol edin.',
        );
        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicy.value) {
        FullScreenLoader.stopLoading();
        Loaders.warningSnackBar(
          title: 'Gizlilik Politikasını kabul et',
          message:
              'Hesap açmak için gizlilik politikasını ve kullanım koşullarını kabul et',
        );
        return;
      }

      if (password.text.trim() != passwordCheck.text.trim()) {
        FullScreenLoader.stopLoading();
        Loaders.warningSnackBar(
          title: 'Şifreler Eşleşmiyor',
          message: 'Lütfen şifrelerinizi kontrol edin.',
        );
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      if (userCredential.user == null) {
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(
          title: 'Kayıt Başarısız',
          message: 'Bilinmeyen bir hata oluştu.',
        );
        return;
      }

      await userCredential.user!.sendEmailVerification();

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
      );

      final userRepository = Get.put(UserRepository());

      try {
        await userRepository.saveUserRecord(newUser);
      } catch (e) {
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(
          title: 'Veri Kaydetme Hatası',
          message: 'Kullanıcı verisi kaydedilirken bir hata oluştu.',
        );
        return;
      }
      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: 'Hesabınız başarıyla oluşturuldu',
        message: 'Devam etmek için e-postanızı doğrulayın',
      );

      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      print("Signup Error: ${e.toString()} - Type: ${e.runtimeType}");
      Loaders.errorSnackBar(
        title: 'Hay Aksi',
        message: e.toString(),
      );
    } finally {
      FullScreenLoader.stopLoading();
    }
  }
}
