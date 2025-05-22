import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/utils/exceptions/exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  CollectionReference get _productsCollection => _db.collection('Products');

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs
          .map((e) => ProductModel.fromQuerySnapshot(e))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e, stackTrace) {
      print('$e');
      print(stackTrace);
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      return snapshot.docs
          .map((e) => ProductModel.fromQuerySnapshot(e))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<PaginatedProducts> getProductsPaginated({
    DocumentSnapshot? lastDocument,
    int limit = 5,
    String? searchText,
  }) async {
    Query query = _db
        .collection('Products')
        .orderBy('title', descending: true)
        .limit(limit);

    // Arama varsa başlık bazlı arama yap
    if (searchText != null && searchText.isNotEmpty) {
      query = query
          .where('title', isGreaterThanOrEqualTo: searchText)
          .where('title', isLessThanOrEqualTo: '$searchText\uf8ff');
    }

    // Son çekilen dokümandan devam et
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final snapshot = await query.get();

    final products = snapshot.docs.map((doc) {
      final product = ProductModel.fromQuerySnapshot(doc);
      product.originalDoc = doc;
      return product;
    }).toList();

    return PaginatedProducts(
      products: products,
      lastDocument: snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
    );
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .get();
      return snapshot.docs
          .map((e) => ProductModel.fromQuerySnapshot(e))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<List<ProductModel>> searchByTitle(String searchTerm) async {
    final query = _productsCollection
        .where('title', isGreaterThanOrEqualTo: searchTerm)
        .where('title', isLessThanOrEqualTo: '$searchTerm\uf8ff');

    return await fetchProductsByQuery(query);
  }

  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      if (productIds.isEmpty) return []; // Boş liste kontrolü eklendi

      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromQuerySnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('brand.id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('brand.id', isEqualTo: brandId)
              .limit(limit)
              .get();
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return products;
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

  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = -1,
  }) async {
    try {
      final productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      if (productIds.isEmpty) return []; // Boşsa direkt dön

      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return products;
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

class PaginatedProducts {
  final List<ProductModel> products;
  final DocumentSnapshot? lastDocument;

  PaginatedProducts({required this.products, required this.lastDocument});
}
