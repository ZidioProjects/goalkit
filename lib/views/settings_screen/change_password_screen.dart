import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/change_password_provider.dart';
import 'package:provider/provider.dart';

import '../../resources/helpers/custom_textfield.dart';
import '../../resources/helpers/reuseable_widgets.dart';
import '../../resources/managers/string_manager.dart';
import '../../resources/managers/styles_manager.dart';
import '../forgot_password/forgot_password_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;
  bool obscurePassword3 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text(
          StringManager.change,
          style: AppTextStyle.headerStyle20,
        ),
        centerTitle: true,
      ),
      body: Consumer<ChangeUserPasswordProvider>(
        builder: (ctx, changePasswordProvider, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: changePasswordProvider.changePasswordFormKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      Text(
                        StringManager.condition,
                        style: AppTextStyle.bodyStyle16.copyWith(
                            color: Colors.black),
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
                        controller: changePasswordProvider.emailController,
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
                        StringManager.current,
                        style: AppTextStyle.headerMediumStyle
                            .copyWith(color: Colors.black),
                      ),
                      const Gap(10),
                      CustomTextField(
                        hintText: StringManager.enter,
                        obscureText: obscurePassword1,
                        controller: changePasswordProvider.oldPasswordController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscurePassword1 = !obscurePassword1;
                            });
                          },
                          child: Icon(
                            obscurePassword1 ? Icons.visibility : Icons
                                .visibility_off,
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
                        controller: changePasswordProvider.newPasswordController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscurePassword2 = !obscurePassword2;
                            });
                          },
                          child: Icon(
                            obscurePassword2 ? Icons.visibility : Icons
                                .visibility_off,
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
                        StringManager.confirmNewPass,
                        style: AppTextStyle.headerMediumStyle
                            .copyWith(color: Colors.black),
                      ),
                      const Gap(10),
                      CustomTextField(
                        hintText: StringManager.confirmNewPass,
                        controller: changePasswordProvider.confirmNewPasswordController,
                        obscureText: obscurePassword3,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscurePassword3 = !obscurePassword3;
                            });
                          },
                          child: Icon(
                            obscurePassword3 ? Icons.visibility : Icons
                                .visibility_off,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == '') {
                            return "Please enter your password again";
                          } else {
                            if (changePasswordProvider.newPasswordController.text ==
                                changePasswordProvider.confirmNewPasswordController.text) {
                              return null;
                            } else {
                              return 'Passwords do not match';
                            }
                          }
                        },
                      ),
                      const Gap(30),
                      GestureDetector(
                        onTap: () async {
                          bool isValid = changePasswordProvider
                              .changePasswordFormKey.currentState!
                              .validate();

                          if (isValid) {
                            bool isSubmitted =
                            await changePasswordProvider.changeUserPassword(
                                email: changePasswordProvider.emailController.text.trim(),
                                oldPassword: changePasswordProvider
                                    .oldPasswordController.text
                                    .trim(),
                                newPassword: changePasswordProvider
                                    .newPasswordController.text
                                    .trim());
                            Navigator.pop(context);
                            if (isSubmitted == true) {
                              changePasswordProvider.emailController
                                  .clear();
                              changePasswordProvider.newPasswordController
                                  .clear();
                              changePasswordProvider.oldPasswordController
                                  .clear();
                              Fluttertoast.showToast(
                                  msg: changePasswordProvider.message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black87,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: changePasswordProvider.message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black87,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                        child: blueButton(text: changePasswordProvider.isLoading ? 'Saving...' : 'Save'),
                      ),
                      const Gap(20),
                      Center(
                        child: GestureDetector(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
    );
  }
}
