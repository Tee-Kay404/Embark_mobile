import 'package:Embark_mobile/feature/models/product_models/product.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

void showPaymentMethod(
    BuildContext outerContext, double totalPrice, Product products) {
  String _selectedMethod = '';
  showModalBottomSheet(
      useRootNavigator: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Theme.of(outerContext).colorScheme.inversePrimary,
      context: outerContext,
      builder: (BuildContext innerContext) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          final user = FirebaseAuth.instance.currentUser;
          return SizedBox(
            height: 350,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(5.h),
                  Text(
                    'EMBARK!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: 4,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                    child: Divider(
                      height: 0.5,
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    'Choose Payment Method',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20),
                  ),
                  Gap(5.h),
                  Text(
                    user?.email.toString() ?? '?',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.h,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Gap(20.h),
                  ...[
                    {'title': 'Cash On Delivery', 'icon': Icons.money_outlined},
                    {'title': 'Card', 'icon': Icons.credit_card_outlined},
                    {
                      'title': 'Bank Transfer',
                      'icon': Icons.account_balance_outlined
                    },
                  ]
                      .map((method) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ListTile(
                              tileColor: Theme.of(context).colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(style: BorderStyle.none)),
                              leading: Icon(
                                method['icon'] as IconData,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: Text(
                                method['title'].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                              ),
                              trailing: Radio(
                                value: method['title'],
                                groupValue: _selectedMethod,
                                onChanged: (value) {
                                  setState(
                                      () => _selectedMethod = value.toString());
                                },
                              ),
                              onTap: () {
                                setState(() => _selectedMethod =
                                    method['title'].toString());
                              },
                            ),
                          ))
                      .toList(),
                  Gap(20.h),
                  // Continue button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(double.infinity, 50),
                          alignment: Alignment.center,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          iconColor: Theme.of(context).colorScheme.primary),
                      onPressed: () {
                        if (_selectedMethod.isEmpty) {
                          Navigator.pop(outerContext);
                          ScaffoldMessenger.of(outerContext).showSnackBar(
                            SnackBar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                content: Text(
                                  'Please select a payment method',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                )),
                          );
                          return;
                        }

                        switch (_selectedMethod) {
                          case 'Cash On Delivery':
                            Navigator.pushNamed(
                              outerContext,
                              PageRoutes.cashDelivery.name,
                              arguments: {
                                'price': totalPrice,
                                'products': products,
                              },
                            );
                            break;
                          case 'Card':
                            Navigator.pushNamed(
                                outerContext, PageRoutes.bankTransfer.name);
                            break;
                          case 'Bank Transfer':
                            Navigator.pushNamed(
                                outerContext, PageRoutes.cardPayment.name);
                            break;
                        }
                      },
                      child: Text('Continue',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.surface)))
                ],
              ),
            ),
          );
        });
      });
}
