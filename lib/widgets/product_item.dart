import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // ListTile equivalent
    return GridTile(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
      // footer bar widget
      footer: GridTileBar(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black54,
        leading: const IconButton(
          icon: Icon(Icons.favorite),
          onPressed: null,
        ),
        trailing: const IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: null,
        ),
      ),
    );
  }
}
