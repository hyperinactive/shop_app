import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:uuid/uuid.dart';

class ManageProductScreeen extends StatefulWidget {
  const ManageProductScreeen({Key? key}) : super(key: key);
  static const String routeName = '/edit-product';

  @override
  _ManageProductScreeenState createState() => _ManageProductScreeenState();
}

class _ManageProductScreeenState extends State<ManageProductScreeen> {
  bool _isNew = true;

  // in flutter some managing of the form inputs is required
  // FocusNode enables focusing
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _imageFocus = FocusNode();

  final TextEditingController _imageUrlController = TextEditingController();

  // lets us interact with the form
  // form key needs to be added to the form to make the connection
  final GlobalKey<FormState> _formGK = GlobalKey<FormState>();

  final Map<String, dynamic> _productMap = <String, dynamic>{
    'title': '',
    'description': '',
    'imageUrl': '',
    'price': 0
  };

  bool _isLoading = false;

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

  Future<void> _saveForm() async {
    final bool isValid = _formGK.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formGK.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    final Products products = Provider.of<Products>(context, listen: false);

    if (_isNew) {
      final Product product = Product(
        id: const Uuid().v4(),
        title: _productMap['title'] as String,
        description: _productMap['description'] as String,
        price: _productMap['price'] as double,
        imageUrl: _productMap['imageUrl'] as String,
      );

      try {
        await products.addOne(product);
      } catch (e) {
        // ignore: implicit_dynamic_function
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('An error occured'),
                  content: const Text('Something went wrong'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('ok'))
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
      // await products.addOne(product).catchError((Object error) {
      //   // ignore: implicit_dynamic_function
      //   return showDialog(
      //       context: context,
      //       builder: (BuildContext context) => AlertDialog(
      //             title: const Text('An error occured'),
      //             content: const Text('Something went wrong'),
      //             actions: <Widget>[
      //               TextButton(
      //                   onPressed: () {
      //                     Navigator.of(context).pop();
      //                   },
      //                   child: const Text('ok'))
      //             ],
      //           ));
      // })
      // .then((_) {
      // setState(() {
      //   _isLoading = false;
      // });
      // Navigator.of(context).pop();
      // });
    } else {
      // update the product
      final Product product = Product(
          id: _productMap['id'] as String,
          title: _productMap['title'] as String,
          description: _productMap['description'] as String,
          price: _productMap['price'] as double,
          imageUrl: _productMap['imageUrl'] as String,
          isFavorite: _productMap['isFavorite'] as bool);
      products.updateOne(_productMap['id'] as String, product);
    }

    // return to the previous screen on the stack
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // setting up a listener upon creating the state
    // this listener will be used to tell when user switched focus off the image input
    _imageFocus.addListener(_updateImage);
    super.initState();
  }

  // hacky way of using Modal to extract ags from the pushNamed mehtod
  // cannot be done in the initState but it can be done inside didChangeDependencies
  // to limit the number of calls for this to one, a bool is set up to ensure that
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      String productId = '';
      // if args have been passed update productId
      // don't make a new product but update an existing one via its id
      if (ModalRoute.of(context) != null &&
          ModalRoute.of(context)!.settings.arguments != null) {
        productId = ModalRoute.of(context)!.settings.arguments as String;
        _isNew = false;
        final Product fProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        // fill the map with the data of the product to edit
        _productMap['id'] = fProduct.id;
        _productMap['title'] = fProduct.title;
        _productMap['description'] = fProduct.description;
        _productMap['price'] = fProduct.price;
        _productMap['isFavorite'] = fProduct.isFavorite;
        _imageUrlController.text = fProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
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
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formGK,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  children: <Widget>[
                    // special inputs already connected to the form with properties like autocorrect, validaste etc
                    TextFormField(
                      initialValue: _productMap['title'] as String,
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
                      initialValue: _productMap['price'].toString(),
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
                      initialValue: _productMap['description'] as String,
                      validator: _validateLength,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
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
                                  child:
                                      Image.network(_imageUrlController.text),
                                ),
                        ),
                        Expanded(
                            // TextFormField takes as much space as it can
                            // needs a constrained parent
                            child: TextFormField(
                          // have to be initialized in the controller
                          // initialValue: _productMap['imageUrl'] as String,
                          validator: _validateUrl,
                          decoration:
                              const InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction:
                              TextInputAction.done, // no more inputs
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
              ),
            ),
    );
  }
}
