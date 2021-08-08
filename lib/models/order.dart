import 'package:shop_app/models/cart_model.dart';

class Order {
  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });

  final String id;
  final double amount;
  final List<CartItemModel> products;
  final DateTime dateTime;
}
