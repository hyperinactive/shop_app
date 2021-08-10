import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildDrawerListTile(
    BuildContext context,
    IconData iconData,
    String title,
    String routeName,
  ) {
    return Column(
      children: <Widget>[
        const Divider(),
        ListTile(
          leading: Icon(iconData),
          title: Text(title),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(routeName);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('placeholder'),
            automaticallyImplyLeading: false, // no back button
          ),
          buildDrawerListTile(
            context,
            Icons.shop,
            'Shop',
            '/',
          ),
          buildDrawerListTile(
            context,
            Icons.payment,
            'Orders',
            OrdersScreen.routeName,
          ),
          buildDrawerListTile(
            context,
            Icons.edit,
            'Manage products',
            UserProductsScreen.routeName,
          )
        ],
      ),
    );
  }
}
