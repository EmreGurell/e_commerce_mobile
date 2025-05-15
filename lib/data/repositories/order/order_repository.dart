import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/order_model.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty)
        throw 'Kullanıcı bilgisi bulunamadı. Lütfen birkaç dakika sonra tekrar deneyiniz.';

      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Sipariş bilgisi alınırken bir hata oluştu. Lütfen daha sonra tekrar deneyin';
    }
  }

  Future<void> saveOrder(OrderModel order, String uid) async {
    try {
      await _db
          .collection('Users')
          .doc(uid)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Sipariş bilgisi kaydedilirken bir hata oluştu. Lütfen daha sonra tekrar deneyin';
    }
  }
}
