import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/brand_model.dart';
import 'package:tarhanaciyasarmobil/utils/exceptions/exceptions.dart';
import 'package:flutter/services.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// **Belirli bir kategoriye ait markaları getirir**
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['brandId'] as String)
          .toList();
      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      return brands;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (_) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  /// **Tüm markaları getirir**
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (_) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }
}
