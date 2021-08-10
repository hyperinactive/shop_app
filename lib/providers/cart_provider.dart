import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItemModel> _items = <String, CartItemModel>{};

  Map<String, CartItemModel> get items {
    return <String, CartItemModel>{..._items};
  }

  // check if an item has already been added
  // if so increment its quantity
  // else add it to the cart provider's map
  void addItem({
    required String id,
    required String title,
    required double price,
  }) {
    if (_items.containsKey(id)) {
      // update gives the previous object in its callback
      _items.update(
          id,
          (CartItemModel prevItem) => CartItemModel(
                id: prevItem.id,
                title: prevItem.title,
                quantity: prevItem.quantity + 1,
                price: prevItem.price,
              ));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItemModel(
                id: const Uuid().v4(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmout {
    double total = 0.0;
    // go through items and calculate the total
    _items.forEach((_, CartItemModel cart) {
      total += cart.price * cart.quantity;
    });
    return total;
  }

  // removes an item form the map via id
  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void decrementItemQuantity(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    // if the product item exists in the cart and its quantity is greated than 1
    if (_items[id]!.quantity > 1) {
      _items.update(
          id,
          (CartItemModel previousCartItem) => CartItemModel(
                id: previousCartItem.id,
                title: previousCartItem.title,
                quantity: previousCartItem.quantity - 1,
                price: previousCartItem.price,
              ));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clear() {
    _items = <String, CartItemModel>{};
    notifyListeners();
  }
}
