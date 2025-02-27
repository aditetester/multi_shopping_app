import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/products.dart';
import 'package:multishopping_app/screens/cartPage_screen.dart';
import 'package:multishopping_app/widgets/badgeView.dart';

class ProductsScreen extends ConsumerWidget {
  static final routeName = '/ProductScreen';
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryId = ModalRoute.of(context)?.settings.arguments as String;
    final allproducts = ref.watch(productProvider);
    final products = allproducts.where(
      (product) {
        return product.categories.contains(categoryId);
      },
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          BadgeView(
            value: '0',
            child: FittedBox(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
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
        itemBuilder: (ctx, i) => ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              products[i].imageUrl,
            ),
          ),
          title: Text(products[i].title),
          subtitle: Text(products[i].discription),
          onTap: () {},
        ),
      ),
    );
  }
}
