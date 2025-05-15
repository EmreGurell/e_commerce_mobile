import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/features/personalization/models/address_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/cart_item_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.items,
    this.address,
    this.paymentMethod = 'Online Kredi/Banka Kartı',
    this.deliveryDate,
  });

  String get formattedOrderDate => HelperFuctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? HelperFuctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
        id: data['id'] as String,
        userId: data['userId'] as String,
        status: OrderStatus.values
            .firstWhere((e) => e.toString() == data['status']),
        totalAmount: data['totalAmount'] as double,
        orderDate: (data[''] as Timestamp).toDate(),
        items: (data[''] as List<dynamic>)
            .map((itemData) =>
                CartItemModel.fromJson(itemData as Map<String, dynamic>))
            .toList(),
        address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
        paymentMethod: data['paymentMethod'] as String,
        deliveryDate: data['deliveryData'] == null
            ? null
            : (data['deliveryDate'] as Timestamp).toDate());
  }
}
