import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/brand_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_attribute_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_variation_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  int soldQuantity;
  final String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  // Lazy load için eklendi
  DocumentSnapshot? originalDoc;

  ProductModel({
    this.soldQuantity = 0,
    required this.id,
    required this.stock,
    this.sku,
    required this.price,
    required this.title,
    this.date,
    this.salePrice = 0.0,
    required this.thumbnail,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.images,
    required this.productType,
    this.productAttributes,
    this.productVariations,
    this.originalDoc,
  });

  static ProductModel empty() {
    return ProductModel(
      id: '',
      stock: 0,
      price: 0.0,
      title: '',
      salePrice: 0.0,
      thumbnail: '',
      productType: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stock': stock,
      'sku': sku,
      'price': price,
      'title': title,
      'salePrice': salePrice,
      'thumbnail': thumbnail,
      'isFeatured': isFeatured,
      'brand': brand?.toJson(),
      'description': description,
      'categoryId': categoryId,
      'images': images ?? [],
      'productType': productType,
      'productAttributes':
          productAttributes?.map((e) => e.toJson()).toList() ?? [],
      'productVariations':
          productVariations?.map((e) => e.toJson()).toList() ?? [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;

    return ProductModel(
      soldQuantity: data['soldQuantity'] ?? 0,
      id: document.id,
      sku: data['sku']?.toString(),
      title: data['title']?.toString() ?? '',
      stock: data['stock'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      price: double.tryParse(data['price'].toString()) ?? 0.0,
      salePrice: double.tryParse(data['salePrice'].toString()) ?? 0.0,
      thumbnail: data['thumbnail']?.toString() ?? '',
      categoryId: data['categoryId']?.toString(),
      description: data['description']?.toString(),
      productType: data['productType']?.toString() ?? '',
      brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
      images: (data['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      productAttributes: (data['productAttributes'] as List<dynamic>?)
              ?.map((e) => ProductAttributeModel.fromJson(e))
              .toList() ??
          [],
      productVariations: (data['productVariations'] as List<dynamic>?)
              ?.map((e) => ProductVariationModel.fromJson(e))
              .toList() ??
          [],
      originalDoc: document,
      date: data['date'] != null && data['date'] is Timestamp
          ? (data['date'] as Timestamp).toDate()
          : null,
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      soldQuantity: data['soldQuantity'] ?? 0,
      id: document.id,
      sku: data['sku']?.toString(),
      title: data['title']?.toString() ?? '',
      stock: data['stock'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      price: (data['price'] is num) ? (data['price'] as num).toDouble() : 0.0,
      salePrice: (data['salePrice'] is num)
          ? (data['salePrice'] as num).toDouble()
          : 0.0,
      thumbnail: data['thumbnail']?.toString() ?? '',
      categoryId: data['categoryId']?.toString(),
      description: data['description']?.toString(),
      productType: data['productType']?.toString() ?? '',
      brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
      images: (data['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      productAttributes: (data['productAttributes'] as List<dynamic>?)
              ?.map((e) => ProductAttributeModel.fromJson(e))
              .toList() ??
          [],
      productVariations: (data['productVariations'] as List<dynamic>?)
              ?.map((e) => ProductVariationModel.fromJson(e))
              .toList() ??
          [],
      originalDoc: document,
      date: data['date'] != null && data['date'] is Timestamp
          ? (data['date'] as Timestamp).toDate()
          : null,
    );
  }
}

extension ProductModelExtensions on ProductModel {
  Map<String, double>? get lowestPriceWithOriginal {
    if (productType == ProductType.single.toString()) {
      return {
        'price': price,
        'salePrice': salePrice > 0 ? salePrice : 0,
      };
    }

    if (productType == ProductType.variable.toString() &&
        productVariations != null &&
        productVariations!.isNotEmpty) {
      final prices = productVariations!
          .map<Map<String, double>>((v) => {
                'price': v.price.toDouble(),
                'salePrice': v.salePrice > 0 ? v.salePrice.toDouble() : 0.0,
              })
          .toList();

      prices.sort((a, b) {
        final aPrice = a['salePrice']! > 0 ? a['salePrice']! : a['price']!;
        final bPrice = b['salePrice']! > 0 ? b['salePrice']! : b['price']!;
        return aPrice.compareTo(bPrice);
      });

      return prices.first;
    }

    return null;
  }
}
