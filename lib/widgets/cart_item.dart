import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.cartItemId,
  }) : super(key: key);
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String cartItemId;

  @override
  Widget build(BuildContext context) {
    // widget used to dismiss things
    // widgets dismissed like this aren't wiped from any state, just UI
    return Dismissible(
      key: ValueKey<String>(id),
      // optional: specify the direction of swipe
      // very natural to use endToStart (->) swipe motion
      direction: DismissDirection.endToStart,
      // provides with the direction the user swiped
      // useful when different swipes cause different results
      onDismissed: (DismissDirection direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItem(cartItemId);
      },
      // background is the layer behind the Dismissable's child
      // this is where colors, additional info etc. can be shown
      background: Container(
        color: Theme.of(context).primaryColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        // cause the child has a margin the background is bigger than it
        // here the margins are matched so it appears as if the background is precisely behind it
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),

        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(title),
            subtitle: Text('Total: ${price * quantity} \$'),
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: FittedBox(child: Text('$price \$')),
              ),
            ),
            trailing: Text('$quantity x'),
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
      ),
    );
  }
}
