import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/themes/theme_data.dart';

void main() {
  runApp(MyApp(key: UniqueKey()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopShop',
      theme: themeData,
      home: ProductsOverviewScreen(key: UniqueKey()),
      routes: {
        ProductDetailScreen.routeName: (BuildContext context) =>
            ProductDetailScreen()
      },
    );
  }
}
