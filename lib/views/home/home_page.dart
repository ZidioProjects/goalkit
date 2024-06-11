import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/login_provider.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/home/widget/tab_section.dart';
import 'package:goalkit/views/profile_screen/profile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<LoginProvider>(builder: (ctx, loginProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: StringManager.hi,
                          style: AppTextStyle.headerStyle
                              .copyWith(color: Colors.black),
                        ),
                        TextSpan(
                          text: loginProvider.loginResponse?.firstname ??
                              'Senior',
                          style: AppTextStyle.headerStyle
                              .copyWith(color: Colors.black),
                        ),
                      ])),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Profile(),
                            ),
                          );
                        },
                        child: Image.asset(
                          ImageManager.profilepic,
                          width: 30,
                          height: 30,
                        ),
                      )
                    ],
                  ),
                  Text(
                    StringManager.newDay,
                    style: AppTextStyle.bodyStyle16.copyWith(color: ash2Color),
                  ),
                  const Gap(20),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBarSelector(),
                        const Gap(10),
                        Text(StringManager.task),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageManager.pot),
                                const Gap(20),
                                Text(StringManager.mealPlan),
                                const Gap(10),
                                SvgPicture.asset(ImageManager.purple),
                              ],
                            ),
                            const Gap(130),
                            Checkbox(
                              checkColor: primaryColor,
                              value: this.value,
                              onChanged: (bool? value) {
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageManager.cup),
                                const Gap(20),
                                Text(StringManager.stay),
                                const Gap(10),
                                SvgPicture.asset(ImageManager.blue),
                              ],
                            ),
                            const Gap(100),
                            Checkbox(
                              checkColor: primaryColor,
                              value: this.value,
                              onChanged: (bool? value) {
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageManager.food),
                                const Gap(20),
                                Text(StringManager.portion),
                                const Gap(10),
                                SvgPicture.asset(ImageManager.orange),
                              ],
                            ),
                            const Gap(130),
                            Checkbox(
                              checkColor: primaryColor,
                              value: this.value,
                              onChanged: (bool? value) {
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageManager.man),
                                const Gap(20),
                                Text(StringManager.jog),
                                const Gap(10),
                                SvgPicture.asset(ImageManager.purple),
                              ],
                            ),
                            const Gap(100),
                            Checkbox(
                              checkColor: primaryColor,
                              value: this.value,
                              onChanged: (bool? value) {
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(50),
                  Center(child: whiteButton('New Goal', 300))
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
