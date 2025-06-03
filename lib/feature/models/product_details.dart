import 'package:Embark_mobile/feature/models/payment/pages/models/payment_bottom_sheet.dart';
import 'package:Embark_mobile/feature/models/product_models/product.dart';
import 'package:Embark_mobile/feature/providers/cart_provider.dart';
import 'package:Embark_mobile/feature/shared/email_avatar.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product products;
  const ProductDetails({
    super.key,
    required this.products,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final user = FirebaseAuth.instance.currentUser;
  int _counter = 1;
  bool _onPressed = false;

  @override
  Widget build(BuildContext context) {
    final cartProducts = Provider.of<CartProvider>(context).cart;
    List<Map<String, dynamic>> detailsTile = [
      {'leading': 'Name', 'trailing': widget.products.description},
      {'leading': 'Code', 'trailing': widget.products.code},
      {
        'leading': 'Price',
        'trailing':
            ' \$${_counter > 0 ? (widget.products.price * _counter).toStringAsFixed(2) : widget.products.price.toStringAsFixed(2)}'
      },
      {
        'leading': 'Quantity',
        'trailing': SizedBox(
          width: 140, // Ensures proper alignment
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.e,
            children: [
              Icon(
                (Icons.calculate_outlined),
                size: 16,
              ),
              Gap(5),
              IconButton(
                onPressed: () {
                  if (_counter > 0) {
                    setState(() {
                      _counter--;
                      _onPressed = true;
                    });
                  }
                },
                icon: Icon(Icons.remove_circle_outline_outlined),
                iconSize: 16,
                color: _onPressed
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black,
              ),
              Gap(5),
              Text(
                '$_counter',
                style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },
                icon: Icon(Icons.add_circle_outline_outlined),
                iconSize: 16,
                color:
                    _counter > 0 ? Theme.of(context).colorScheme.primary : null,
              ),
            ],
          ),
        ),
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // Product Image & Header
          Theme(
            data: ThemeData(
              splashFactory: NoSplash.splashFactory,
            ),
            child: Container(
              height: 400.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  Gap(40.h),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                      ),
                      Text(
                        'Product Details',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 22,
                            color: Theme.of(context).colorScheme.surface),
                      ),
                      Spacer(),
                      EmailAvatar(),
                      SizedBox(width: 10),
                      Theme(
                        data: ThemeData(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.blue,
                                size: 18,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  PageRoutes.cartPage.name,
                                  arguments: {
                                    'products': cartProducts,
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Gap(30.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Image.asset(widget.products.imagePath,
                                height: 190)),
                        Gap(20.w),
                        Text(
                          widget.products.model != null &&
                                  widget.products.model!.isNotEmpty
                              ? 'Model: ${widget.products.model}'
                              : widget.products.size != null &&
                                      widget.products.size!.isNotEmpty
                                  ? 'Size: ${widget.products.size}'
                                  : 'Volume: ${widget.products.volume ?? 'N/A'}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Product Details List
          SizedBox(
            height: 300.h,
            child: ListView(
              children: detailsTile.map((item) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      minTileHeight: 50,
                      tileColor: Theme.of(context).colorScheme.surface,
                      leading: Text(
                        item['leading'] as String,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      trailing: item['trailing'] is String
                          ? Text(
                              item['trailing'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                            )
                          : item['trailing']
                              as Widget, // Directly assign widget
                    ),
                    BrokenLine(),
                  ],
                );
              }).toList(),
            ),
          ),
          Gap(40.h),
          // buy now button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  final totalPrice = widget.products.price * _counter;
                  showPaymentMethod(context, totalPrice, widget.products);
                },
                style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  shadowColor: Colors.grey.shade300,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Buy Now'),
              ),
            ),
          ),
          Gap(10.h),
          // add to cart button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addProduct(
                  {
                    'id': widget.products.id,
                    'imagePath': widget.products.imagePath,
                    'color': widget.products.color,
                    'code': widget.products.code,
                    'description': widget.products.description,
                    'price': widget.products.price,
                    'volume': widget.products.volume,
                    'size': widget.products.size,
                    'model': widget.products.model,
                  },
                );

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });
                      return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          content: SizedBox(
                            height: 34,
                            width: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text('Added successfully!',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface)),
                              ),
                            ),
                          ));
                    });
              },
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                elevation: 30,
                // shadowColor: Colors.grey.shade300,
                foregroundColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Gap(10.h),
                    Text('Add to Cart'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BrokenLine extends StatelessWidget {
  const BrokenLine({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
        );
      },
    );
  }
}
