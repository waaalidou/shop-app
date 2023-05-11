import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  late String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final url = Uri.parse(
        "https://flutter-shop-app-80354-default-rtdb.firebaseio.com/products/$id.json");
    isFavorite = !isFavorite;

    try {
      await http.patch(
        url,
        body: json.encode(
          {'isFavorite': isFavorite},
        ),
      );
      notifyListeners();
    } catch (_) {
      isFavorite = !isFavorite;
      rethrow;
    }
    notifyListeners();
  }
}
