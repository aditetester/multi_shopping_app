import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/products.dart';
import 'package:multishopping_app/screens/products_screen.dart';
import 'package:multishopping_app/screens/tabView_screen.dart';

class CategoriesItem extends ConsumerStatefulWidget {
  final String id;
  final String title;
  final String image;

  const CategoriesItem(this.id, this.title, this.image, {super.key});

  @override
  ConsumerState<CategoriesItem> createState() => _CategoriesItemState();
}

class _CategoriesItemState extends ConsumerState<CategoriesItem> {
  @override
  void initState() {
    ref.read(productNotifierProvider.notifier).fetchAndSetProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void productView() async {
      final refresh = await Navigator.of(context).pushNamed(
        ProductsScreen.routeName,
        arguments: widget.id,
      );
      if (refresh == 'refresh') {
        Navigator.of(context).popAndPushNamed(TabViewScreen.routeName);
      } else {
        Navigator.of(context).popAndPushNamed(TabViewScreen.routeName);
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => productView(),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          child: Hero(
            tag: widget.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
