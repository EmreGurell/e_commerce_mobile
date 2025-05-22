import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/features/personalization/models/address_model.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Kullanıcı bilgisi bulunamadı. Lütfen birkaç dakika sonra tekrar deneyiniz.';
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Adres bilgisi alınırken bir hata oluştu. Lütfen tekrar deneyin.';
    }
  }

  Future<void> updateSelectedField(String addressID, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressID)
          .update({'selectedAddress': selected});
    } catch (e) {
      // Detaylı hata mesajı döndür
      throw 'Adres seçimi güncellenemedi: ${e.toString()}';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userID = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userID)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Adres bilgisi kaydedilirken bir şeyler ters gitti. Lütfen daha sonra tekrar deneyin';
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      final userID = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userID)
          .collection('Addresses')
          .doc(id)
          .delete();
    } catch (e) {
      throw 'Adres bilgisi kaydedilirken bir şeyler ters gitti. Lütfen daha sonra tekrar deneyin';
    }
  }
}
