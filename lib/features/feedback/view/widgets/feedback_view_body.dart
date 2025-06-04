import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/feedback/view/widgets/feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackViewBody extends StatelessWidget {
  const FeedbackViewBody({super.key});

  // Sample feedback data
  final List<Map<String, String>> feedbackData = const [
    {'name': 'osama', 'message': 'test2'},
    {'name': 'Ahmed', 'message': 'Great app! Really helpful for plant care.'},
    {
      'name': 'Sara',
      'message': 'Love the plant identification feature. Very accurate!'
    },
    {
      'name': 'Mohamed',
      'message':
          'The care reminders are perfect. Never forget to water my plants now.'
    },
    {
      'name': 'Fatima',
      'message': 'Beautiful interface and easy to use. Highly recommended!'
    },
    {
      'name': 'Ali',
      'message': 'The plant health analysis is amazing. Saved my dying plant!'
    },
    {
      'name': 'Nour',
      'message': 'Perfect for beginners like me. Learning so much about plants.'
    },
    {
      'name': 'Hassan',
      'message': 'The community feature is great for sharing plant tips.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrPlantBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              SizedBox(height: 175.h),
              // Feedback List
              Expanded(
                child: ListView.builder(
                  itemCount: feedbackData.length,
                  itemBuilder: (context, index) {
                    return FeedbackCard(
                      name: feedbackData[index]['name']!,
                      message: feedbackData[index]['message']!,
                      index: index,
                    );
                  },
                ),
              ),
              SizedBox(height: 250.h),
            ],
          ),
        ),
      ),
    );
  }
}
