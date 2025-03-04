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
  final List<String> categories;

  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.discription,
    required this.price,
    required this.categories,
  });
}

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
    authToken = prefs.getString('token').toString();

    Uri url = Uri.parse(
        'https://shoppingapp-e1541-default-rtdb.firebaseio.com/products.json?auth=$authToken');

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
          categories: ['c1'],
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

String authToken = '';
List<Product> _items = [
//   Product(
//     id: 'p1',
//     categories: [
//       'c1',
//     ],
//     title: 'Red Shirt',
//     discription: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//   ),
//   Product(
//     id: 'p2',
//     categories: [
//       'c1',
//       'c2',
//     ],
//     title: 'Trousers',
//     discription: 'A nice trousers.',
//     price: 59.99,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//   ),
//   Product(
//     id: 'p3',
//     categories: [
//       'c2',
//     ],
//     title: 'Yellow Scarf',
//     discription: 'Warm and cozy - exactly what you need for the winter.',
//     price: 19.99,
//     imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//   ),
//   Product(
//     id: 'p4',
//     categories: [
//       'c4',
//     ],
//     title: 'A Pan',
//     discription: 'Prepare any meal you want.',
//     price: 49.99,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//   ),
//   Product(
//     id: 'p5',
//     categories: [
//       'c1',
//     ],
//     title: 'Blue Shirt',
//     discription: 'A Blue shirt - it is pretty Blue!',
//     price: 29.99,
//     imageUrl: 'https://5.imimg.com/data5/AP/HE/MY-13283794/casual-shirt.jpg',
//   ),
//   Product(
//     id: 'p6',
//     categories: [
//       'c1',
//     ],
//     title: 'Pents',
//     discription: 'A Fabric Pents - it is Formal wear!',
//     price: 29.99,
//     imageUrl:
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7aGNrO9rUl7F1Px2mjSFMzpzCuaKXboUIwg&s',
//   ),
//   Product(
//       id: 'p7',
//       categories: [
//         'c3',
//       ],
//       title: 'Shoes',
//       discription: 'A nice ports shoes..!',
//       price: 29.99,
//       imageUrl:
//           'https://media.istockphoto.com/id/1350560575/photo/pair-of-blue-running-sneakers-on-white-background-isolated.jpg?s=612x612&w=0&k=20&c=A3w_a9q3Gz-tWkQL6K00xu7UHdN5LLZefzPDp-wNkSU='),
];

final productNotifierProvider = NotifierProvider<Products, Set<Product>>(() {
  return Products();
});

@riverpod
List<Product> allProduct(ref) {
  return _items;
}
