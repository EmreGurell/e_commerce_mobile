import 'dart:async';

import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/common/widgets/success_screen/success_screen.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

//Send Email Whenever Verify Screen appears $ Set Timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //Send Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(
          title: 'E-posta gönderildi',
          message: 'Lütfen e-postanızı kontrol ediniz.');
    } catch (e) {
      Loaders.errorSnackBar(
          title: 'Bir şeyler ters gitti.', message: e.toString());
    }
  }

  //Timer to automatically redirect on Email Verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: ImagePaths.successfullyRegisterAnimation,
            title: ProjectTexts.yourAccountCreatedTitle,
            subtitle: ProjectTexts.yourAccountCreatedSubtitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  //Manually Check if Email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: ImagePaths.successfullyRegisterAnimation,
          title: ProjectTexts.yourAccountCreatedTitle,
          subtitle: ProjectTexts.yourAccountCreatedSubtitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
