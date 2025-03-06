import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/products.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  bool isItemInCart;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    this.isItemInCart = false,
  });
}

class Cart extends Notifier<Map<String, CartItem>> {
  @override
  Map<String, CartItem> build() {
    return {}; // ✅ Initialize with an empty map
  }

  Map<String, CartItem> get allCartItems => state;

  int get itemCount => state.length;

  double get totalAmount {
    return state.values.fold(0.0, (sum, cartItem) {
      return sum + (cartItem.price * cartItem.quantity);
    });
  }

  void addItems(String productId, String title, double price) {
    state = {
      ...state,
      productId: state.containsKey(productId)
          ? CartItem(
              id: state[productId]!.id,
              title: state[productId]!.title,
              price: state[productId]!.price,
              quantity: state[productId]!.quantity + 1,
              isItemInCart: true,
            )
          : CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1,
              isItemInCart: true,
            ),
    };
  }

  bool isAvailableInCart(String productId) {
    return state.containsKey(productId);
  }

  int particularItemTotal(String productId) {
    return state[productId]?.quantity ?? 0;
  }

  void removeItem(String productId) {
    state = {...state}..remove(productId);
  }

  void removeSingleItem(String productId) {
    if (!state.containsKey(productId)) return;

    if (state[productId]!.quantity > 1) {
      state = {
        ...state,
        productId: CartItem(
          id: state[productId]!.id,
          title: state[productId]!.title,
          price: state[productId]!.price,
          quantity: state[productId]!.quantity - 1,
          isItemInCart: true,
        ),
      };
    } else {
      removeItem(productId);
    }
  }

  void clear() {
    state = {};
  }
}

final cartNotifierProvider = NotifierProvider<Cart, Map<String, CartItem>>(() {
  return Cart();
});
