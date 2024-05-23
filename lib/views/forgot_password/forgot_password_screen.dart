import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/forgot_password/reset_link.dart';

import '../../resources/helpers/custom_textfield.dart';
import '../../resources/helpers/reuseable_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringManager.forgotPass,
                style: AppTextStyle.headerStyle20.copyWith(color: Colors.black),
              ),
              const Gap(10),
              Text(
                StringManager.worry,
                style: AppTextStyle.bodyStyle16.copyWith(color: Colors.black),
              ),
              const Gap(40),
              Text(
                StringManager.emailAddress,
                style: AppTextStyle.headerMediumStyle
                    .copyWith(color: Colors.black),
              ),
              const Gap(10),
              CustomTextField(
                hintText: StringManager.enterEmail,
                obscureText: obscurePassword1,
                //controller: loginProvider.passwordController,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscurePassword1 = !obscurePassword1;
                    });
                  },
                  child: Icon(
                    obscurePassword1 ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty!";
                  }
                  return null;
                },
              ),
              const Gap(30),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResetLink()));
                },
                child: blueButton(text: 'Request reset link'),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
