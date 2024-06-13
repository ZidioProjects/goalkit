import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';

class TabBarSelector extends StatelessWidget {
  const TabBarSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TabBar(
          indicatorWeight: 0.5,
          tabs: [
            Tab(
              text: StringManager.weeklyGoals,
            ),
            Tab(
              text: StringManager.monthlyGoals,
            )
          ],
        ),
        const Gap(30),
        SizedBox(
          height: 150,
          child: TabBarView(children: [
            Container(
              width: 150,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  //CONTAINER 1
                  Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(right: 16),
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ash4Color),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            StringManager.daysLeft,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          Text(
                            StringManager.save,
                          ),
                          const Gap(30),
                          Text(StringManager.deadline),
                          const Gap(10),
                          LinearProgressIndicator(
                            value: 0.2,
                          ),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(right: 16),
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ash4Color),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            StringManager.daysLeft,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          Text(
                            StringManager.save,
                          ),
                          const Gap(30),
                          Text(StringManager.deadline),
                          const Gap(10),
                          LinearProgressIndicator(
                            value: 0.2,
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Container(
              width: 150,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  //CONTAINER 1
                  Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(right: 16),
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ash4Color),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            StringManager.daysLeft,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          Text(
                            StringManager.save,
                          ),
                          const Gap(30),
                          Text(StringManager.deadline),
                          const Gap(10),
                          LinearProgressIndicator(
                            value: 0.2,
                          ),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(right: 16),
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ash4Color),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            StringManager.daysLeft,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          Text(
                            StringManager.save,
                          ),
                          const Gap(30),
                          Text(StringManager.deadline),
                          const Gap(10),
                          LinearProgressIndicator(
                            value: 0.2,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
