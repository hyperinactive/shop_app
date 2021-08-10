import 'package:flutter/material.dart';

class UserProductItemWidget extends StatelessWidget {
  const UserProductItemWidget(
      {Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  final String title;
  final String imageUrl;

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
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
