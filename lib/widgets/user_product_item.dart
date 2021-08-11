import 'package:flutter/material.dart';
import 'package:shop_app/screens/manage_product_screen.dart';

class UserProductItemWidget extends StatelessWidget {
  const UserProductItemWidget(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.id,
      required this.deleteCb})
      : super(key: key);

  final String id;
  final String title;
  final String imageUrl;
  final Function deleteCb;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      // background image requires an image provider!
      // Network image provider requires just a string with the url
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ManageProductScreeen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {
                deleteCb(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
