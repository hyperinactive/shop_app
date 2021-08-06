import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({Key? key, required this.showFavorites})
      : super(key: key);
  final bool showFavorites;

  @override
  Widget build(BuildContext context) {
    // make a connection to the provided instance of the Products class
    // provider instance must be in scope
    final Products productsData = Provider.of<Products>(context);

    // ternary to decide if favorites filter has been applied
    // use appropriate getter
    final List<Product> products = !showFavorites
        ? productsData.items
        : productsData.favoriteItems; // getter for the items
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      // fixed will squeeze enough items to fill the number of rows given
      // extend tries to fill based on the size of its compoonents
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) =>
          ChangeNotifierProvider<Product>.value(
        value: products[index],
        child: const ProductItem(),
      ),
      // return a product item, provider a product per build
      itemCount: products.length,
    );
  }
}
