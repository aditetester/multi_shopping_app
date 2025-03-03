import 'package:multishopping_app/modules/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cart.g.dart';

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
class Cart extends Notifier<Set<Product>> {
  @override
  Set<Product> build() {
    throw UnimplementedError();
  }

  Map<String, CartItem> get allCartItems {
    return {..._cartItems};
  }

  int get itemCount {
    return _cartItems.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItems(
    String productId,
    String title,
    double price,
    bool inCart,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (oldvalue) => CartItem(
          id: oldvalue.id,
          title: oldvalue.title,
          price: oldvalue.price,
          quantity: oldvalue.quantity + 1,
          isItemInCart: oldvalue.isItemInCart,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          isItemInCart: inCart,
        ),
      );
    }
  }

  bool isAvailableInCart(String productId) {
    if (_cartItems.containsKey(productId)) {
      return _cartItems[productId]!.isItemInCart;
    } else {
      return false;
    }
  }

  int particularItemTotal(String productId) {
    return _cartItems[productId]!.quantity;
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
  }

  void removeSingleItem(String productId) {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
                isItemInCart: existingCartItem.isItemInCart,
              ));
    } else {
      _cartItems.remove(productId);
    }
  }

  void clear() {
    _cartItems = {};
  }
}

final cartNotifierProvider = NotifierProvider<Cart, Set<Product>>(() {
  return Cart();
});

Map<String, CartItem> _cartItems = {};

@riverpod
Map<String, CartItem> allCartItems(ref) {
  return _cartItems;
}
