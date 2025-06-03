import 'package:Embark_mobile/feature/providers/cart_provider.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  final List<String> category = const [
    'bottles',
    'clothings',
    'furniture',
    'electronics',
    'accessories',
    'automobile',
    'wears',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allProducts = Provider.of<CartProvider>(context).products;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacementNamed(
              context, PageRoutes.dashBoard.name),
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 22,
          color: Colors.white,
        ),
        title: const Text('Categories'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Gap(10.h),
          Expanded(
            child: ListView.separated(
              itemCount: category.length,
              separatorBuilder: (context, index) => Gap(5.h),
              itemBuilder: (context, index) {
                final cat = category[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListTile(
                    minTileHeight: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: theme.colorScheme.primary,
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      cat,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.surface,
                      ),
                    ),
                    onTap: () {
                      debugPrint('Received category: $category');
                      debugPrint('All products: ${allProducts.length}');
                      Navigator.pushNamed(
                        context,
                        PageRoutes.categoryProduct.name,
                        arguments: {
                          'category': cat,
                        },
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
