// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  ProductsOverviewScreenState createState() => ProductsOverviewScreenState();
}

class ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyShop'), actions: <Widget>[
        PopupMenuButton(
          onSelected: (FilterOptions selectedValue) {
            setState(() {
              if (selectedValue == FilterOptions.Favorites) {
                _showOnlyFavorites = true;
              } else {
                _showOnlyFavorites = false;
              }
            });
          },
          icon: const Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: FilterOptions.Favorites,
              child: Text('Only Favorites'),
            ),
            const PopupMenuItem(
              value: FilterOptions.All,
              child: Text('Show All'),
            ),
          ],
        )
      ]),
      body: ProductGrid(showFavourite: _showOnlyFavorites),
    );
  }
}
