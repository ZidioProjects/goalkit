import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/goals_category_provider.dart';
import 'package:goalkit/api/providers/login_provider.dart';
import 'package:goalkit/resources/helpers/reuseable_widgets.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:provider/provider.dart';

class NewGoal extends StatefulWidget {
  const NewGoal({super.key});

  @override
  State<NewGoal> createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {

  final _categoryController = TextEditingController();
  final _taskTitleController = TextEditingController();
  final _affirmationController = TextEditingController();
  final _tagController = TextEditingController();

  var valueList = [
    'Health', 'Work', 'Personal',
    'Faith', 'Sports', 'Motivation', 'Relationship',
    'Food', 'Inspiration', 'Spiritual', 'Finance',
    'Family', 'Love', 'Business', 'Education', 'others'];

  var valueList1 = ['Add Tag', 'High Priority', 'Low Priority', 'No Priority'];

  @override
  void initState() {
    super.initState();
    _categoryController.text = 'Health'; // Set a default value
    _tagController.text = 'Add Tag';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(StringManager.createNew,
            style: AppTextStyle.headerStyle20),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer2<GoalsAndCategoryProvider, LoginProvider>(builder: (ctx, goalsAndCategoryProvider, loginProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _taskTitleController,
                    style: AppTextStyle.bodyStyle16.copyWith(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: StringManager.wantAchieve,
                      hintStyle: AppTextStyle.headerMediumStyle.copyWith(
                          fontSize: 20, color: ash6Color),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const Gap(30),
                  Text(
                    StringManager.chooseCategory,
                    style: AppTextStyle.bodyStyle16.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.black, width: 1)),
                        height: 30,
                        child: Center(
                          child: DropdownButton<String>(
                            items: valueList.map((String item) {
                              return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item,
                                      style: AppTextStyle.bodyStyle16
                                          .copyWith(color: Colors.black)));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _categoryController.text = newValue!;
                              });
                            },
                            value: _categoryController.text,
                            borderRadius: BorderRadius.circular(10),
                            icon: Icon(Icons.keyboard_arrow_down,
                                color: Colors.black.withOpacity(0.9)),
                            iconSize: 20,
                            underline: Container(),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () async {
                      bool isSubmitted =
                      await goalsAndCategoryProvider.addGoalCategory(
                        categoryName: _categoryController.text,
                      );
                      if (isSubmitted == true) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Category Created!!'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Continue'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: goalsAndCategoryProvider.message,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.black87,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: primaryColor,
                                  width: 1
                              )
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  StringManager.submit,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyStyle14.copyWith(
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(30),
                  Text(
                    StringManager.chooseTag,
                    style: AppTextStyle.bodyStyle16.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const Gap(10),
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
                            _tagController.text = newValue!;
                          });
                        },
                        value: _tagController.text,
                        borderRadius: BorderRadius.circular(10),
                        icon: Container(),
                        underline: Container(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const Gap(40),
                  Text(
                    StringManager.affirm,
                    style: AppTextStyle.bodyStyle16.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const Gap(15),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ash2Color, width: 1)
                    ),
                    child: TextField(
                      maxLines: 6,
                      controller: _affirmationController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: StringManager.whySetting,
                        hintStyle: AppTextStyle.bodyStyle14,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                    ),
                  ),
                  const Gap(80),
                  GestureDetector(
                      onTap: () async {
                        bool isSubmitted =
                        await goalsAndCategoryProvider.addGoal(
                              category: _categoryController.text.trim(),
                              email: loginProvider.emailController.text.trim(),
                              taskTitle: _taskTitleController.text.trim(),
                              affirmation: _affirmationController.text.trim(),
                              tag: _tagController.text.trim(),
                              document: '',
                              actionPlan: '',
                              actionPlanFrequency: ''
                        );
                        if (isSubmitted == true) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Goal Created!!'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Continue'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          loginProvider.emailController.clear();
                          _affirmationController.clear();
                          _taskTitleController.clear();
                        } else {
                        }
                      },
                      child: blueButton(text: StringManager.createGoal)),
                  const Gap(100)
                ],
              ),
            ),
           );
          }
         )
       )
    );
  }
}
