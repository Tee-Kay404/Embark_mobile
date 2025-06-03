import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class GiftCard extends StatelessWidget {
  const GiftCard({super.key});

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        titlePadding: EdgeInsets.all(10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Unlock!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close_outlined,
                color: Theme.of(context).colorScheme.surface,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.only(
          top: 5,
          left: 10,
          right: 10,
          bottom: 25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Text(
          "This feature is currently unavailable.",
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.surface,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: theme.colorScheme.surface,
            size: 18,
          ),
        ),
        title: Text(
          'Gift Cards',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.surface,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              height: 200,
              'assets/animations/gift_card.json',
              fit: BoxFit.fill,
              // delegates: LottieDelegates(
              //   values: [
              //     ValueDelegate.color(const ['**'],
              //         value: theme.colorScheme.primary),
              //   ],
              // ),
            ),
            Gap(20.h),
            Text(
              'Sorry! unlock premium \$3.99',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            Text(
              'to gain access to this feature',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            Gap(20.h),
            TextButton(
              style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor:
                      WidgetStatePropertyAll(theme.colorScheme.primary)),
              onPressed: () => showCustomDialog(context),
              child: Text(
                "Unlock",
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.surface,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
