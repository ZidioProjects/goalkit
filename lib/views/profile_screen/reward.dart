import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/color_manager.dart';

import '../../resources/managers/icons.dart';
import '../../resources/managers/string_manager.dart';
import '../../resources/managers/styles_manager.dart';

class RewardPage extends StatelessWidget {
  const RewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),
              //header
              Row(
                children: [
                  SvgPicture.asset(IconsManager.backwardArrow),
                  const Gap(135),
                  Text(StringManager.rewards,
                      style: AppTextStyle.headerStyle20),
                ],
              ),
              const Gap(30),
              //achievement
              Text(
                StringManager.achieve,
                style: AppTextStyle.headerStyle24,
              ),
              const Gap(30),

              // <<<<<<<<PROGRESS BAR ONE>>>>>>>>
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconsManager.fire3,
                        ),
                        const Gap(30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringManager.streak,
                              style: AppTextStyle.bodyStyle16B,
                            ),
                            Text(
                              StringManager.reach,
                              style: AppTextStyle.bodyStyle14,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(left: 80),
                          height: 6,
                          width: 194,
                          child: LinearProgressIndicator(
                            value: 0.5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          "50%",
                          style: AppTextStyle.bodyStyle14,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Gap(30),

              //<<<<<<<<PROGRESS BAR TWO>>>>>>>>
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconsManager.diamond,
                        ),
                        const Gap(30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringManager.goal,
                              style: AppTextStyle.bodyStyle16B,
                            ),
                            Text(
                              StringManager.comp,
                              style: AppTextStyle.bodyStyle14,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(left: 80),
                          height: 6,
                          width: 194,
                          child: LinearProgressIndicator(
                            value: 0.12,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          "12%",
                          style: AppTextStyle.bodyStyle14,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Gap(30),

              //<<<<<<<<PROGRESS BAR ONE>>>>>>>>
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconsManager.fire3,
                        ),
                        const Gap(30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringManager.streak,
                              style: AppTextStyle.bodyStyle16B,
                            ),
                            Text(
                              StringManager.goal,
                              style: AppTextStyle.bodyStyle14,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(left: 80),
                          height: 6,
                          width: 194,
                          child: LinearProgressIndicator(
                            value: 1.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          "100%",
                          style: AppTextStyle.bodyStyle14,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
