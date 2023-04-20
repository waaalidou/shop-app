import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  const CartItemWidget({
    super.key,
    required this.id,
    required this.title,
    required this.quantity,
    required this.price, 
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => cartProvider.deleteCartItem(productId),
      background: Container(
        padding: const EdgeInsets.only(right: 10),
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 35,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                  child: Text(
                    "\$$price",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total : \$${price * quantity}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
