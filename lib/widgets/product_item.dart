import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get the product info from the provider
    final Product product = Provider.of<Product>(context);
    final CartProvider cart = Provider.of<CartProvider>(context);

    // ListTile equivalent
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          // footer bar widget
          footer: GridTileBar(
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavorite();
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(
                    id: product.id, title: product.title, price: product.price);
                // scaffold.of(context) establishes a connection to the nearest Scaffold widget
                // nearest Scaffold from here, is products_overview's Scaffold
                // can control that scaffold from here!
                // Scaffold.of(context).openDrawer();

                // deprecated
                // Scaffold.of(context).showSnackBar(SnackBar(content: Container()));

                // ScaffoldMessender connects to the nearest Scaffold
                // SnackBar is just an alert message

                // duration can be managed with Duration widget
                // actions are additional functionality that can be added
                // expects label and a callback, common thing -> undo action

                // hiding the currenlty present snackbar cause if the user spams the button
                // the bars should cancel the previous one and show themselves immediately
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Item added to cart'),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.decrementItemQuantity(product.id);
                      }),
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
