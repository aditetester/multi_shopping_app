import 'package:multishopping_app/modules/cart.dart';
import 'package:multishopping_app/modules/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'orders.g.dart';


class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

List<OrderItem> _orders = [];

class Orders extends Notifier<Set<Product>> {
  @override
  Set<Product> build() {
    throw UnimplementedError();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
  }
}

final orderNotifierProvider = NotifierProvider<Orders, Set<Product>>(() {
  return Orders();
});

@riverpod
List<OrderItem> allOrderItems(ref) {
  return _orders;
}

