import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/profile_screen/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                text: StringManager.hi,
                                style: AppTextStyle.headerStyle.copyWith(color: Colors.black),
                              ),
                              TextSpan(
                                text: StringManager.name,
                                style: AppTextStyle.headerStyle.copyWith(color: Colors.black),
                              ),
                            ]
                        )
                    ),
                    GestureDetector(
                      onTap: (){
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
                const Gap(50),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        ImageManager.pic1,
                        width: 400,
                        height: 200,
                      ),
                      const Gap(30),
                      Text(
                        StringManager.getStarted,
                        style: AppTextStyle.headerMediumStyle.copyWith(color: Colors.black),
                      ),
                      Text(
                        StringManager.startWith,
                        style: AppTextStyle.bodyStyle16.copyWith(color: ash3Color),
                      ),
                    ],
                  ),
                ),
                const Gap(100),
                whiteButton('New Goal', 300)
              ],
            ),
          ),
        ),
      ),

    );
  }
}
