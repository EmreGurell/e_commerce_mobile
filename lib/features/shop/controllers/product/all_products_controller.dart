import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/products/product_repository.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Ad'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final products = await repository.fetchProductsByQuery(query);

      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Hay Aksi', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Ad':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;

      case 'Azalan Fiyat':
        products.sort((a, b) {
          final aPrice = (a.salePrice > 0 && a.salePrice < a.price) ? a.salePrice : a.price;
          final bPrice = (b.salePrice > 0 && b.salePrice < b.price) ? b.salePrice : b.price;
          return bPrice.compareTo(aPrice);
        });
        break;

      case 'Artan Fiyat':
        products.sort((a, b) {
          final aPrice = (a.salePrice > 0 && a.salePrice < a.price) ? a.salePrice : a.price;
          final bPrice = (b.salePrice > 0 && b.salePrice < b.price) ? b.salePrice : b.price;
          return aPrice.compareTo(bPrice);
        });
        break;

      case 'İndirim':
        products.sort((a, b) {
          final aHasDiscount = a.salePrice > 0 && a.salePrice < a.price;
          final bHasDiscount = b.salePrice > 0 && b.salePrice < b.price;

          if (aHasDiscount && bHasDiscount) {
            return a.salePrice.compareTo(b.salePrice); // küçükten büyüğe
          } else if (aHasDiscount) {
            return -1;
          } else if (bHasDiscount) {
            return 1;
          } else {
            return 0;
          }
        });
        break;

      case 'En Yeni':
        products.sort((a, b) => b.date!.compareTo(a.date!));
        break;

      default:
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
    }
  }


  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Ad');
  }
}
