import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Product_module.dart';

class Products with ChangeNotifier {
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void toggleTask(Product task) {
    task.togalfavchange();
    notifyListeners();
  }

  void addProduct() {
    notifyListeners();
  }
}

final List<Product> _items = [
  Product(
    id: 'p1',
    categories: [
      'c1',
    ],
    title: 'Red Shirt',
    discription: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
  Product(
    id: 'p2',
    categories: [
      'c1',
      'c2',
    ],
    title: 'Trousers',
    discription: 'A nice of trousers.',
    price: 59.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  ),
  Product(
    id: 'p3',
    categories: [
      'c2',
    ],
    title: 'Yellow Scarf',
    discription: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  ),
  Product(
    id: 'p4',
    categories: [
      'c4',
    ],
    title: 'A Pan',
    discription: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  ),
  Product(
    id: 'p5',
    categories: [
      'c1',
    ],
    title: 'Blue Shirt',
    discription: 'A Blue shirt - it is pretty Blue!',
    price: 29.99,
    imageUrl: 'https://5.imimg.com/data5/AP/HE/MY-13283794/casual-shirt.jpg',
  ),
  Product(
    id: 'p6',
    categories: [
      'c1',
    ],
    title: 'Pents',
    discription: 'A Fabric Pents - it is Formal wear!',
    price: 29.99,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7aGNrO9rUl7F1Px2mjSFMzpzCuaKXboUIwg&s',
  ),
  Product(
      id: 'p7',
      categories: [
        'c3',
      ],
      title: 'Shoes',
      discription: 'A nice ports shoes..!',
      price: 29.99,
      imageUrl:
          'https://media.istockphoto.com/id/1350560575/photo/pair-of-blue-running-sneakers-on-white-background-isolated.jpg?s=612x612&w=0&k=20&c=A3w_a9q3Gz-tWkQL6K00xu7UHdN5LLZefzPDp-wNkSU='),
];

Product findById(String id) {
  return _items.firstWhere((prod) => prod.id == id);
}

final productProvider = Provider((ref) {
  return _items;
});

final favourateProducts = Provider((ref) {
  return _items.where((prod) => prod.isFavourate).toList();
});
