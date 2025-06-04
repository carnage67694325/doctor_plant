import 'dart:math';

import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:doct_plant/core/utils/functions/error_snack.dart';
import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/feedback/view/view_model/cubit/view_feedback_cubit.dart';
import 'package:doct_plant/features/feedback/view/widgets/feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FeedbackViewBody extends StatelessWidget {
  const FeedbackViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrPlantBackground(
        child: BlocConsumer<ViewFeedbackCubit, ViewFeedbackState>(
          listener: (context, state) {
            if (state is ViewFeedbackFailure) {
              errorSnackBar(context, state.errMessage);
            }
          },
          builder: (context, state) {
            if (state is ViewFeedbackSuccess) {
              return SafeArea(
                child: Column(
                  children: [
                    // Header
                    SizedBox(height: 175.h),
                    // Feedback List
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.feedbacks.length,
                        itemBuilder: (context, index) {
                          return FeedbackCard(
                            name: state.feedbacks[index].appUser ??
                                'Unknown User',
                            message: state.feedbacks[index].description ??
                                'No message provided',
                            index: index,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 250.h),
                  ],
                ),
              );
            } else if (state is ViewFeedbackLoading) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: AppColors.tileColor,
                  size: 50.sp,
                ),
              );
            } else {
              return Center(
                child: Text(
                  'No feedback available',
                  style: TextStyle(fontSize: 26.sp, color: Colors.black),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
