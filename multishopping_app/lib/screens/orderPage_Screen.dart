import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/cart.dart';
import 'package:multishopping_app/modules/order.dart';
import 'package:multishopping_app/screens/cartPage_screen.dart';
import 'package:multishopping_app/screens/tabView_screen.dart';
import 'package:multishopping_app/widgets/badgeView.dart';
import 'package:multishopping_app/widgets/order_detail_item.dart';

class OrderPageScreen extends ConsumerStatefulWidget {
  const OrderPageScreen({super.key});

  @override
  ConsumerState<OrderPageScreen> createState() => _OrderPageScreenState();
}

class _OrderPageScreenState extends ConsumerState<OrderPageScreen> {
  @override
  Widget build(BuildContext context) {
    final orderData = ref.read(orderNotifierProvider.notifier);

    final appBarView = AppBar(
      title: Text("Your Orders"),
      actions: [
        BadgeView(
          value: ref.read(cartNotifierProvider.notifier).itemCount.toString(),
          child: FittedBox(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              tooltip: 'Shopping Cart',
              onPressed: () async {
                final refresh = await Navigator.of(context)
                    .pushNamed(CartPageScreen.routeName);
                if (refresh == 'refresh') {
                  Navigator.of(context)
                      .popAndPushNamed(TabViewScreen.routeName);
                } else {
                  Navigator.of(context)
                      .popAndPushNamed(TabViewScreen.routeName);
                }
              },
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: appBarView,
      body: FutureBuilder(
        future: ref.read(orderNotifierProvider.notifier).fetchAndSetOrders(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? orderData.orders.length.toString() != '0'
                  ? ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, i) =>
                          OrderDetailItem(orderData.orders[i]),
                    )
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Icon(
                              Icons.content_paste_search_outlined,
                              size: 100,
                            ),
                          ),
                          Container(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Order Placed Yet..!",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
