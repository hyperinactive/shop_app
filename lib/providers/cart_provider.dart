import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Cart> _items = <String, Cart>{};

  Map<String, Cart> get items {
    return <String, Cart>{..._items};
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
          (Cart prevItem) => Cart(
                id: prevItem.id,
                title: prevItem.title,
                quantity: prevItem.quantity + 1,
                price: prevItem.price,
              ));
    } else {
      _items.putIfAbsent(
          id,
          () => Cart(
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
    _items.forEach((_, Cart cart) {
      total += cart.price * cart.quantity;
    });
    return total;
  }
}
