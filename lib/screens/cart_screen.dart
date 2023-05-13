import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/order.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount.toStringAsFixed(2)}",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  PlaceOrderButton(cart: cart, scaffoldMessenger: scaffoldMessenger),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartItemWidget(
                id: cart.items.values.toList()[index].id,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                title: cart.items.values.toList()[index].title,
                productId: cart.items.keys.toList()[index],
              ),
              itemCount: cart.getItemCounts,
            ),
          )
        ],
      ),
    );
  }
}

class PlaceOrderButton extends StatefulWidget {
  const PlaceOrderButton({
    super.key,
    required this.cart,
    required this.scaffoldMessenger,
  });

  final Cart cart;
  final ScaffoldMessengerState scaffoldMessenger;

  @override
  State<PlaceOrderButton> createState() => _PlaceOrderButtonState();
}

class _PlaceOrderButtonState extends State<PlaceOrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
            setState(() {
              _isLoading = true;
            });
              try {
                await Provider.of<Orders>(context, listen: false)
                    .addOrder(
                  widget.cart.items.values.toList(),
                  widget.cart.totalAmount,
                ).then((value){
                  setState(() {
                    _isLoading = false;
                  });
                });
                widget.cart.clearCart();
              } catch (e) {
                widget.scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text('Adding Orders failed!'),
                  ),
                );
              }
            },
      child: const Text("Place Order"),
    );
  }
}
