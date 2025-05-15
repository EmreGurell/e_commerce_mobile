import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/categories/category_repository.dart';
import 'package:tarhanaciyasarmobil/data/repositories/products/product_repository.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/category_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

//Load category data
  Future<void> fetchCategories() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;

      //Fetch categories from data source
      final categories = await _categoryRepository.getAllCategories();

      //Update the categories list
      allCategories.assignAll(categories);

      //Filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());

      isLoading.value = false;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Hay Aksi', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchFeaturedCategories() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;

      //Fetch categories from data source
      final categories = await _categoryRepository.getFeaturedCategories();

      //Update the categories list
      allCategories.assignAll(categories);

      //Filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());

      isLoading.value = false;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Hay Aksi', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
//Load selected category data

//Get category or sub-category products.
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    final products = await ProductRepository.instance
        .getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
  }
}
