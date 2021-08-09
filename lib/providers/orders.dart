import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/order.dart';
import 'package:uuid/uuid.dart';

class OrdersProvider with ChangeNotifier {
  final List<Order> _items = <Order>[];

  List<Order> get items {
    return <Order>[..._items];
  }

  void addOrder(List<CartItemModel> cartProducts, double total) {
    _items.insert(
      0,
      Order(
        id: const Uuid().v4(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  bool isEmpty() {
    return _items.isEmpty;
  }
}
