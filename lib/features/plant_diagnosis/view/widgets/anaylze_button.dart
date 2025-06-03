import 'dart:developer';

import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:doct_plant/core/utils/functions/error_snack.dart';
import 'package:doct_plant/features/home/view/widgets/custom_elvated_button.dart';
import 'package:doct_plant/features/plant_diagnosis/view/view_model/image_analysis/image_analysis_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AnalyzedButton extends StatelessWidget {
  const AnalyzedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageAnalysisCubit, ImageAnalysisState>(
      listener: (context, state) {
        if (state is ImageAnalysisFailure) {
          errorSnackBar(context, state.errMessage);
          log(state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomElvatedButton(
          onPressed: () async {
            await BlocProvider.of<ImageAnalysisCubit>(context).analyzeImage();
          },
          child: state is ImageAnalysisInitial
              ? Text(
                  "Analyze",
                  style:
                      TextStyle(color: AppColors.primaryColor, fontSize: 23.sp),
                )
              : state is ImageAnalysisSuccess
                  ? Text(state.analysisResult,
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 23.sp))
                  : LoadingAnimationWidget.inkDrop(
                      color: Colors.white, size: 25.h),
        );
      },
    );
  }
}
