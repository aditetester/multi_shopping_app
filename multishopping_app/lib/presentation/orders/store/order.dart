import 'dart:convert';
import 'package:multishopping_app/presentation/cart/store/cart.dart';
import 'package:multishopping_app/presentation/products/store/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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

String _authToken = '';
String _userId = '';
List<OrderItem> _orders = [];

class Orders extends Notifier<Set<Product>> {
  @override
  Set<Product> build() {
    throw UnimplementedError();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    _orders = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('token').toString();
    _userId = prefs.getString('userid').toString();
    Uri url = Uri.parse(
        'https://shoppingapp-e1541-default-rtdb.firebaseio.com/orders/$_userId.json?auth=$_authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData.isEmpty) {
      return ;
    } else {
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ),
                )
                .toList(),
          ),
        );
      });
      _orders = loadedOrders.reversed.toList();
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('token').toString();
    _userId = prefs.getString('userid').toString();
    Uri url = Uri.parse(
        'https://shoppingapp-e1541-default-rtdb.firebaseio.com/orders/$_userId.json?auth=$_authToken');

    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
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
