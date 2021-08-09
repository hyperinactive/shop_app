import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/order_item_widget.dart';
import 'package:shop_app/widgets/main_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const String routeName = '/orders';

  Widget buildOrders(OrdersProvider orders) {
    return orders.isEmpty()
        ? const Center(
            child: Text('no orders'),
          )
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) => OrderItemWidget(
              order: orders.items[index],
            ),
            itemCount: orders.items.length,
          );
  }

  @override
  Widget build(BuildContext context) {
    final OrdersProvider orders = Provider.of<OrdersProvider>(context);
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: buildOrders(orders),
    );
  }
}
