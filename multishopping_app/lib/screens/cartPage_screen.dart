import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/cart.dart';
import 'package:multishopping_app/widgets/cart_Detail_items.dart';
import 'package:multishopping_app/widgets/placeOrder.dart';

class CartPageScreen extends ConsumerWidget {
  static final routeName = '/cartPageScreen';
  const CartPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    final cart = ref.read(cartNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Products"),
      ),
      body:  Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.allCartItems.length,
              itemBuilder: (ctx, i) => CartDetailItem(
                cart.allCartItems.values.toList()[i].id,
                cart.allCartItems.keys.toList()[i],
                cart.allCartItems.values.toList()[i].price,
                cart.allCartItems.values.toList()[i].quantity,
                cart.allCartItems.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
