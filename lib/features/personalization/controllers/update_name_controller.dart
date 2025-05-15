import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/user/user_repository.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/user_controller.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/profile/profile.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/network_manager.dart';
import 'package:tarhanaciyasarmobil/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final networkManager = Get.put(NetworkManager());
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Bilgilerinizi güncelliyoruz...', ImagePaths.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!updateUserFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
      }

      Map<String, dynamic> name = {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(
          title: 'İşlem Başarılı', message: 'İsminiz başarıyla değiştirildi.');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Hay Aksi', message: e.toString());
    }
  }
}
