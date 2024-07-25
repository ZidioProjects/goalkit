import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/login_provider.dart';
import 'package:goalkit/api/providers/signup_provider.dart';
import 'package:goalkit/resources/helpers/custom_textfield.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/authentication/login/login_page.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscurePassword = true;
  bool obscurePassword2 = true;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer2<SignUpProvider, LoginProvider>(builder: (ctx, signupProvider, loginProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: signupProvider.signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(40),
                    Text(
                      StringManager.createAccount,
                      style: AppTextStyle.headerStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: StringManager.alreadyHave,
                          style: AppTextStyle.bodyStyle16
                              .copyWith(color: Colors.black),
                        ),
                        TextSpan(
                          text: StringManager.login,
                          style: AppTextStyle.bodyStyle16
                              .copyWith(color: primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                        ),
                      ]),
                    ),
                    const Gap(30),
                    Text(
                      StringManager.firstName,
                      style: AppTextStyle.headerMediumStyle
                          .copyWith(color: Colors.black),
                    ),
                    const Gap(10),
                    CustomTextField(
                      hintText: StringManager.enterFirstName,
                      controller: firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "first name cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    const Gap(30),
                    Text(
                      StringManager.lastName,
                      style: AppTextStyle.headerMediumStyle
                          .copyWith(color: Colors.black),
                    ),
                    const Gap(10),
                    CustomTextField(
                      hintText: StringManager.enterLastName,
                      controller: lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "last name cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    const Gap(30),
                    Text(
                      StringManager.emailAddress,
                      style: AppTextStyle.headerMediumStyle
                          .copyWith(color: Colors.black),
                    ),
                    const Gap(10),
                    CustomTextField(
                      hintText: StringManager.enterEmail,
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
                    const Gap(30),
                    Text(
                      StringManager.confirmPass,
                      style: AppTextStyle.headerMediumStyle
                          .copyWith(color: Colors.black),
                    ),
                    const Gap(10),
                    CustomTextField(
                        labelText: StringManager.confirmSecure,
                        obscureText: obscurePassword2,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscurePassword2 = !obscurePassword2;
                            });
                          },
                          child: Icon(
                            obscurePassword2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm your Password';
                          } else if (value != passwordController.text) {
                            return 'Password does not match';
                          } else {
                            return null;
                          }
                        },
                     ),
                    const Gap(40),
                    GestureDetector(
                        onTap: () async {
                          bool isValid = signupProvider
                              .signupFormKey.currentState!
                              .validate();
                          if (isValid) {
                            bool isSubmitted = await signupProvider.signupUser(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim());
                            if (isSubmitted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                              emailController.clear();
                              passwordController.clear();
                              firstNameController.clear();
                              lastNameController.clear();
                              signupProvider.signupFormKey.currentState?.dispose();
                            } else {
                              Fluttertoast.showToast(
                                  msg: signupProvider.message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black87,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                        child: blueButton(
                            text: signupProvider.isLoading
                                ? 'Creating Account...'
                                : 'Create Account')),
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
                    GestureDetector(onTap: () {
                      loginProvider.googleLogin(context);
                    }, child: googleButton()),
                    const Gap(60),
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
