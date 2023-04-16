import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});
  static const routeName = "/ProductDetailsScreen";

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)!.settings.arguments as String;
    final specificProduct =
        Provider.of<Products>(context, listen: false)
            .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(specificProduct.title),
      ),
    );
  }
}
