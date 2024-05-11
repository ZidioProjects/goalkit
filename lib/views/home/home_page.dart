import 'package:flutter/material.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                text: StringManager.hi,
                                style: AppTextStyle.headerMediumStyle.copyWith(color: Colors.black),
                              ),
                              TextSpan(
                                text: StringManager.name,
                                style: AppTextStyle.headerMediumStyle.copyWith(color: Colors.black),
                              ),
                            ]
                        )
                    ),
                    Image.asset(
                      ImageManager.profilepic,
                      width: 24,
                      height: 24,
                    )
                  ],
                ),
                Text(
                  StringManager.newDay,
                  style: AppTextStyle.headerMediumStyle.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
