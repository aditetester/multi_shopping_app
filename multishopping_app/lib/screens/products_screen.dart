import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/products.dart';
import 'package:multishopping_app/screens/cartPage_screen.dart';
import 'package:multishopping_app/widgets/badgeView.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  static final routeName = '/ProductScreen';
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context)?.settings.arguments as String;
    final products =
        ref.read(productNotifierProvider.notifier).findById(categoryId);
    final total = ref.read(productNotifierProvider.notifier).findtotal();

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          BadgeView(
            value: total.toString(),
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
          title: Text(
            products[i].title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(products[i].discription),
              Text(
                '\$ ${products[i].price}',
                style: TextStyle(),
              ),
            ],
          ),
          trailing: TextButton(
            onPressed: () {},
            child: Text("Add to Cart"),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
