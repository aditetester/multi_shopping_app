import 'package:flutter/widgets.dart';


class Product with ChangeNotifier {
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
