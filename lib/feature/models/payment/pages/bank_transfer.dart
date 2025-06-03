import 'package:Embark_mobile/components/textfields/embark_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BankTransfer extends StatefulWidget {
  const BankTransfer({super.key});

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  void continuePayment() {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState!.validate()) {
      // Proceed with payment
    }
  }

  @override
  void dispose() {
    _cardController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 15.0).copyWith(bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(15),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, size: 24.sp),
                  ),
                  Gap(10.h),
                  Text(
                    'Make Payment with credit or debit card',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 20.h, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Gap(30.h),
              Text(
                'All fields are required',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 17.h,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700),
              ),
              Gap(20.h),
              Row(
                children: [
                  Expanded(
                    child: EmbarkTextfield(
                      controller: _cardController,
                      keyBoardType: TextInputType.number,
                      borderRadius: BorderRadius.circular(5),
                      hintText: 'Card number',
                      hintStyle: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                      focusedborder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red, width: 1)),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 12),
                      labelText: 'Card number',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: _submitted && _cardController.text.isEmpty
                                  ? Colors.red
                                  : null),
                      prefixIcon: Icon(
                        Icons.credit_card,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      suffixIcon: _submitted && _cardController.text.isEmpty
                          ? Icon(Icons.error, color: Colors.red)
                          : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Card number required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Gap(20.h),
                  IconButton(
                    icon: Icon(Icons.help_outline_outlined),
                    onPressed: () {
                      showModalBottomSheet(
                          isDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0, vertical: 20)
                                    .copyWith(bottom: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      'Accepted cards',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 15),
                                    ),
                                    Gap(20.h),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                                height: 30,
                                                'assets/images/others/visa.png'),
                                            Image.asset(
                                                height: 30,
                                                'assets/images/others/mastercard.png'),
                                            Image.asset(
                                                height: 30,
                                                'assets/images/others/verve.png'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Gap(20.h),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          minimumSize:
                                              Size(double.infinity, 40),
                                          alignment: Alignment.center,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          iconColor: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'OK',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontSize: 15,
                                                color: Theme.of(context)
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
                  ),
                ],
              ),
              Gap(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: EmbarkTextfield(
                      controller: _expiryController,
                      keyBoardType: TextInputType.datetime,
                      borderRadius: BorderRadius.circular(5),
                      labelText: 'MM/YY',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color:
                                  _submitted && _expiryController.text.isEmpty
                                      ? Colors.red
                                      : null),
                      focusedborder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red, width: 1)),
                      suffixIcon: _submitted && _expiryController.text.isEmpty
                          ? Icon(Icons.error, color: Colors.red)
                          : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a valid expiration date';
                        }
                        return null;
                      },
                    ),
                  ),
                  Gap(22.h),
                  Expanded(
                    child: EmbarkTextfield(
                      controller: _cvvController,
                      keyBoardType: TextInputType.number,
                      borderRadius: BorderRadius.circular(5),
                      labelText: 'CVV',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: _submitted && _cvvController.text.isEmpty
                                  ? Colors.red
                                  : null),
                      focusedborder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red, width: 1)),
                      suffixIcon: _submitted && _cvvController.text.isEmpty
                          ? Icon(Icons.error, color: Colors.red)
                          : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Security code is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Gap(10.h),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 180,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'CVV',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontSize: 15),
                                      ),
                                      Gap(20.h),
                                      Text(
                                        'The CVV is a 3-digit security code on the back of your card',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontSize: 10,
                                                color: Colors.grey.shade500),
                                      ),
                                      Gap(20.h),
                                      Container(
                                        height: 40,
                                        child: Center(
                                          child: Image.asset(
                                            'assets/icons/card-cvv-icon.png',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                      Gap(20.h),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            minimumSize:
                                                Size(double.infinity, 40),
                                            alignment: Alignment.center,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            iconColor: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'OK',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
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
                      icon: Icon(Icons.help_outline_outlined))
                ],
              ),
              Gap(40.h),
              RichText(
                text: TextSpan(
                    text: 'By, continuing, you agree to Embark! Payments',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' you create an Embark! Payment account and'),
                      TextSpan(text: ' agree to the Embark! Payments '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline),
                      ),
                      TextSpan(text: '. The '),
                      TextSpan(
                        text: 'Privacy Notice',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline),
                      ),
                      TextSpan(text: ' describes how your data is handled.'),
                    ]),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    minimumSize: Size(double.infinity, 50),
                    alignment: Alignment.center,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    iconColor: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  continuePayment();
                },
                child: Text('Continue',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.surface)),
              )
            ],
          ),
        ),
      )),
    );
  }
}
