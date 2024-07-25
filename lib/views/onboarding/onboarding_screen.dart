import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/login_provider.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/resources/navigation/bottom_navigation.dart';
import 'package:goalkit/views/authentication/login/login_page.dart';
import 'package:goalkit/views/onboarding/pages/first.dart';
import 'package:goalkit/views/onboarding/pages/second.dart';
import 'package:goalkit/views/onboarding/pages/third.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserStatus();
    });
  }

  Future<void> _checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Nav()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(builder: (ctx, loginProvider, child) {
        return SafeArea(
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
                    ? Image.asset(
                  ImageManager.half,
                  width: 40,
                  height: 40,
                )
                    : _currentPage == 1
                    ? Image.asset(
                  ImageManager.full,
                  width: 40,
                  height: 40,
                )
                    : const SizedBox(),
              ),
              Positioned(
                bottom: 100,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    (_currentPage == 0 || _currentPage == 1)
                        ? GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      child: blueButton(text: StringManager.cont),
                    )
                        : const SizedBox(),
                    const Gap(10),
                    _currentPage == 0
                        ? Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          StringManager.skip,
                          style: AppTextStyle.headerMediumStyle
                              .copyWith(color: primaryColor),
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
