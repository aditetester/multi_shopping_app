import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/presentation/products/store/products.dart';
import 'package:multishopping_app/presentation/cart/cartPage_screen.dart';
import 'package:multishopping_app/presentation/cart/widgets/badgeView.dart';
import 'package:multishopping_app/presentation/products/widgets/productItems.dart';
import 'package:multishopping_app/presentation/cart/store/cart.dart';

class ProductsScreen extends ConsumerWidget {
  static final routeName = '/ProductScreen';

  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryId = ModalRoute.of(context)?.settings.arguments as String;
    final products =
        ref.watch(productNotifierProvider.notifier).findById(categoryId);

    final cart = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'refresh');
          },
        ),
        title: Text("Products"),
        actions: [
          BadgeView(
            value: cart.length
                .toString(), 
            child: FittedBox(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                tooltip: 'Shopping Cart',
                onPressed: () {
                  Navigator.of(context).pushNamed(CartPageScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) =>
            ProductItem(product: products[i]),
      ),
    );
  }
}
