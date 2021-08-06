import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/product.dart';

// NOTE: dart only supports one parent to be extend
// mixins don't make a stong relation, just allows additional functions
// and properties to a class
class Products with ChangeNotifier {
  // used down in the code to make getter fetch favorited content or not
  // meant for an application-wide filter
  // not to be used when needing stuff filtered only on one screen
  bool _showFavorites = false;

  final List<Product> _items = <Product>[
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    // return a copy, respect the immutability
    // if (_showFavorites) {
    //   return _items
    //       .where((Product element) => element.isFavorite == true)
    //       .toList();
    // }
    return <Product>[..._items];
  }

  List<Product> get favoriteItems {
    return _items
        .where((Product element) => element.isFavorite == true)
        .toList();
  }

  void addProduct() {
    // _items.add(value);
    // telling widgets that hold a ref to our state that stuff is changing
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((Product element) => element.id == id);
  }

  void showFavoritesOnly() {
    _showFavorites = true;
    notifyListeners();
  }

  void showAll() {
    _showFavorites = false;
    notifyListeners();
  }
}
