import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';

import '../../resources/helpers/custom_textfield.dart';
import '../../resources/helpers/reuseable_widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    bool obscurePassword1 = true;
    bool obscurePassword2 = true;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                Text(
                  StringManager.resetPass,
                  style: AppTextStyle.headerStyle24,
                ),
                Text(StringManager.worry),
                const Gap(30),
                Text(
                  StringManager.password,
                  style: AppTextStyle.headerMediumStyle
                      .copyWith(color: Colors.black),
                ),
                const Gap(10),
                CustomTextField(
                  hintText: StringManager.secure,
                  obscureText: obscurePassword1,
                  //controller: loginProvider.passwordController,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscurePassword1 = !obscurePassword1;
                      });
                    },
                    child: Icon(
                      obscurePassword1
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                Text(
                  StringManager.password,
                  style: AppTextStyle.headerMediumStyle
                      .copyWith(color: Colors.black),
                ),
                const Gap(10),
                CustomTextField(
                  hintText: StringManager.secure,
                  obscureText: obscurePassword2,
                  //controller: loginProvider.passwordController,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscurePassword2 = !obscurePassword2;
                      });
                    },
                    child: Icon(
                      obscurePassword1
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                  onTap: () {},
                  child: blueButton(text: 'Reset Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
