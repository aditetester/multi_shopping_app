import 'package:multishopping_app/modules/Product_module.dart';
import 'package:multishopping_app/modules/cart_module.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cart.g.dart';

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
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (oldvalue) => CartItem(
          id: oldvalue.id,
          title: oldvalue.title,
          price: oldvalue.price,
          quantity: oldvalue.quantity + 1,
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
        ),
      );
    }
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
Map<String, CartItem> allCartItemd(ref) {
  return _cartItems;
}