import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const String routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            // special inputs already connected to the form with properties like autocorrect, validaste etc
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              // means instead of submitting the focus will shift to the next input
              // required TextInputAction
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      )),
    );
  }
}
