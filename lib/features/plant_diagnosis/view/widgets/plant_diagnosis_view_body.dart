import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/plant_diagnosis/view/widgets/upload_image_card.dart';
import 'package:flutter/material.dart';
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
            height: 210.h,
          )
        ],
      )),
    );
  }
}
