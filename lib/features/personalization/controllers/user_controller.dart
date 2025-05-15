import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/data/repositories/user/user_repository.dart';
import 'package:tarhanaciyasarmobil/features/authentication/models/user_model.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/login/login.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/network_manager.dart';
import 'package:tarhanaciyasarmobil/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final hidePassword = false.obs;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final email = userCredentials.user!.email ?? '';

          final user = UserModel(
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              firstName: nameParts.isNotEmpty ? nameParts[0] : '',
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              email: email,
              id: userCredentials.user!.uid);

          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      Loaders.warningSnackBar(
          title: 'Veri Kaydedilemedi',
          message: 'Verilerinizi kaydederken bir şeyler ters gitti.');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(ProjectSizes.pagePadding),
        title: 'Hesabını sil',
        middleText:
            'Hesabını silmek istediğine emin misin? Tüm verilerin kaybolacak',
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('İptal Et')),
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: ProjectColors.redColor,
              side: const BorderSide(color: ProjectColors.redColor)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: ProjectSizes.lg),
            child: Text('Sil'),
          ),
        ));
  }

  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'İşleniyor...', ImagePaths.docerAnimation);

      /// First: re-authenticate user
      final auth = AuthenticationRepository.instance;

      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        /// Re-verify user based on provider
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'İşleniyor...', ImagePaths.docerAnimation);

      /// First: re-authenticate user
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      FullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        Map<String, dynamic> json = {'profilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        // user.value.profilePicture = imageUrl;
        user.refresh();
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Hay Aksi', message: e.toString());
    }
  }
}
