import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:Embark_mobile/components/buttons/gradient_button.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  final List<OnBoardingData> pages;

  const OnBoardingScreen({super.key, required this.pages});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // shared controller
  final _controller = PageController();

  bool _isTapped = false;

//  tracks the current page
  int _currentPage = 0;

  // disposes the controller
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics: const PageScrollPhysics(),
                itemCount: widget.pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = widget.pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: Column(
                      children: [
                        const Gap(25),
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  _currentPage == widget.pages.length - 1
                                      ? 'Done'
                                      : 'Skip',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 18,
                                          decoration: _isTapped
                                              ? TextDecoration.underline
                                              : null)),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _isTapped = true;
                            });
                            Navigator.pushNamed(context, PageRoutes.login.name);
                          },
                        ),
                        const Gap(20),
                        Center(
                            child: SizedBox(
                          height: 360,
                          child: Lottie.asset(page.animations),
                        )),
                        const Gap(27),
                        // page Indicator
                        SmoothPageIndicator(
                          controller: _controller,
                          count: widget.pages.length,
                          effect: const WormEffect(
                            dotWidth: 15,
                            dotHeight: 4,
                            // radius: 22,
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          height: 148,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(page.text,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontSize: 24)),
                                const Gap(10),
                                Text(page.bottomText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.normal)),
                                Text(page.bottomTexts,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.normal)),
                                Text(page.bottomTEXT,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                        ),
                        // const Gap(10),
                        // buttons
                        Expanded(
                          child: GradientButton(
                            shape: const CircleBorder(),
                            icon: Icon(
                              Icons.arrow_forward_outlined,
                              color: Theme.of(context).colorScheme.surface,
                              size: 30,
                            ),
                            onTap: () {
                              if (_currentPage < widget.pages.length - 1) {
                                _controller.animateToPage(
                                  _currentPage + 1,
                                  duration: const Duration(
                                    milliseconds: 300,
                                  ),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  PageRoutes.login.name,
                                );
                              }
                            },
                            height: 55,
                            width: 55,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Data class for onBoarding pages
class OnBoardingData {
  final String text;
  final String animations;
  final String bottomText;
  final String bottomTexts;
  final String bottomTEXT;

  OnBoardingData({
    required this.text,
    required this.animations,
    required this.bottomText,
    required this.bottomTexts,
    required this.bottomTEXT,
  });
}
