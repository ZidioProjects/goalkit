import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/login_provider.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/views/settings_screen/change_password_screen.dart';
import 'package:goalkit/views/settings_screen/language_screen.dart';
import 'package:provider/provider.dart';

import '../../resources/managers/color_manager.dart';
import '../../resources/managers/styles_manager.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text(
      //     StringManager.settings,
      //     style: AppTextStyle.headerStyle.copyWith(color: Colors.black),
      //   ),
      // ),
      body: Consumer<LoginProvider>(builder: (ctx, loginProvider, child) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(40),
                  Text(
                    StringManager.settings,
                    style: AppTextStyle.headerStyle.copyWith(
                        color: Colors.black),
                  ),
                  const Gap(20),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                    height: 180,
                    width: 342,
                    color: ash4Color,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              ImageManager.profilepic,
                              height: 48.0,
                              width: 48.0,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${loginProvider.loginResponse?.firstname} ${loginProvider.loginResponse?.lastname} ',
                                    style: AppTextStyle.profileStyle1,
                                  ),
                                  Text(
                                    loginProvider.loginResponse?.email ?? 'useremail@gmail.com',
                                    style: AppTextStyle.bodyStyle14,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          StringManager.lorem,
                          style: AppTextStyle.bodyStyle14,
                        ),
                        const Gap(12),
                      ],
                    ),
                  ),
                  const Gap(30),
                  SettingsOptions(
                    text: StringManager.notification,
                    icon: Switch(
                      value: true,
                      onChanged: (value) {},
                      activeTrackColor: primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LanguageScreen(),
                        ),
                      );
                    },
                    child: SettingsOptions(
                        text: StringManager.lang,
                        icon: SvgPicture.asset(ImageManager.forwardArrow)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                    child: SettingsOptions(
                        text: StringManager.password,
                        icon: SvgPicture.asset(ImageManager.forwardArrow)),
                  )
                ],
              ),
            ),
          ),
        );
       }
      ),
    );
  }
}

class SettingsOptions extends StatelessWidget {
  const SettingsOptions({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          text,
          style: AppTextStyle.bodyStyle18,
        ),
        trailing: icon);
  }
}
