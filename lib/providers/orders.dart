import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/order.dart';
import 'package:uuid/uuid.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = <Order>[];

  List<Order> get orders {
    return <Order>[..._orders];
  }

  void addOrder(List<CartItemModel> cartProducts, double total) {
    _orders.insert(
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
}
