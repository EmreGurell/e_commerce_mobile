import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/images_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  // Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  // Select Attribute and Variation
  void onAttributeSelected(
      ProductModel product, String attributeName, String attributeValue) {
    // Attribute'u doğrudan güncelle
    selectedAttributes[attributeName] = attributeValue;

    // Güncel selectedAttributes map’ini kullan
    final currentSelectedAttributes =
        Map<String, dynamic>.from(selectedAttributes);

    final matchingVariation = product.productVariations!.firstWhere(
      (variation) => isSameAttributeValues(
          variation.attributeValues, currentSelectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    // Varyasyon görselini değiştir
    if (matchingVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          matchingVariation.image;
    }

    // Sepetteki miktarı güncelle
    if (matchingVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, matchingVariation.id);
    }

    // Varyasyonu kaydet
    selectedVariation.value = matchingVariation;

    // Stok durumunu güncelle
    getProductVariationStockStatus();
  }

  // Check if selected attributes matches any variation attributes
  bool isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    // If selectedAttributes contains 3 attributes and current variation contains 2 then return false
    if (variationAttributes.length != selectedAttributes.length) return false;

    // If any of the attributes is different then return false. e.g. [Green, Large] x [Green, Small]
    for (final key in variationAttributes.keys) {
      // Attributes[key] = Value which could be [Green, Small, Cotton] etc.
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

// Check Attribute availability / Stock in Variation
  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    // Pass the variations to check which attributes are available and stock is not 0
    final availableVariationAttributeValues = variations
        .where((variation) =>
            // Check Empty / Out of Stock Attributes
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        // Fetch all non-empty attributes of variations
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

// Check Product Variation Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? 'Stokta var'
        : 'Stokta mevcut değil';
  }

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
