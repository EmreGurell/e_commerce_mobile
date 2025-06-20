import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/common/widgets/success_screen/success_screen.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/data/repositories/order/order_repository.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/address_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/checkout_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/order_model.dart';
import 'package:tarhanaciyasarmobil/navigation_menu.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      Loaders.warningSnackBar(title: 'Hay Aksi', message: e.toString());
      return [];
    }
  }

  Future<void> processOrder(double totalAmount) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Siparişiniz işleniyor...', ImagePaths.pencilAnimation);

      final uid = AuthenticationRepository.instance.authUser?.uid ?? '';
      if (uid.isEmpty) return;

      final selectedAddress = addressController.selectedAddress.value;
      if (selectedAddress.id == null || selectedAddress.id!.isEmpty) {
        FullScreenLoader.stopLoading();
        Loaders.warningSnackBar(
          title: 'Adres Gerekli',
          message: 'Lütfen önce bir teslimat adresi seçiniz.',
        );
        return;
      }

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: uid,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        shippingAddress: selectedAddress,
        deliveryDate:
            DateTime.now().add(const Duration(days: 3)), // örnek teslim tarihi
        items: cartController.cartItems.toList(),
      );

      await orderRepository.saveOrder(order, uid);
      cartController.clearCart();

      FullScreenLoader.stopLoading();

      Get.off(() => SuccessScreen(
            image: ImagePaths.orderCompletedAnimation,
            title: 'Ödeme Başarılı',
            subtitle: 'Siparişiniz en kısa sürede kargoya verilecektir.',
            onPressed: () => Get.offAll(() => NavigationMenu()),
          ));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: 'Sipariş Başarısız',
        message: 'Bir hata oluştu: ${e.toString()}',
      );
    }
  }
}
