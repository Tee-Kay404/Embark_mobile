import 'package:Embark_mobile/feature/models/product_models/product.dart';
import 'package:Embark_mobile/feature/providers/cart_provider.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CashDelivery extends StatelessWidget {
  final Product products;
  final double price;
  const CashDelivery({super.key, required this.price, required this.products});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 20.sp,
            ),
          ),
          title: Text('Cash on Delivery'),
          titleTextStyle:
              Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 20),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              children: [
                Gap(200.h),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.monetization_on,
                        size: 54.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Gap(20.h),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                        text: 'Please',
                        children: <TextSpan>[
                      TextSpan(text: ' pay the amount\n '),
                      TextSpan(text: 'below when the order\n'),
                      TextSpan(text: ' is delivered to you. '),
                    ])),
                Gap(20.h),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 20,
                      ),
                ),
                Gap(20.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // minimumSize: Size(double.infinity, 40),
                      alignment: Alignment.center,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      iconColor: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.zero,
                            child: AlertDialog(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              // title: Text(
                              //   'Confirm Order?',
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .bodySmall
                              //       ?.copyWith(
                              //           color: Theme.of(context)
                              //               .colorScheme
                              //               .surface),
                              // ),
                              content: Text(
                                'Are you sure you want to place this order?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface),
                              ),
                              actions: [
                                // confirm button
                                TextButton(
                                    onPressed: () {
                                      provider.addToOrder({
                                        'id': products.id,
                                        'description': products.description,
                                        'imagePath': products.imagePath,
                                        'volume': products.volume,
                                        'model': products.model ?? '',
                                        'size': products.size ?? '',
                                        'price': products.price,
                                        'category': products.category,
                                      });

                                      Navigator.pop(context);
                                      showModalBottomSheet(
                                          isDismissible: false,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 290.h,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 20.0)
                                                        .copyWith(top: 20),
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/icons/success.png',
                                                      height: 80,
                                                    ),
                                                    Gap(10.h),
                                                    Text(
                                                      'Order Placed Successfully!',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                    Gap(10.h),
                                                    Text(
                                                      'Order ID : #23499',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Text(
                                                      'Expected Delivery : 3-6 hours',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Gap(20.h),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          splashFactory: NoSplash
                                                              .splashFactory,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          minimumSize: Size(
                                                              double.infinity,
                                                              40),
                                                          alignment:
                                                              Alignment.center,
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          iconColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            PageRoutes.dashBoard
                                                                .name);
                                                      },
                                                      child: Text(
                                                        'Continue Shopping',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                fontSize: 15,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .surface),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    style: ButtonStyle(
                                        splashFactory: NoSplash.splashFactory,
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        backgroundColor: WidgetStatePropertyAll(
                                            Theme.of(context)
                                                .colorScheme
                                                .surface),
                                        foregroundColor: WidgetStatePropertyAll(
                                            Colors.blue)),
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                        splashFactory: NoSplash.splashFactory,
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.white),
                                        foregroundColor: WidgetStatePropertyAll(
                                            Colors.blue)),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          );
                        });
                  },
                  child: Text(
                    'CONFIRM ORDER',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ));
  }
}
