import 'package:Embark_mobile/feature/models/product_models/product.dart';
import 'package:Embark_mobile/feature/providers/cart_provider.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  final Map<String, dynamic> products;
  const CartPage({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final cart = (Provider.of<CartProvider>(context).cart);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey[600],
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacementNamed(
              context, PageRoutes.dashBoard.name),
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 22,
          color: Theme.of(context).colorScheme.surface,
        ),
        title: Text('Cart',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.surface)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: cart.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              size: 80, color: Colors.grey.shade400),
                          Gap(10),
                          Text(
                            "Cart is empty",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final cartItem = cart[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            minTileHeight: 70,
                            tileColor: Theme.of(context).colorScheme.primary,
                            title: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  radius: 30,
                                  child: Center(
                                    child: Expanded(
                                        child: Image.asset(
                                            cartItem['imagePath'] as String)),
                                  ),
                                ),
                                Gap(15.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem['description'] as String,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                    ),
                                    // Gap(8.h),
                                    Text(
                                      cartItem['code'] as String,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                    ),
                                    Text(
                                      '\$${(cartItem['price'] as num?)?.toStringAsFixed(2) ?? '0.00'}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert_outlined,
                                color: Theme.of(context).colorScheme.surface,
                                size: 25,
                              ),
                              onSelected: (value) {
                                switch (value) {
                                  case 'view':
                                    Navigator.pushNamed(
                                      context,
                                      PageRoutes.productDetails.name,
                                      arguments: Product(
                                        id: cartItem['id'] ?? '',
                                        code: cartItem['code'] ?? '',
                                        imagePath: cartItem['imagePath'] ?? '',
                                        description:
                                            cartItem['description'] ?? '',
                                        price: cartItem['price'] ?? 0.0,
                                        color: '',
                                        category: '',
                                      ),
                                    );
                                    break;
                                  case 'remove':
                                    context
                                        .read<CartProvider>()
                                        .removeProduct(cartItem);
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'view',
                                  child: Row(
                                    children: [
                                      Icon(Icons.info_outline,
                                          color: Colors.black54),
                                      SizedBox(width: 10),
                                      Text('View Details'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'remove',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline,
                                          color: Colors.red),
                                      SizedBox(width: 10),
                                      Text('Remove'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
