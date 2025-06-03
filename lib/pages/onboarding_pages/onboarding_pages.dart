import 'package:flutter/material.dart';
import 'package:Embark_mobile/pages/onboarding_pages/onboarding_screen.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingScreen(
      pages: [
        // firt Page
        OnBoardingData(
          text: 'Easy Browsing',
          animations: 'assets/animations/animaton1.json',
          bottomText: 'Find what you love.',
          bottomTexts: 'Explore thousands of products',
          bottomTEXT: 'in every category',
        ),
        // second page
        OnBoardingData(
            text: 'Exclusive Offers',
            animations: 'assets/animations/animation2.json',
            bottomText: 'Save big everyday.',
            bottomTexts: 'Access exclusive discounts,',
            bottomTEXT: 'and daily deals just for you.'),
        // third page
        OnBoardingData(
            text: 'Fast and Secure\n   Payments 👍',
            animations: 'assets/animations/animation4.json',
            bottomText: 'your safety is our priority.',
            bottomTexts: 'Checkout in seconds',
            bottomTEXT: 'with secure payment options.'),
        // fourth onboarding page
        OnBoardingData(
            text: 'Quick Delivery',
            animations: 'assets/animations/animation3.json',
            bottomText: 'Get It Fast',
            bottomTexts: 'Enjoy lightning-fast delivery,',
            bottomTEXT: 'right to your doorstep.'),
        // last onBoarding page
        OnBoardingData(
            text: 'Variety',
            animations: 'assets/animations/animation6.json',
            bottomText: 'Ev\'rything You Need in One Place.',
            bottomTexts: 'From groceries to gadgets,',
            bottomTEXT: ' find it all here.'),
      ],
    );
  }
}
