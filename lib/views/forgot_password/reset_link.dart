import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/forgot_password/reset_password.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  _launchEmail();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ResetPassword()));
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

void _launchEmail() async {
  const email = 'mailto:';
  final Uri emailUri = Uri.parse(email);
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch $email';
  }
}
