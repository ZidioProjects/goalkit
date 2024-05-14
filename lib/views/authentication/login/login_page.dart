import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/login_provider.dart';
import 'package:goalkit/resources/helpers/custom_textfield.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/resources/navigation/bottom_navigation.dart';
import 'package:goalkit/views/authentication/signup/signup_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<LoginProvider>(builder: (ctx, loginProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: loginProvider.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(40),
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
                                    builder: (context) => const SignupPage()),
                              );
                            },
                        ),
                      ]),
                    ),
                    const Gap(30),
                    Text(
                      StringManager.emailAddress,
                      style: AppTextStyle.headerMediumStyle
                          .copyWith(color: Colors.black),
                    ),
                    const Gap(10),
                    CustomTextField(
                      hintText: StringManager.emailAddress,
                      controller: loginProvider.emailController,
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
                    const Gap(30),
                    Text(
                      StringManager.password,
                      style: AppTextStyle.headerMediumStyle
                          .copyWith(color: Colors.black),
                    ),
                    const Gap(10),
                    CustomTextField(
                      hintText: StringManager.enterSecure,
                      obscureText: obscurePassword,
                      controller: loginProvider.passwordController,
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
                    const Gap(20),
                    Text(
                      StringManager.forgotPass,
                      style: AppTextStyle.headerMediumStyle
                          .copyWith(color: Colors.black),
                    ),
                    const Gap(40),
                    GestureDetector(
                        onTap: () async {
                          bool isValid = loginProvider
                              .loginFormKey.currentState!
                              .validate();
                          if (isValid) {
                            final email =
                                loginProvider.emailController.text.trim();
                            final password =
                                loginProvider.passwordController.text.trim();
                            bool isSubmitted = await loginProvider.loginUser(
                                email: email, password: password);
                            if (isSubmitted == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Nav()),
                              );
                              loginProvider.emailController.clear();
                              loginProvider.passwordController.clear();
                            } else {
                              Fluttertoast.showToast(
                                msg: loginProvider.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black87,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          }
                        },
                        child: blueButton(
                            text: loginProvider.isLoading
                                ? 'Logging in...'
                                : 'Login')),
                    const Gap(20),
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
                        const Gap(8),
                        Text(StringManager.or,
                            style: AppTextStyle.headerMediumStyle
                                .copyWith(color: Colors.black)),
                        const Gap(8),
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
                    const Gap(20),
                    GestureDetector(onTap: () {}, child: googleButton())
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
