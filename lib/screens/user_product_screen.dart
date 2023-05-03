import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/add_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});
  static const routeName = '/UserProductScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProductScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Consumer<Products>(
        builder: (context, product, _) => Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
            itemBuilder: (ctx, index) => UserProductItem(
              id:  product.items[index].id,
              title: product.items[index].title,
              imageUrl: product.items[index].imageUrl,
            ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: product.items.length,
          ),
        ),
      ),
    );
  }
}
