import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goalkit/api/providers/goals_category_provider.dart';
import 'package:goalkit/api/providers/login_provider.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:goalkit/views/category/category_goal_list.dart';
import 'package:goalkit/views/profile_screen/profile.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<void> _fetchGoalsFuture;

  @override
  void initState() {
    super.initState();
    _fetchGoalsFuture = Provider.of<GoalsAndCategoryProvider>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
         await Provider.of<GoalsAndCategoryProvider>(context, listen: false).fetchCategories();
        },
        child: SafeArea(
          child: Consumer2<LoginProvider, GoalsAndCategoryProvider>(
              builder: (ctx, loginProvider, goalAndCategoryProvider, child) {
                final displayName = loginProvider.userName.isNotEmpty
                    ? loginProvider.userName
                    : loginProvider.firstName.isNotEmpty
                    ? loginProvider.firstName
                    : 'User';
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      children: [
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: StringManager.hi,
                                style: AppTextStyle.headerStyle
                                    .copyWith(color: Colors.black, fontSize: 20),
                              ),
                              TextSpan(
                                text: displayName,
                                style: AppTextStyle.headerStyle
                                    .copyWith(color: Colors.black, fontSize: 20),
                              ),
                            ])),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StringManager.categories,
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
                              return goalAndCategoryProvider.goals.isEmpty
                                  ? Center(child: noGoals())
                                  : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: goalAndCategoryProvider.goals.length,
                                itemBuilder: (context, index) {
                                  final goal = goalAndCategoryProvider.goals[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CategoryGoalList(categoryName: goal.categoryName),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: primaryColor,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            goal.categoryName,
                                            style: AppTextStyle.bodyStyle16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
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
            StringManager.noCategory,
            style: AppTextStyle.headerMediumStyle.copyWith(color: Colors.black),
          ),
          Text(
            StringManager.addCategory,
            style: AppTextStyle.bodyStyle16.copyWith(color: ash3Color),
          ),
          Text(
            StringManager.create,
            style: AppTextStyle.bodyStyle16.copyWith(color: ash3Color),
          ),
        ],
      ),
    );
  }
}
