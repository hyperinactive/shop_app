import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    // cause the row is using alignment of space-between
                    // extra space is being placed between these 3 widgets
                    // to have lavel on the left and these 2 on the right
                    // adding a spacer which will slurp up all the available space
                    // and force these 2 to squish together
                    const Spacer(),
                    // pretty label widget
                    Chip(
                      label: Text(
                        '${cart.totalAmout} \$',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      onPressed: () {
                        // add all items from the cart into an order
                        // clear the cart as the orders aren't there anymore
                        Provider.of<OrdersProvider>(context, listen: false)
                            .addOrder(
                                cart.items.values.toList(), cart.totalAmout);
                        cart.clear();
                      },
                      child: Text(
                        'Order!',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) => CartItemWidget(
              // converting map to list
              id: cart.items.values
                  .toList()[index]
                  .id, // id of an individaul product
              title: cart.items.values.toList()[index].title,
              price: cart.items.values.toList()[index].price,
              quantity: cart.items.values.toList()[index].quantity,
              cartItemId:
                  cart.items.keys.toList()[index], // id of the "global" product
            ),
            itemCount: cart.itemCount,
          ))
        ],
      ),
    );
  }
}
