import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  static const String routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    // find the item that matches the id from the products provider
    // final Product product = Provider.of<Products>(context).findById(id);

    // to make this one and done kind of thing
    // put listen to false and don't rebuild when provider changes stuff
    // good it we don't care for immediate updates and additional renders when stuff we don't even need changes
    final Product product =
        Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
