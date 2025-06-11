import 'dart:convert';

import 'package:Embark_mobile/feature/models/product_models/product.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  Future<List<Product>> fetchProducts() async {
    try {
      const url = 'http://localhost:3000/products';
      final uri = Uri.parse(url);
      final res = await http.get(uri);
      final body = res.body;
      final json = jsonDecode(body) as List<dynamic>;
      final products = json.map((e) {
        return Product.fromMap(e);
      }).toList();
      return products;
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
