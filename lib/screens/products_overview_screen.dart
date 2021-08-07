import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/widgets/cart_icon_button.dart';
import 'package:shop_app/widgets/products_grid_view.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    // final Products productsProvider =
    //     Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          // overlay button widget
          PopupMenuButton<dynamic>(
            onSelected:
                // TODO(me): type casting
                // for some reason the onSelected doesn't accept FilterOptions
                // type casting problem
                (dynamic selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  // show favs
                  // set the favorites to true
                  _showFavoritesOnly = true;
                } else {
                  // show all
                  // set the favorites to false
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => <PopupMenuItem<dynamic>>[
              const PopupMenuItem<dynamic>(
                child: Text('Favorites'),
                value: FilterOptions.Favorites, // 0
              ),
              const PopupMenuItem<dynamic>(
                child: Text('All'),
                value: FilterOptions.All, // 1
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          // because I don't want to rerender the whole page by calling a provider up top
          // using the consumer so if changes happen, only its child gets rebuilt
          Consumer<CartProvider>(
            builder: (_, CartProvider cart, Widget? consumerChild) =>
                CartIconButton(
              child: consumerChild as Widget,
              value: cart.itemCount.toString(),
            ),
            // consumerChild is the IconButton
            // it won't rebuild cause it's outside of the builder method
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ProductsGridView(
        showFavorites: _showFavoritesOnly,
      ),
    );
  }
}
