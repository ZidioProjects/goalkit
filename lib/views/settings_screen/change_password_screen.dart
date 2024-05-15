import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../resources/helpers/custom_textfield.dart';
import '../../resources/helpers/reuseable_widgets.dart';
import '../../resources/managers/image_manager.dart';
import '../../resources/managers/string_manager.dart';
import '../../resources/managers/styles_manager.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text(
          StringManager.change,
          style: AppTextStyle.headerStyle20,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Text(
                StringManager.condition,
                style: AppTextStyle.bodyStyle16.copyWith(color: Colors.black),
              ),
              const Gap(30),
              Text(
                StringManager.current,
                style: AppTextStyle.headerMediumStyle
                    .copyWith(color: Colors.black),
              ),
              const Gap(10),
              CustomTextField(
                hintText: StringManager.enter,
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
              Text(
                StringManager.newPas,
                style: AppTextStyle.headerMediumStyle
                    .copyWith(color: Colors.black),
              ),
              const Gap(10),
              CustomTextField(
                hintText: StringManager.enterNew,
                obscureText: obscurePassword2,
                //controller: loginProvider.passwordController,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscurePassword2 = !obscurePassword2;
                    });
                  },
                  child: Icon(
                    obscurePassword2 ? Icons.visibility : Icons.visibility_off,
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
              const Gap(20),
              const Gap(40),
              GestureDetector(
                onTap: () {},
                child: blueButton(text: 'Save'),
              ),
              const Gap(20),
              Center(
                child: Text(
                  StringManager.forgotPass,
                  style: AppTextStyle.headerMediumStyle
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
