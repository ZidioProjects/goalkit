import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/resources/navigation/bottom_navigation.dart';
import 'package:goalkit/views/authentication/login/login_page.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            ImageManager.onboardPic,
            height: 250,
            width: 250,
          ),
          const Gap(40),
          const Text(
            StringManager.welcome,
            style: AppTextStyle.headerStyle,
          ),
          const Gap(20),
          const Text(
            StringManager.weWait,
            style: AppTextStyle.bodyStyle14,
          ),
          const Text(
            StringManager.goals,
            style: AppTextStyle.bodyStyle14,
          ),
          const Gap(20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: Container(
              height: 48,
              width: 150,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
              child: Center(
                child: Image.asset(
                  ImageManager.onboardArrow,
                  height: 20,
                  width: 40,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
