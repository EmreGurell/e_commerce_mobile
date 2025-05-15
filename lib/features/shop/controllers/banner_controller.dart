import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/data/repositories/banners/banner_repository.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      //Show loader while loading banners
      isLoading.value = true;

      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      this.banners.assignAll(banners);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Hay Aksi', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
