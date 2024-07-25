import 'package:flutter/material.dart';
import 'package:goalkit/api/model/goal_by_title.dart';
import 'package:goalkit/api/providers/goals_category_provider.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';
import 'package:provider/provider.dart';

class GoalDetailsPage extends StatefulWidget {
  final String goalTitle;
  const GoalDetailsPage({super.key, required this.goalTitle});

  @override
  State<GoalDetailsPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalDetailsPage> {
  late Future<List<GoalByTitle>> _goalDetailsFuture;

  @override
  void initState() {
    super.initState();
    _goalDetailsFuture =
        Provider.of<GoalsAndCategoryProvider>(context, listen: false)
            .fetchGoalDetails(widget.goalTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Goal Details',
            style: AppTextStyle.headerStyle20.copyWith(color: Colors.white),
          ),
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )
      ),
      body: FutureBuilder<List<GoalByTitle>>(
        future: _goalDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No details found'));
          } else {
            final goalDetail = snapshot.data![0];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: ${goalDetail.taskTitle}',
                        style: AppTextStyle.bodyStyle16
                            .copyWith(fontSize: 18, color: Colors.black)),
                    const SizedBox(height: 30),
                    Text('Category: ${goalDetail.category}',
                        style: AppTextStyle.bodyStyle16
                            .copyWith(fontSize: 18, color: Colors.black)),
                    const SizedBox(height: 30),
                    Text('Date Added: ${goalDetail.formattedDateAdded}',
                        style: AppTextStyle.bodyStyle16
                            .copyWith(fontSize: 18, color: Colors.black)),
                    //  SizedBox(height: ),
                    //  Text('Affirmation: ${goalDetail.tag}', style: TextStyle(fontSize: 18)),// Add other fields as necessary
                    //  SizedBox(height: 8),
                    //  Text('Tag: ${goalDetail.affirmation}', style: TextStyle(fontSize: 18)),// Add other fields as necessary
                    // ],
                  ]),
            );
          }
        },
      ),
    );
  }
}
