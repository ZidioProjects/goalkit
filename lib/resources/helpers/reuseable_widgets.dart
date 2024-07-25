import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/resources/managers/values_manager.dart';

Widget blueButton({required text}){
  return Container(
    height: 48,
    width: logicalWidth(),
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1000),
      ),
    ),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyle.headerMediumStyle,
      ),
    ),
  );
}

Widget whiteButton(text, double width){
  return Container(
    height: 48,
    width: width,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: primaryColor,
        width: 1
      )
    ),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyle.headerMediumStyle.copyWith(
          color: primaryColor
        ),
      ),
    ),
  );
}

Widget googleButton(){
  return Container(
    height: 48,
    width: logicalWidth(),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
            color: primaryColor,
            width: 1
        )
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ImageManager.googleIcon,
          height: 24,
          width: 24,
        ),
        Gap(20),
        Text(
          StringManager.signGoogle,
          textAlign: TextAlign.center,
          style: AppTextStyle.headerMediumStyle.copyWith(
              color: primaryColor
          ),
        ),
      ],
    ),
  );
}