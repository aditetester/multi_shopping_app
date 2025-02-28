import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/category.dart';
import 'package:multishopping_app/screens/tabView_screen.dart';
import 'package:multishopping_app/widgets/categories_items.dart';
import 'package:multishopping_app/modules/cart.dart';
import 'package:multishopping_app/screens/cartPage_screen.dart';
import 'package:multishopping_app/widgets/badgeView.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarView = AppBar(
      title: Text("Multishopping App"),
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
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 2.4 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: DUMMY_CATEGORIES
              .map((e) => CategoriesItem(
                    e.id,
                    e.title,
                    e.image,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
