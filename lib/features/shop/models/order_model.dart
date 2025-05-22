import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/features/personalization/models/address_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/cart_item_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;
  final OrderStatus status;
  final double shippingCost;
  final double taxCost;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final bool billingAddressSameAsShipping;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.docId = '',
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.items,
    this.paymentMethod = 'Online Kredi/Banka Kartı',
    this.shippingAddress,
    this.billingAddress,
    this.billingAddressSameAsShipping = true,
    this.deliveryDate,
    this.shippingCost = 0,
    this.taxCost = 0,
  });

  String get formattedOrderDate => HelperFuctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? HelperFuctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText {
    switch (status) {
      case OrderStatus.delivered:
        return 'Teslim Edildi';
      case OrderStatus.shipped:
        return 'Siparişiniz Kargoda';
      case OrderStatus.cancelled:
        return 'İptal Edildi';
      case OrderStatus.pending:
        return 'Beklemede';
      default:
        return 'İşleniyor';
    }
  }

  OrderModel copyWith({
    String? id,
    String? docId,
    String? userId,
    OrderStatus? status,
    double? shippingCost,
    double? taxCost,
    double? totalAmount,
    DateTime? orderDate,
    String? paymentMethod,
    AddressModel? shippingAddress,
    AddressModel? billingAddress,
    bool? billingAddressSameAsShipping,
    DateTime? deliveryDate,
    List<CartItemModel>? items,
  }) {
    return OrderModel(
      id: id ?? this.id,
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      shippingCost: shippingCost ?? this.shippingCost,
      taxCost: taxCost ?? this.taxCost,
      totalAmount: totalAmount ?? this.totalAmount,
      orderDate: orderDate ?? this.orderDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      billingAddressSameAsShipping:
          billingAddressSameAsShipping ?? this.billingAddressSameAsShipping,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress?.toJson(),
      'billingAddress': billingAddress?.toJson(),
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
      'deliveryDate': deliveryDate,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      docId: snapshot.id,
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      status: data['status'] != null
          ? OrderStatus.values.firstWhere(
              (e) => e.toString() == data['status'],
              orElse: () => OrderStatus.pending,
            )
          : OrderStatus.pending,
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>? ?? [])
          .map((itemData) =>
              CartItemModel.fromJson(itemData as Map<String, dynamic>))
          .toList(),
      shippingAddress: data['shippingAddress'] != null
          ? AddressModel.fromMap(data['shippingAddress'])
          : null,
      billingAddress: data['billingAddress'] != null
          ? AddressModel.fromMap(data['billingAddress'])
          : null,
      billingAddressSameAsShipping:
          data['billingAddressSameAsShipping'] ?? true,
      paymentMethod: data['paymentMethod'] ?? 'Online Kredi/Banka Kartı',
      deliveryDate: data['deliveryDate'] != null
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null,
      shippingCost: (data['shippingCost'] ?? 0).toDouble(),
      taxCost: (data['taxCost'] ?? 0).toDouble(),
    );
  }
}
