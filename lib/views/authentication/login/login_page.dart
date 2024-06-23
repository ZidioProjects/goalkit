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
import 'package:goalkit/resources/navigation/bottom_navigation.dart';
import 'package:goalkit/views/authentication/signup/signup_page.dart';
import 'package:provider/provider.dart';

import '../../forgot_password/forgot_password_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscurePassword = true;
  bool obscurePassword1 = true;
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
                              showSignUpBottomSheet(context: context);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const SignupPage()),
                              // );
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()),
                        );
                      },
                      child: Text(
                        StringManager.forgotPass,
                        style: AppTextStyle.headerMediumStyle
                            .copyWith(color: Colors.black),
                      ),
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
                              loginProvider.loginFormKey.currentState!
                                  .dispose();
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
                    GestureDetector(
                        onTap: () {
                          loginProvider.googleLogin(context);
                        },
                        child: googleButton())
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  showSignUpBottomSheet({
    required BuildContext context,
  }) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0))),
        builder: (context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Consumer2<SignUpProvider, LoginProvider>(
                  builder: (ctx, signupProvider, loginProvider, child) {
                return SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                      Navigator.pop(context);
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
                              obscureText: obscurePassword1,
                              controller: passwordController,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscurePassword1 = !obscurePassword1;
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
                                    bool isSubmitted =
                                        await signupProvider.signupUser(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                            firstName:
                                                firstNameController.text.trim(),
                                            lastName:
                                                lastNameController.text.trim());
                                    if (isSubmitted) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Account Created!!'),
                                            content: Text("We are happy to have you"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Login with your details'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const LoginPage()),
                                      // );
                                      emailController.clear();
                                      passwordController.clear();
                                      firstNameController.clear();
                                      lastNameController.clear();
                                      signupProvider.signupFormKey.currentState
                                          ?.dispose();
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
                            GestureDetector(
                                onTap: () {
                                  loginProvider.googleLogin(context);
                                },
                                child: googleButton()),
                            const Gap(60),
                          ],
                        ),
                      )),
                );
              }));
        });
  }
}
