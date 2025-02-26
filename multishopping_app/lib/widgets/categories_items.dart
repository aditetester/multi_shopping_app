import 'package:flutter/material.dart';

class CategoriesItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;

  const CategoriesItem(this.id, this.title, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).pushNamed(
          //   ProductViewScreen.routeName,
          //   arguments: singleProduct.id,
          // );
        },
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          child: Image.network(
            image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
