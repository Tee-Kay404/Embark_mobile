import 'package:Embark_mobile/components/textfields/embark_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        title: Text(
          'Make Payment with credit or debit card',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 16.h,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 15.0).copyWith(bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20.h),
                Text(
                  'All fields are required',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 17.h,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                ),
                Gap(30.h),

                /// First row - Card Number + Icon
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: EmbarkTextfield(
                          autofocus: true,
                          controller: _cardController,
                          keyBoardType: TextInputType.number,
                          borderRadius: BorderRadius.circular(5),
                          hintText: 'Card number',
                          hintStyle: TextStyle(fontSize: 15),
                          focusedborder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1)),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 12),
                          labelText: 'Card number',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color:
                                    _submitted && _cardController.text.isEmpty
                                        ? Colors.red
                                        : null,
                              ),
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
                      Gap(12.h),
                      IconButton(
                        icon: Icon(Icons.help_outline_outlined),
                        onPressed: () {
                          // Show card info modal
                        },
                      ),
                    ],
                  ),
                ),

                Gap(30.h),

                /// Second row - Expiry + CVV + Icon
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: EmbarkTextfield(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            ExpiryDateFormatter(),
                          ],
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
                                        : null,
                              ),
                          focusedborder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1)),
                          suffixIcon:
                              _submitted && _expiryController.text.isEmpty
                                  ? Icon(Icons.error, color: Colors.red)
                                  : null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter a valid expiration date';
                            }

                            final expRegExp =
                                RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
                            if (!expRegExp.hasMatch(value)) {
                              return 'Format must be MM/YY';
                            }

                            final parts = value.split('/');
                            final month = int.parse(parts[0]);
                            final year = int.parse('20${parts[1]}');

                            final now = DateTime.now();
                            final inputDate = DateTime(year, month + 1);

                            if (inputDate
                                .isBefore(DateTime(now.year, now.month))) {
                              return 'Card expired';
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
                                    : null,
                              ),
                          focusedborder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1)),
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
                          // Show CVV info modal
                        },
                        icon: Icon(Icons.help_outline_outlined),
                      )
                    ],
                  ),
                ),

                Gap(40.h),
                RichText(
                  text: TextSpan(
                    text: 'By continuing, you agree to Embark! Payments',
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
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: '. The '),
                      TextSpan(
                        text: 'Privacy Notice',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' describes how your data is handled.'),
                    ],
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    minimumSize: Size(double.infinity, 50),
                    alignment: Alignment.center,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: continuePayment,
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length == 2 && !text.contains('/')) {
      text += '/';
    } else if (text.length > 2 && text[2] != '/') {
      text = text.substring(0, 2) + '/' + text.substring(2);
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
