import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/cart.dart';
import '../providers/products.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final singleProductData = Provider.of<Product>(context, listen: false);
    final cartContainer = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              onPressed: () => product.toggleFavoriteStatus(),
              icon: Icon(
                product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cartContainer.addCartItem(singleProductData.id, singleProductData.price, singleProductData.title);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            singleProductData.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            ProductDetailsScreen.routeName,
            arguments: singleProductData.id,
          ),
          child: Image.network(
            singleProductData.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
