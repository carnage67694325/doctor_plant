import 'dart:developer';
import 'dart:io';

import 'package:doct_plant/core/Preferences/prefs_handler.dart';
import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/home/view/widgets/custom_elvated_button.dart';
import 'package:doct_plant/features/plant_diagnosis/view/view_model/cubit/plant_diagonsis_cubit.dart';
import 'package:doct_plant/features/plant_diagnosis/view/widgets/upload_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlantDiagnosisViewBody extends StatelessWidget {
  const PlantDiagnosisViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrPlantBackground(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UploadImageCard(),
          SizedBox(
            height: 20.h,
          ),
          CustomElvatedButton(
            onPressed: () async {},
            child: Text(
              "Analyze",
              style: TextStyle(color: AppColors.primaryColor, fontSize: 23.sp),
            ),
          ),
          SizedBox(
            height: 85.h,
          ),
        ],
      )),
    );
  }
}
