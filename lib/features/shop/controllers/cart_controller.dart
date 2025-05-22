import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarhanaciyasarmobil/common/widgets/dialogs/dialogs.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/variation_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/cart_item_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';
import 'package:tarhanaciyasarmobil/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }
  void addOneCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item, BuildContext context) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // Öğeyi tamamen kaldırmadan önce bir onay diyaloğu göster
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index, context)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void addToCart(ProductModel product) {
    if (productQuantityInCart.value < 1) {
      Loaders.customToast(message: 'Adet seçiniz');
      return;
    }

    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      Loaders.customToast(message: 'Varyasyon seçiniz');
      return;
    }

    final isVariable = product.productType == ProductType.variable.toString();

    int availableStock = isVariable
        ? variationController.selectedVariation.value.stock
        : product.stock;

    if (availableStock < 1) {
      Loaders.warningSnackBar(
          title: 'Hay Aksi',
          message:
              'Seçtiğiniz ${isVariable ? "varyasyonda" : "üründe"} stok mevcut değil');
      return;
    }

    // Sepette zaten varsa, toplam istenen adet stoktan büyükse engelle
    int alreadyInCart = isVariable
        ? getVariationQuantityInCart(
            product.id, variationController.selectedVariation.value.id)
        : getProductQuantityInCart(product.id);

    int newTotalQuantity = alreadyInCart + productQuantityInCart.value;

    if (newTotalQuantity > availableStock) {
      Loaders.warningSnackBar(
          title: 'Yetersiz Stok',
          message:
              'Sepetteki miktar ile birlikte toplam $newTotalQuantity adet isteniyor ancak stokta sadece $availableStock adet var.');
      return;
    }

    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      cartItems[index].quantity += selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    Loaders.customToast(message: 'Ürün başarıyla sepetinize eklendi');
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation =
        variationController.selectedVariation.value.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
        productId: product.id,
        quantity: quantity,
        price: price,
        title: product.title,
        variationId: variation.id,
        image: isVariation ? variation.image : product.thumbnail,
        brandName: product.brand != null ? product.brand!.name : '',
        selectedVariation: isVariation ? variation.attributeValues : null);
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    LocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings =
        LocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());

    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void removeFromCartDialog(int index, BuildContext context) {
    ConfirmationDialog.show(
      context: context,
      title: 'Sepetten Kaldır',
      content: 'Ürünü sepetinizden kaldırmak istediğinize emin misiniz?',
      onConfirm: () {
        // Remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        Loaders.customToast(message: 'Ürün sepetinizden kaldırıldı.');
      },
      onCancel: () => Get.back(),
      icon: Iconsax.warning_2,
      iconColor: ProjectColors.redColor,
    );
  }

  /// -- Initialize already added Item's Count in the cart.
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // Get selected Variation if any...
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  void removeItemCompletely(CartItemModel item) {
    cartItems.removeWhere((element) =>
        element.productId == item.productId &&
        element.variationId == item.variationId);
    updateCart();
    Loaders.customToast(message: '${item.title} sepetten kaldırıldı.');
  }
}
