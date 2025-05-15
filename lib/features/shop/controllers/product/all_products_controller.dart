import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/products/product_repository.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
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
      case 'Artan Fiyat':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;

      case 'Azalan Fiyat':
        products.sort((a, b) => a.price.compareTo(b.price));

        break;

      case 'İndirim':
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });

        break;

      case 'En Yeni':
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;

      default:
        products.sort((a, b) => a.title.compareTo(b.title));

        break;
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
