import 'package:tarhanaciyasarmobil/features/personalization/controllers/address_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/checkout_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/variation_controller.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}
