import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/products/product_repository.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_variation_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final isFetchingMore = false.obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final productRepo = Get.put(ProductRepository());

  // Lazy load için:
  DocumentSnapshot? lastProductDoc;
  final int limit = 10;
  bool hasMoreProducts = true;

  // Seçili varyasyon
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    fetchProductsPaginated();
    super.onInit();
  }

  void setSelectedVariation(ProductVariationModel variation) {
    selectedVariation.value = variation;
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepo.getFeaturedProducts();
      featuredProducts.assignAll(products);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Hay Aksi', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final products = await productRepo.getAllFeaturedProducts();
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Hay Aksi', message: e.toString());
      return [];
    }
  }

  Future<void> fetchProductsPaginated() async {
    if (isFetchingMore.value || !hasMoreProducts) return;

    try {
      isFetchingMore.value = true;

      final paginatedProducts = await productRepo.getProductsPaginated(
        lastDocument: lastProductDoc,
        limit: limit,
        searchText: null, // İstersen arama metnini buradan geçebilirsin
      );

      if (paginatedProducts.products.isNotEmpty) {
        allProducts.addAll(paginatedProducts.products);
        lastProductDoc = paginatedProducts.lastDocument;
      }

      if (paginatedProducts.products.length < limit) {
        hasMoreProducts = false;
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Hay Aksi', message: e.toString());
    } finally {
      isFetchingMore.value = false;
    }
  }

  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - $largestPrice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice * 100);
    return percentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'Stok Mevcut' : 'Stokta yok';
  }
}
