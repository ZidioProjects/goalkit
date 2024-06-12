import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/forgot_password_provider.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/forgot_password/reset_link.dart';
import 'package:provider/provider.dart';

import '../../resources/helpers/custom_textfield.dart';
import '../../resources/helpers/reuseable_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ForgotPasswordProvider>(
          builder: (ctx, forgotPasswordProvider, child) {
        return SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: forgotPasswordProvider.forgotPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringManager.forgotPass,
                    style:
                        AppTextStyle.headerStyle20.copyWith(color: Colors.black),
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
                    controller: forgotPasswordProvider.emailController,
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
                  GestureDetector(
                    onTap: () async {
                      bool isValid = forgotPasswordProvider
                          .forgotPasswordFormKey.currentState!
                          .validate();

                      if (isValid) {
                        bool isSubmitted =
                            await forgotPasswordProvider.forgotPassword(
                                email: forgotPasswordProvider.emailController.text
                                    .trim());
                        if (isSubmitted == true) {
                          forgotPasswordProvider.emailController.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetLink()));
                        } else {
                          Fluttertoast.showToast(
                              msg: forgotPasswordProvider.message,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black87,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    },
                    child: blueButton(text: 'Request reset link'),
                  ),
                ],
              ),
            ),
          )),
        );
      }),
    );
  }
}
