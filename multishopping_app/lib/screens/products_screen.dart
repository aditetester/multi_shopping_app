import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/cart.dart';
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

    void addToCart(Product prod) {
      setState(() {
        ref
            .read(cartNotifierProvider.notifier)
            .addItems(prod.id, prod.title, prod.price);
      });

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added item to cart!',
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              setState(() {
                ref
                    .read(cartNotifierProvider.notifier)
                    .removeSingleItem(prod.id);
              });
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.pop(context,'refresh');
        },),
        title: Text("Products"),
        actions: [
          BadgeView(
            value:
                ref.read(cartNotifierProvider.notifier).itemCount.toString(),
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
          onTap: () {},
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
            onPressed: () => addToCart(products[i]),
            child: Text("Add to Cart"),
          ),
        ),
      ),
    );
  }
}
