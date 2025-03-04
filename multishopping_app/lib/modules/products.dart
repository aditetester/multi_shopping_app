import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
part 'products.g.dart';

class Product {
  final String id;
  final String imageUrl;
  final String title;
  final String discription;
  final double price;
  final List<dynamic> categories;

  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.discription,
    required this.price,
    required this.categories,
  });
}

String _authToken = '';
List<Product> _items = [];

class Products extends Notifier<Set<Product>> {
  @override
  Set<Product> build() {
    throw UnimplementedError();
  }

  List<Product> findById(String id) {
    return _items.where((prod) => prod.categories.contains(id)).toList();
  }

  int findtotal() {
    return _items.length;
  }

  Future<void> fetchAndSetProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('token').toString();

    Uri url = Uri.parse(
        'https://shoppingapp-e1541-default-rtdb.firebaseio.com/products.json?auth=$_authToken');

    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData.isEmpty) {
        return;
      }

      List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          categories: (prodData['categories']['id'] as List<dynamic>),
          title: prodData['title'],
          discription: prodData['discription'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
        ));
      });

      _items = loadedProducts;
    } catch (error) {
      rethrow;
    }
  }
}

final productNotifierProvider = NotifierProvider<Products, Set<Product>>(() {
  return Products();
});

@riverpod
List<Product> allProduct(ref) {
  return _items;
}
