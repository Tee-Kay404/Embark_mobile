import 'dart:convert';

import 'package:Embark_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:Embark_mobile/feature/models/product_models/product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class CategoryProductsPage extends StatefulWidget {
  final String category;

  const CategoryProductsPage({
    super.key,
    required this.category,
  });

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  List<Product> products = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    final response = await http.get(Uri.parse('http://10.0.2.2:3000/products'));
    if (response.statusCode == 200) {
      final List<dynamic> productList = jsonDecode(response.body);
      final loadedProducts =
          productList.map((e) => Product.fromMap(e)).toList();
      setState(() {
        products = loadedProducts
            .where((p) =>
                p.category.toLowerCase() == widget.category.toLowerCase())
            .toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text('Products(${widget.category})'),
          centerTitle: true,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.surface,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : products.isEmpty
                ? Center(
                    child: Text(
                      'No products found in ${widget.category}.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 15),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final item = products[index];
                      var style = Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 1),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            contentPadding: EdgeInsets.only(right: 10),
                            tileColor: Theme.of(context).colorScheme.surface,
                            leading: CircleAvatar(
                              backgroundColor: Colors.white60,
                              radius: 40.h,
                              child: Image.asset(item.imagePath),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.description,
                                    style: style?.copyWith(
                                        fontSize: 16, color: Colors.black)),
                                Text('\$${item.code}', style: style)
                              ],
                            ),
                            subtitle: Text('${item.volume}', style: style),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item.id.toInt()}', style: style),
                                Text('\$${item.price.toInt()}', style: style)
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PageRoutes.productDetails.name,
                                arguments: item,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ));
  }
}
