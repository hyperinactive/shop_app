import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/order.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(
                // appropriate icon
                _expanded ? Icons.expand_less : Icons.expand_more,
              ),
              // toggle if caret should display additional data
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          // dart supports direct if statements - should return widgets
          if (_expanded)
            SizedBox(
              // responsive expand
              height: min(widget.order.products.length * 20 + 10, 100),
              child: ListView.builder(
                  itemCount: widget.order.products.length,
                  itemBuilder: (_, int index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.order.products[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              '${widget.order.products[index].quantity}x \$${widget.order.products[index].price}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      )),
            )
        ],
      ),
    );
  }
}
