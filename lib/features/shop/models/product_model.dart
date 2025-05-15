import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/brand_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_attribute_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_variation_model.dart';

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
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
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

  /// JSON formatına çeviren fonksiyon
  Map<String, dynamic> toJson() {
    return {
      'stock': stock,
      'sku': sku,
      'price': price,
      'title': title,
      'salePrice': salePrice,
      'thumbnail': thumbnail,
      'isFeatured': isFeatured,
      'brand': brand!.toJson(),
      'description': description,
      'categoryId': categoryId,
      'images': images ?? [],
      'productType': productType,
      'productAttributes': productAttributes != null
          ? productAttributes?.map((e) => e.toJson()).toList()
          : [],
      'productVariations': productVariations != null
          ? productVariations?.map((e) => e.toJson()).toList()
          : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;

    return ProductModel(
      id: document.id,
      sku: data['sku'],
      title: data['title'],
      stock: data['stock'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      price: double.parse((data['price'] ?? 0.0).toString()),
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      productType: data['productType'] ?? '',
      brand: BrandModel.fromJson(data['brand']),
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      productAttributes: (data['productAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['productVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id,
      sku: data['sku'] as String?,
      title: data['title'] as String? ?? '',
      stock: data['stock'] as int? ?? 0,
      isFeatured: data['isFeatured'] as bool? ?? false,
      price: (data['price'] is num) ? (data['price'] as num).toDouble() : 0.0,
      salePrice: (data['salePrice'] is num)
          ? (data['salePrice'] as num).toDouble()
          : 0.0,
      thumbnail: data['thumbnail'] as String? ?? '',
      categoryId: data['categoryId'] as String? ?? '',
      description: data['description'] as String? ?? '',
      productType: data['productType'] as String? ?? '',
      brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
      images: data['images'] != null
          ? List<String>.from(data['images'] as List)
          : [],
      productAttributes: (data['productAttributes'] as List<dynamic>?)
              ?.map((e) => ProductAttributeModel.fromJson(e))
              .toList() ??
          [],
      productVariations: (data['productVariations'] as List<dynamic>?)
              ?.map((e) => ProductVariationModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
