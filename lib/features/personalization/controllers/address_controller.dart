import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/data/repositories/address/address_repository.dart';
import 'package:tarhanaciyasarmobil/features/personalization/models/address_model.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/address/add_new_address.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/address/address_page.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/address/widgets/address.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/network_manager.dart';
import 'package:tarhanaciyasarmobil/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  final networkManager = Get.put(NetworkManager());

  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepo = Get.put(AddressRepository());
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final district = TextEditingController();
  final neighbourhood = TextEditingController();
  final address = TextEditingController();
  GlobalKey<FormState> addNewAddressKey = GlobalKey<FormState>();
  RxBool refreshData = true.obs;

  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepo.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Adres bulunamadı', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async {
            return false;
          },
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const CircularProgressIndicator());

      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepo.updateSelectedField(selectedAddress.value.id, false);
      }
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepo.updateSelectedField(selectedAddress.value.id, true);

      Get.back();
      refreshData.toggle();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Seçim hatası', message: e.toString());
    }
  }

  Future addNewAddresses() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Adres kaydediliyor...', ImagePaths.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!addNewAddressKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      final newAddress = AddressModel(
        id: '',
        name: name.text.trim(),
        city: city.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        postalCode: postalCode.text.trim(),
        state: district.text.trim(),
        street: neighbourhood.text.trim(),
        address: address.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepo.addAddress(newAddress);
      newAddress.id = id;
      await selectAddress(newAddress);

      Loaders.successSnackBar(
          title: 'işlem başarılı', message: 'Adresin başarıyla kaydedildi.');

      refreshData.toggle();
      resetFormFields();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Adres bulunamadı', message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Alt sayfanın tam açılması için
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: ProjectSizes.lg,
          right: ProjectSizes.lg,
          top: ProjectSizes.lg,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5, // Yükseklik sınırı
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                showActionButton: false,
                title: 'Adres Seçiniz',
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),
              Expanded(
                child: FutureBuilder(
                  future: getAllUserAddresses(),
                  builder: (_, snapshot) {
                    final response = CloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot);
                    if (response != null) return response;

                    final addresses = snapshot.data ?? [];

                    if (addresses.isEmpty) {
                      return const Center(
                          child: Text('Kayıtlı adres bulunamadı.'));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: addresses.length,
                      itemBuilder: (_, index) => SingleAddress(
                        address: addresses[index],
                        onTap: () async {
                          await selectAddress(addresses[index]);
                          Get.back();
                        },
                        onDismissed: (_) {},
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const AddNewAddress()),
                  child: const Text('Yeni Adres Ekle'),
                ),
              ),
              const SizedBox(height: ProjectSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteAddress(String id) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      await addressRepo.deleteAddress(id); // Repositede bu metod olmalı

      /// Eğer silinen adres seçili adresse, sıfırla
      if (selectedAddress.value.id == id) {
        selectedAddress.value = AddressModel.empty();
      }

      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(
          title: 'Silme başarılı', message: 'Adres başarıyla silindi.');

      refreshData.toggle();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Silme hatası', message: e.toString());
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    district.clear();
    neighbourhood.clear();
    address.clear();
    city.clear();
    postalCode.clear();
    addNewAddressKey.currentState?.reset();
  }
}
