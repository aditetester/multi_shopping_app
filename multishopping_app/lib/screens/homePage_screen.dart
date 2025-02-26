import 'package:flutter/material.dart';
import 'package:multishopping_app/modules/category.dart';
import 'package:multishopping_app/widgets/categories_items.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 2.7 / 3,
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
    );
  }
}
