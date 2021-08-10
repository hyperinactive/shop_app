import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
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
      // add a confirmation step to dismiss stuff
      // explects a Future<bool>
      // showDialog conveniently returns a Future as well, so it can be used here
      // resolving with a true will dismiss the item, false will cancel the attempt to dismiss it
      confirmDismiss: (DismissDirection direction) {
        // show dialog modasl and attach it to the Dissmisible
        return showDialog<bool>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Are your sure?'),
                  content: const Text('remove item from the cart?'),
                  actions: <Widget>[
                    // onPressed -> here I can controll what gets resolved in the Future
                    // and make it "fit" what confirmDismiss needs, a Future<bool>
                    TextButton(
                        onPressed: () {
                          // pop returns a Future that will resolve and return data if I so choose
                          // returning true to match the bool type - the user pressed yes -> true
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('YES')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('NO')),
                  ],
                ));
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
