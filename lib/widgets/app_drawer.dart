import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello friend!"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
           ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          const Divider(),
           ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Orders"),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrdersScreen.screenRoutName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Manage Products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, UserProductScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
