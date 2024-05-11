import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goalkit/views/profile_screen/calendar.dart';
import 'package:goalkit/views/profile_screen/reward.dart';
import '../../resources/helpers/options.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Gap(40),
              //header
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: SvgPicture.asset(ImageManager.backwardArrow)),
                  const Gap(135),
                  Text(StringManager.profile,
                      style: AppTextStyle.headerStyle20),
                ],
              ),
              const Gap(30),
              //user profile container
              Container(
                padding: EdgeInsets.all(18.0),
                height: 204,
                width: 342,
                color: Colors.white,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StringManager.userName,
                                style: AppTextStyle.profileStyle1,
                              ),
                              Text(
                                StringManager.userEmail,
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
                    Container(
                      height: 38,
                      width: 113,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Enter',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.headerMediumStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(20),

              // motivation container
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                width: 342,
                height: 130,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringManager.myMotivation,
                      style: AppTextStyle.profileStyle1,
                    ),
                    Text(
                      StringManager.lorem2,
                      style: AppTextStyle.bodyStyle13,
                    ),
                  ],
                ),
              ),
              const Gap(20),

              //options container
              Container(
                padding: EdgeInsets.all(18.0),
                width: 343,
                height: 234,
                color: Colors.white,
                child: Column(children: [
                  Options(
                    text: StringManager.goalStreak,
                    text2: StringManager.days,
                    icon: SvgPicture.asset(ImageManager.fire2),
                  ),
                  Gap(35),
                  OptionTwo(
                    text: StringManager.settings,
                  ),
                  Gap(35),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalendarPage(),
                        ),
                      );
                    },
                    child: Options(
                      text: StringManager.calendar,
                      text2: StringManager.activities,
                      icon: SvgPicture.asset(ImageManager.forwardArrow),
                    ),
                  ),
                  Gap(35),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RewardPage(),
                        ),
                      );
                    },
                    child: OptionTwo(text: StringManager.rewards),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
