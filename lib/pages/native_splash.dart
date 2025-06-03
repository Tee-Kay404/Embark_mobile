import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NativeSplash extends StatefulWidget {
  const NativeSplash({super.key});

  @override
  State<NativeSplash> createState() => _NativeSplashState();
}

class _NativeSplashState extends State<NativeSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/others/embark_logo.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            Gap(20.h),
            Text('EMBARK!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                    letterSpacing: 4,
                    fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
