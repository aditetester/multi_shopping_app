import 'package:flutter/material.dart';

class CartPageScreen extends StatelessWidget {
  static final routeName = '/cartPageScreen';
  const CartPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Products"),
      ),
      body: Center(
        child: Text("Cart Screen"),
      ),
    );
  }
}
