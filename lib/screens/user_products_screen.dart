import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/manage_product_screen.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const String routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of<Products>(context);

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ManageProductScreeen.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (_, int index) => Column(
            children: <Widget>[
              UserProductItemWidget(
                id: products.items[index].id,
                title: products.items[index].title,
                imageUrl: products.items[index].imageUrl,
                deleteCb: products
                    .deleteOne, // pass the delete function cb, dumb af as we're using prodivder already but whatev
              ),
              const Divider()
            ],
          ),
          itemCount: products.items.length,
        ),
      ),
    );
  }
}
