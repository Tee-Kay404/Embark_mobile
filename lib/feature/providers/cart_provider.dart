import 'package:Embark_mobile/feature/models/product_models/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];
  final List<Product> _products = [];

  List<Product> get products => _products;
  final List<Map<String, dynamic>> order = [];
  void addProduct(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners();
  }

  void addToOrder(Map<String, dynamic> product) {
    order.add(product);
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }
}
