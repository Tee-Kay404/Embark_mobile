import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:Embark_mobile/components/buttons/gradient_button.dart';
import 'package:Embark_mobile/routes.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 55),
                Center(
                    child: Image.asset(
                  'assets/images/others/embark_logo.png',
                  height: 150,
                  fit: BoxFit.contain,
                )),
                Text('EMBARK!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: 4,
                        fontSize: 30)),
                const Gap(50),
                Padding(
                  padding: EdgeInsets.only(right: 40.0.sp),
                  child: Image.asset(
                    height: 150,
                    'assets/images/others/shopping_cart.png',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // Icon/animation
                const Gap(38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome to',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 28)),
                    const Gap(10),
                    Text(
                      'EMBARK!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 4,
                          fontSize: 25),
                    ),
                  ],
                ),
                // gretings
                const Gap(10),
                // welcome text
                Column(
                  children: [
                    Text('Discover a world of shopping',
                        style: Theme.of(context).textTheme.bodySmall),
                    Text('at your fingertips. Exclusive deals,',
                        style: Theme.of(context).textTheme.bodySmall),
                    Text('endless choices and a seamless',
                        style: Theme.of(context).textTheme.bodySmall),
                    Text(
                      'shopping experience!!!',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Gap(5),
                  ],
                ),
                const Gap(28),
                GradientButton(
                  text: 'Get Started',
                  onTap: () =>
                      Navigator.pushNamed(context, PageRoutes.onBoarding.name),
                  width: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* splash
   intro page
   onBoarding page
   sign up
   login
   DashBoard page(
   drawer
   routing
   nav bar
   )
   inventory
   store/cart
   settings
   about
   forgotpassword,
   resetPassword,
   inventory itemdetails
   payment method*/
