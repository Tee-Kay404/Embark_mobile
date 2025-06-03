import 'dart:async';

import 'package:flutter/material.dart';

Future<void> showFirebaseDialog(BuildContext context, String message) {
  Timer timer = Timer(Duration(milliseconds: 2000), () {
    Navigator.of(context, rootNavigator: true).pop();
  });
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    },
  ).then((value) {
    // dispose the timer in case something else has triggered the dismiss.
    timer.cancel();
  });
}
