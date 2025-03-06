import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/cart.dart';
import 'package:multishopping_app/modules/order.dart';
import 'package:multishopping_app/widgets/cart_items.dart';

class CartPageScreen extends ConsumerWidget {
  static const routeName = '/cartPageScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartNotifierProvider); 
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final cartItems = cart.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartNotifier.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: (cartNotifier.totalAmount <= 0)
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Cart is Empty..!'), duration: Duration(seconds: 2)),
                            );
                          }
                        : () {
                            ref.read(orderNotifierProvider.notifier).addOrder(
                                  cartItems,
                                  cartNotifier.totalAmount,
                                );
                            cartNotifier.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Order Placed Successfully..!'), duration: Duration(seconds: 2)),
                            );
                          },
                    child: Text('ORDER NOW'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, i) => CartItemWidget(cartItem: cartItems[i]),
            ),
          ),
        ],
      ),
    );
  }
}
