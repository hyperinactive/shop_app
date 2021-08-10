import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import 'package:shop_app/themes/theme_data.dart';

void main() {
  runApp(MyApp(key: UniqueKey()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // can use many providers
    // changenotifier creates a provider based on a class provided
    // return ChangeNotifierProvider.value(value: Products()) // can be used when context isn't depended on
    // recommendation, use create approach when instantiating once, but for repetative items, use value instead

    // settings up multiple providers
    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<Products>(create: (_) => Products()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<OrdersProvider>(create: (_) => OrdersProvider()),
      ],
      child: MaterialApp(
        title: 'ShopShop',
        theme: themeData,
        home: ProductsOverviewScreen(key: UniqueKey()),
        routes: <String, WidgetBuilder>{
          ProductDetailScreen.routeName: (BuildContext context) =>
              const ProductDetailScreen(),
          CartScreen.routeName: (BuildContext context) => const CartScreen(),
          OrdersScreen.routeName: (BuildContext context) =>
              const OrdersScreen(),
          UserProductsScreen.routeName: (BuildContext context) =>
              const UserProductsScreen(),
          EditProductScreen.routeName: (BuildContext context) =>
              const EditProductScreen()
        },
      ),
    );
  }
}
