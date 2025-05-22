import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/data/repositories/products/product_repository.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';

class MySearchController extends GetxController {
  static MySearchController get instance => Get.find();

  final TextEditingController searchController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxString searchText = ''.obs;

  final ProductRepository _productRepo = Get.put(ProductRepository());

  // Lazy load için
  DocumentSnapshot? lastDocument; // Firestore'dan son çekilen belge
  RxBool hasMore = true.obs;
  final int pageSize = 20;
  int page = 0;

  @override
  void onInit() {
    super.onInit();
    loadMoreProducts();
    loadInitialProducts();

    searchController.addListener(() {
      searchText.value = searchController.text;
      if (searchText.value.isEmpty) {
        loadInitialProducts();
      } else {
        searchProducts(searchText.value);
      }
    });
  }

  Future<void> loadInitialProducts() async {
    products.clear();
    lastDocument = null;
    hasMore.value = true; // Burada .value ile değiştiriyoruz
    page = 0;
    await loadMoreProducts();
  }

  Future<void> loadMoreProducts() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      final result = await _productRepo.getProductsPaginated(
        lastDocument: lastDocument,
        limit: pageSize,
        searchText: searchText.value,
      );

      if (result.products.isNotEmpty) {
        products.addAll(result.products);
        lastDocument = result.lastDocument;
        page++;
      }

      if (result.products.length < pageSize) {
        hasMore.value = false; // Burada da .value ile değiştiriyoruz
      }
    } catch (e) {
      Get.snackbar("Hata", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchProducts(String query) async {
    products.clear();
    lastDocument = null;
    hasMore.value = true;
    page = 0;

    if (query.isEmpty) {
      await loadInitialProducts();
      return;
    }

    await loadMoreProducts();
  }

  void clearSearch() {
    searchController.clear();
    loadInitialProducts();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
