import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../resources/managers/icons.dart';
import '../../resources/managers/string_manager.dart';
import '../../resources/managers/styles_manager.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  bool value = false;
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
                  Text(StringManager.calendar,
                      style: AppTextStyle.headerStyle20),
                ],
              ),
              const Gap(30),
              //achievement
              Text(
                StringManager.urGoal,
                style: AppTextStyle.headerStyle24,
              ),
              Text(
                StringManager.overView,
                style: AppTextStyle.bodyStyle14,
              ),
              const Gap(30),
              Container(
                child: TableCalendar(
                  rowHeight: 40,
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  availableGestures: AvailableGestures.all,
                  focusedDay: today,
                  firstDay: DateTime.utc(2020, 1, 31),
                  lastDay: DateTime.utc(2040, 12, 31),
                  onDaySelected: _onDaySelected,
                ),
              ),
              const Gap(20),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(ImageManager.bowl),
                            const Gap(20),
                            Text(StringManager.mealPlan),
                            const Gap(10),
                            SvgPicture.asset(IconsManager.purple),
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
                            Image.asset(ImageManager.bowl),
                            const Gap(20),
                            Text(StringManager.stay),
                            const Gap(10),
                            SvgPicture.asset(IconsManager.blue),
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
                            Image.asset(ImageManager.bowl),
                            const Gap(20),
                            Text(StringManager.portion),
                            const Gap(10),
                            SvgPicture.asset(IconsManager.orange),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
