class ProductVariationModel {
  String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  /// Boş bir nesne döndürmek için static fonksiyon
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  /// Nesneyi JSON formatına dönüştüren fonksiyon
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'sku': sku,
      'stock': stock,
      'attributeValues': attributeValues,
    };
  }

  /// Firebase gibi JSON tabanlı verilerden model oluşturmak için factory constructor
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: data['id'] ?? '',
      image: data['image'] ?? '',
      description: data['description'] ?? '',
      price: double.parse((data['price'] ?? 0.0).toString()),
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      sku: data['sku'] ?? '',
      stock: data['stock'] ?? 0,
      attributeValues: Map<String, String>.from(data['attributeValues']),
    );
  }
}
