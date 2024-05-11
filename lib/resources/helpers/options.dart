import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goalkit/resources/managers/icons.dart';
import 'package:goalkit/resources/managers/image_manager.dart';

import '../managers/string_manager.dart';
import '../managers/styles_manager.dart';

//widget used in the profile

class Options extends StatelessWidget {
  const Options(
      {super.key, required this.text, required this.text2, required this.icon});

  final String text;
  final String text2;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          // StringManager.goalStreak,
          style: AppTextStyle.bodyStyle14,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text2,
              style: AppTextStyle.bodyStyle14,
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            icon
          ],
        ),
      ],
    );
  }
}

class OptionTwo extends StatelessWidget {
  const OptionTwo({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppTextStyle.bodyStyle14,
        ),
        SvgPicture.asset(IconsManager.forwardArrow)
      ],
    );
  }
}
