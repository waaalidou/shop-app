import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/add_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String? id;
  final String imageUrl;
  const UserProductItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () => Provider.of<Products>(context, listen: false).deleteProduct(id!),
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
