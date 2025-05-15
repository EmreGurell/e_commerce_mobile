import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/data/services/firebase_storage_service.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/banner_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/category_model.dart';
import 'package:tarhanaciyasarmobil/utils/exceptions/exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('active', isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } on MyFormatException catch (_) {
      throw const MyFormatException().message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyin';
    }
  }

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      //Upload all the Categories along with their Images
      final storage = Get.put(FirebaseStorageService());

      for (var category in categories) {
        final file = await storage.getImageDataFromAssets(category.image);
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        category.image = url;

        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyin';
    }
  }
}
