import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/products.dart';
import 'package:multishopping_app/modules/cart.dart';

class ProductItem extends ConsumerWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartNotifierProvider);
    final cartNotifier =
        ref.read(cartNotifierProvider.notifier); 

    void removeItem() {
      cartNotifier.removeSingleItem(product.id);
    }

    void addToCart() {
      cartNotifier.addItems(product.id, product.title, product.price);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item Added to Cart!'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(label: 'UNDO', onPressed: removeItem),
        ),
      );
    }

    final isInCart = cart.containsKey(product.id);
    final quantity = cart[product.id]?.quantity ?? 0;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(
        product.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.discription),
          Text('\$ ${product.price}', style: TextStyle()),
        ],
      ),
      trailing: isInCart
          ? FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: addToCart,
                    icon: Icon(Icons.add),
                  ),
                  Text("$quantity"),
                  IconButton(
                    onPressed: removeItem,
                    icon: Icon(Icons.remove),
                  )
                ],
              ),
            )
          : TextButton(
              onPressed: addToCart,
              child: Text("Add to Cart"),
            ),
    );
  }
}
