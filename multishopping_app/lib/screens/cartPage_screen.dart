import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/cart.dart';
import 'package:multishopping_app/modules/order.dart';


class CartPageScreen extends ConsumerStatefulWidget {
  static final routeName = '/cartPageScreen';
  const CartPageScreen({super.key});

  @override
  ConsumerState<CartPageScreen> createState() => _CartPageScreenState();
}

class _CartPageScreenState extends ConsumerState<CartPageScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.read(cartNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Products"),
      ),
      body: Column(
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
                  TextButton(
                    onPressed: (cart.totalAmount <= 0)
                        ? null
                        : () {
                            setState(() {
                              ref.read(orderNotifierProvider.notifier).addOrder(
                                    cart.allCartItems.values.toList(),
                                    cart.totalAmount,
                                  );
                              cart.clear();
                            });
                          },
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.allCartItems.length,
              itemBuilder: (ctx, i) {
                final id = cart.allCartItems.values.toList()[i].id;
                final productId = cart.allCartItems.keys.toList()[i];
                final price = cart.allCartItems.values.toList()[i].price;
                final quantity = cart.allCartItems.values.toList()[i].quantity;
                final title = cart.allCartItems.values.toList()[i].title;
                return Dismissible(
                  key: ValueKey(id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text(
                          'Do you want to remove the item from the cart?',
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                          ),
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (direction) {
                    setState(() {
                      ref
                          .read(cartNotifierProvider.notifier)
                          .removeItem(productId);
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text('\$$price'),
                            ),
                          ),
                        ),
                        title: Text(title),
                        subtitle: Text('Total: \$${(price * quantity)}'),
                        trailing: Text('$quantity x'),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
