import 'dart:convert';

import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/products/product_repository.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  Future<void> initFavorites() async {
    final json = LocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(storedFavorites.map(
        (key, value) => MapEntry(key, value as bool),
      ));
    }
  }

  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      Loaders.customToast(message: ' Ürün istek listenize başarıyla eklendi.');
    } else {
      LocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      Loaders.customToast(
          message: ' Ürün istek listenizden başarıyla kaldırıldı.');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    LocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance
        .getFavouriteProducts(favorites.keys.toList());
  }
}
