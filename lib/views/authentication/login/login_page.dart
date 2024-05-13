import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/helpers/custom_textfield.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/authentication/signup/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(40),
                  Text(
                    StringManager.login,
                    style: AppTextStyle.headerStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: StringManager.doNot,
                        style: AppTextStyle.bodyStyle16
                            .copyWith(color: Colors.black),
                      ),
                      TextSpan(
                        text: StringManager.createAccount,
                        style: AppTextStyle.bodyStyle16
                            .copyWith(color: primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()),
                            );
                          },
                      ),
                    ]),
                  ),
                  Gap(30),
                  Text(
                    StringManager.emailAddress,
                    style: AppTextStyle.headerMediumStyle
                        .copyWith(color: Colors.black),
                  ),
                  Gap(10),
                  CustomTextField(
                    hintText: StringManager.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (!value!.contains('@')) {
                        return 'Email is not valid!';
                      }
                      if (value.isEmpty) {
                        return 'Email can not be empty';
                      }
                      return null;
                    },
                  ),
                  Gap(30),
                  Text(
                    StringManager.password,
                    style: AppTextStyle.headerMediumStyle
                        .copyWith(color: Colors.black),
                  ),
                  Gap(10),
                  CustomTextField(
                    hintText: StringManager.enterSecure,
                    obscureText: obscurePassword,
                    controller: passwordController,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      child: Icon(
                        obscurePassword
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
                  Gap(20),
                  Text(
                    StringManager.forgotPass,
                    style: AppTextStyle.headerMediumStyle
                        .copyWith(color: Colors.black),
                  ),
                  Gap(40),
                  GestureDetector(
                      onTap: () {}, child: blueButton(text: 'Login')),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: lineColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                      Gap(8),
                      Text(StringManager.or,
                          style: AppTextStyle.headerMediumStyle
                              .copyWith(color: Colors.black)),
                      Gap(8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: lineColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  GestureDetector(onTap: () {}, child: googleButton())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
