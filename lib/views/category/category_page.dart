import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
                    Text(
                      StringManager.goalsG,
                      style: AppTextStyle.headerStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                        const Gap(5),
                        Text(
                          StringManager.newCategory,
                          style: AppTextStyle.headerMediumStyle
                              .copyWith(color: Colors.black),
                        ),
                        const Gap(5),
                        Image.asset(
                          ImageManager.profilepic,
                          width: 30,
                          height: 30,
                        ),
                      ],
                    )
                  ],
                ),
                const Gap(80),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        ImageManager.pic2,
                        width: 400,
                        height: 200,
                      ),
                      const Gap(30),
                      Text(
                        StringManager.noCategory,
                        style: AppTextStyle.headerMediumStyle
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        StringManager.addCategory,
                        style:
                            AppTextStyle.bodyStyle16.copyWith(color: ash3Color),
                      ),
                      Text(
                        StringManager.create,
                        style:
                            AppTextStyle.bodyStyle16.copyWith(color: ash3Color),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
