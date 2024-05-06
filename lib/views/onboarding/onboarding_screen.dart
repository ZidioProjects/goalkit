import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/onboarding/pages/first.dart';
import 'package:goalkit/views/onboarding/pages/second.dart';
import 'package:goalkit/views/onboarding/pages/third.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> _pages = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _pages,
            ),
            Positioned(
                top: 35,
                right: 20,
                child: _currentPage == 0
                    ? Image.asset(ImageManager.half, width: 40, height: 40,)
                    : _currentPage == 1
                    ? Image.asset(ImageManager.full, width: 40, height: 40,)
                    : const SizedBox()
            ),
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  (_currentPage == 0 || _currentPage == 1)
                  ? GestureDetector(
                    onTap: (){
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                      child: blueButton(text: StringManager.cont))
                  : const SizedBox(),
                  const Gap(10),
                  _currentPage == 0
                  ? Center(
                    child: Text(
                      StringManager.skip,
                      style: AppTextStyle.headerMediumStyle.copyWith(color: primaryColor),
                    ),
                  )
                  : const SizedBox(),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
