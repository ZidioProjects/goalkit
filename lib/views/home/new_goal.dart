import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/helpers/custom_textfield.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/resources/managers/values_manager.dart';

class NewGoal extends StatefulWidget {
  const NewGoal({super.key});

  @override
  State<NewGoal> createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {
  var valueList = ['Health', 'Work', 'Personal'];
  String dropdownValue = 'Health';

  var valueList1 = ['Add Tag', 'High Priority', 'Low Priority', 'No Priority'];
  String dropdownValue1 = 'Add Tag';

  bool status = false;

  List options = ['Option 1', 'Option 2', 'Option 3'];
  String _selectedOption = 'Option 1';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedOption = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Transform.scale(
                scale: 0.2,
                child: SvgPicture.asset(
                  ImageManager.backwardArrow,
                ))),
        title: const Text(StringManager.createNew,
            style: AppTextStyle.headerStyle20),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: StringManager.wantAchieve,
                    hintStyle:
                        AppTextStyle.headerMediumStyle.copyWith(fontSize: 20, color: ash6Color),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const Gap(30),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black, width: 1)),
                      height: 30,
                      child: Center(
                        child: DropdownButton(
                          items: valueList.map((String item) {
                            return DropdownMenuItem(
                                value: item,
                                child: Text(item,
                                    style: AppTextStyle.bodyStyle16
                                        .copyWith(color: Colors.black)));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          value: dropdownValue,
                          borderRadius: BorderRadius.circular(10),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black.withOpacity(0.9)),
                          iconSize: 20,
                          underline: Container(),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.black,
                          size: 20,
                        ),
                        Gap(10),
                        Text(
                          StringManager.chooseDuration,
                          style: AppTextStyle.bodyStyle16
                              .copyWith(color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
                const Gap(20),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.black, width: 1)),
                  height: 30,
                  child: Center(
                    child: DropdownButton(
                      items: valueList1.map((String item) {
                        return DropdownMenuItem(
                            value: item,
                            child: Text(item,
                                style: AppTextStyle.bodyStyle16
                                    .copyWith(color: Colors.black)));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue1 = newValue!;
                        });
                      },
                      value: dropdownValue1,
                      borderRadius: BorderRadius.circular(10),
                      icon: Container(),
                      underline: Container(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                const Gap(30),
                Text(
                  StringManager.affirm,
                  style: AppTextStyle.bodyStyle16.copyWith(
                    color: Colors.black,
                  ),
                ),
                const Gap(30),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ash2Color, width: 1)),
                  child: const TextField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: StringManager.whySetting,
                      hintStyle: AppTextStyle.bodyStyle14,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                  ),
                ),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.black,
                          size: 20,
                        ),
                        Gap(5),
                        Text(
                          StringManager.remind,
                          style: AppTextStyle.bodyStyle16
                              .copyWith(color: Colors.black),
                        )
                      ],
                    ),
                    FlutterSwitch(
                      activeColor: primaryColor,
                      width: 40.0,
                      height: 25.0,
                      valueFontSize: 25.0,
                      toggleSize: 30.0,
                      value: status,
                      borderRadius: 30.0,
                      padding: 4.0,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                        });
                      },
                    )
                  ],
                ),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringManager.action,
                      style: AppTextStyle.bodyStyle16.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        buildDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          child: Row(
                            children: [
                              Icon(Icons.add, size: 20, color: primaryColor,),
                              Text(
                                StringManager.addAction,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.bodyStyle14.copyWith(
                                    color: primaryColor
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(30),
                Text(
                  StringManager.uploadDoc,
                  style: AppTextStyle.bodyStyle16
                      .copyWith(color: Colors.black),
                ),
                const Gap(10),
                Container(
                  width: logicalWidth(),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      StringManager.tagDoc,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyStyle14.copyWith(
                          color: primaryColor
                      ),
                    ),
                  ),
                ),
                const Gap(50),
                blueButton(text: StringManager.createGoal)
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(15),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringManager.createActionPlan,
                        style: AppTextStyle.headerStyle20,
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, size: 25, color: Colors.black,)),
                    ],
                  ),
                  Gap(25),
                  Text(
                    StringManager.whatActionPlan,
                    style: AppTextStyle.bodyStyle14
                        .copyWith(color: Colors.black),
                  ),
                  Gap(10),
                  CustomTextField(
                    hintText: 'I will....',
                    borderColor: Colors.black,
                    enabledBorderColor: Colors.black,
                    focusedBorderColor: Colors.black,
                  ),
                  Gap(20),
                  Text(
                    StringManager.howOften,
                    style: AppTextStyle.bodyStyle14
                        .copyWith(color: Colors.black),
                  ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioListTile<String>(
                        title: const Text('Daily'),
                        value: 'Option 1',
                        groupValue: _selectedOption,
                        onChanged: _handleRadioValueChange,
                      ),
                      RadioListTile<String>(
                        title: const Text('Weekly'),
                        value: 'Option 2',
                        groupValue: 'Option 1',
                        onChanged: _handleRadioValueChange,
                      ),
                      RadioListTile<String>(
                        title: const Text('Monthly'),
                        value: 'Option 3',
                        groupValue: _selectedOption,
                        onChanged: _handleRadioValueChange,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
