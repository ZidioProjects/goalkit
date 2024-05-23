import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/forgot_password/reset_password.dart';

import '../../resources/helpers/reuseable_widgets.dart';

class ResetLink extends StatelessWidget {
  const ResetLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageManager.mailSent,
                height: 214,
                width: 288,
              ),
              const Gap(20),
              Text(
                StringManager.reset,
                style: AppTextStyle.headerStyle24.copyWith(color: Colors.black),
              ),
              const Gap(20),
              Text(StringManager.passwordLink),
              const Gap(30),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResetPassword()));
                },
                child: blueButton(text: 'Open Mail'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
