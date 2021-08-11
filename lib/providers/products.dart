import 'package:flutter/cupertino.dart';
import 'package:shop_app/data/products_dummy_data.dart';
import 'package:shop_app/providers/product.dart';

// NOTE: dart only supports one parent to be extend
// mixins don't make a stong relation, just allows additional functions
// and properties to a class
class Products with ChangeNotifier {
  // used down in the code to make getter fetch favorited content or not
  // meant for an application-wide filter
  // not to be used when needing stuff filtered only on one screen
  bool _showFavorites = false;

  final List<Product> _items = productDummyData;

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

  void addOne(Product product) {
    // _items.add(value);
    // telling widgets that hold a ref to our state that stuff is changing
    final Product newProduct = Product(
        id: product.id,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
    _items.add(product);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((Product element) => element.id == id);
  }

  // idk about this one chief
  // maybe it's good form the immutability point of view
  void updateOne(String id, Product updatedProduct) {
    final int index = _items.indexWhere((Product element) => element.id == id);
    if (index >= 0) {
      _items[index] = updatedProduct;
      notifyListeners();
    } else {
      // throw some errors, idk
      return;
    }
  }

  void deleteOne(String id) {
    _items.removeWhere((Product element) => element.id == id);
    notifyListeners();
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
