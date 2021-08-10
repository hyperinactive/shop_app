import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const String routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // in flutter some managing of the form inputs is required
  // FocusNode enables focusing
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _imageFocus = FocusNode();

  final TextEditingController _imageUrlController = TextEditingController();

  // lets us interact with the form
  // form key needs to be added to the form to make the connection
  final GlobalKey<FormState> _formGK = GlobalKey<FormState>();

  final Map<String, dynamic> _productMap = <String, dynamic>{};

  // expected to fire when _imageFocus looses focus
  // checking if focus if on the node
  // if node, reresh the state and rerender, thus showing the image from the url
  void _updateImage() {
    if (!_imageFocus.hasFocus) {
      setState(() {});
    }
  }

  String? _validateEmpty(String? value) {
    if (value!.isEmpty) {
      return 'input cannot be empty';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    _validateEmpty(value);
    if (double.tryParse(value!) == null) {
      return 'not a number';
    }
    if (double.parse(value) <= 0) {
      return 'price must be greater than 0';
    }
    return null;
  }

  String? _validateLength(String? value) {
    _validateEmpty(value);
    if (value!.length < 10 && value.length > 30) {
      return 'description must be between 10 and 30 characters';
    }
    return null;
  }

  // weak validator, purely for demo purposes
  String? _validateUrl(String? value) {
    _validateEmpty(value);

    if (!value!.startsWith('http') || !value.startsWith('https')) {
      return 'invalid image url';
    }
    return null;
  }

  void _saveForm() {
    final bool isValid = _formGK.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formGK.currentState!.save();
    print(_productMap);
  }

  @override
  void initState() {
    // setting up a listener upon creating the state
    // this listener will be used to tell when user switched focus off the image input
    _imageFocus.addListener(_updateImage);
    super.initState();
  }

  @override
  void dispose() {
    // using focus nodes causes memory leaks if not disposed
    // make sure to remember to clear those
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlController.dispose();

    // listeners must also be removed
    _imageFocus.removeListener(_updateImage);
    _imageFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Form(
          key: _formGK,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: <Widget>[
                // special inputs already connected to the form with properties like autocorrect, validaste etc
                TextFormField(
                  validator: _validateEmpty,
                  decoration: const InputDecoration(labelText: 'Title'),
                  // means instead of submitting the focus will shift to the next input
                  // required TextInputAction
                  textInputAction: TextInputAction.next,
                  // whenever the 'finished' button fires
                  onFieldSubmitted: (_) {
                    // FocusScope used for switching focus
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (String? title) {
                    _productMap['title'] = title;
                  },
                ),
                TextFormField(
                  validator: _validatePrice,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocus, // add focus node
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  onSaved: (String? price) {
                    _productMap['price'] = double.parse(price!);
                  },
                ),
                TextFormField(
                  validator: _validateLength,
                  decoration: const InputDecoration(labelText: 'Description'),
                  // adding more lines for the user to use
                  maxLines: 3,
                  // keyboard suited for multiline input
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  focusNode: _descriptionFocus,
                  onSaved: (String? description) {
                    _productMap['description'] = description;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('enter a URL')
                          : FittedBox(
                              // note: doesn't check for valid urls
                              child: Image.network(_imageUrlController.text),
                            ),
                    ),
                    Expanded(
                        // TextFormField takes as much space as it can
                        // needs a constrained parent
                        child: TextFormField(
                      validator: _validateUrl,
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done, // no more inputs
                      // form handles input controllers
                      // but cause image must be previewed, we need access to the controller of this input
                      controller: _imageUrlController,
                      focusNode: _imageFocus,
                      // onEditingComplete: () {
                      //   setState(() {});
                      // },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (String? imageUrl) {
                        _productMap['imageUrl'] = imageUrl;
                      },
                    )),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
