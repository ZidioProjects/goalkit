import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/resources/managers/values_manager.dart';
import 'package:goalkit/views/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageManager.splashLogo,
              height: 60,
              width: 60,
              color: Colors.white,
            ),
            const Gap(10),
            Text(
              StringManager.appName,
              style: AppTextStyle.headerStyle.copyWith(color: Colors.white),
            ),
          ]
        ),
      ),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: primaryColor,
      curve: Curves.easeIn,
      duration: DurationConstant.d500,
      nextScreen: const OnboardingScreen(),
    );
  }
}
