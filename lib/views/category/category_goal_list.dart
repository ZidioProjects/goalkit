import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/goals_category_provider.dart';
import 'package:goalkit/api/providers/login_provider.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/category/goal_details_page.dart';
import 'package:provider/provider.dart';

class CategoryGoalList extends StatefulWidget {
  final String categoryName;
  const CategoryGoalList({super.key, required this.categoryName});

  @override
  State<CategoryGoalList> createState() => _CategoryGoalListState();
}

class _CategoryGoalListState extends State<CategoryGoalList> {
  late Future<void> _fetchGoalsFuture;

  @override
  void initState() {
    super.initState();
    _fetchGoalsFuture = Provider.of<GoalsAndCategoryProvider>(context, listen: false)
        .fetchGoalsByCategory(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        title: Text(widget.categoryName,
            style: AppTextStyle.headerStyle20.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer2<LoginProvider, GoalsAndCategoryProvider>(
            builder: (ctx, loginProvider, goalAndCategoryProvider, child) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringManager.goalsG,
                            style: AppTextStyle.headerStyle
                                .copyWith(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      const Gap(20),
                      FutureBuilder(
                        future: _fetchGoalsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            return Consumer<GoalsAndCategoryProvider>(
                              builder: (context, goalAndCategoryProvider, child) {
                                if (goalAndCategoryProvider.goalsByCategory.isEmpty) {
                                  return Center(child: noGoals());
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: goalAndCategoryProvider.goalsByCategory.length,
                                    itemBuilder: (context, index) {
                                      final goal = goalAndCategoryProvider.goalsByCategory[index];
                                      return ListTile(
                                        title: Text(goal.taskTitle, style: AppTextStyle.bodyStyle16.copyWith(color: Colors.black),),
                                        trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: primaryColor,),
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                              builder: (context) => GoalDetailsPage(goalTitle: goal.taskTitle),
                                          ));
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget noGoals() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageManager.pic2,
            width: 400,
            height: 200,
          ),
          const Gap(30),
          Text(
            StringManager.noGoals,
            style: AppTextStyle.headerMediumStyle.copyWith(color: Colors.black),
          ),
          // Text(
          //   StringManager.addCategory,
          //   style: AppTextStyle.bodyStyle16.copyWith(color: ash3Color),
          // ),
          // Text(
          //   StringManager.create,
          //   style: AppTextStyle.bodyStyle16.copyWith(color: ash3Color),
          // ),
        ],
      ),
    );
  }
}
