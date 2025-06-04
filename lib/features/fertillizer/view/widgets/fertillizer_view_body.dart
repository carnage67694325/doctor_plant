import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/fertillizer/view/widgets/fert_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FertillizerViewBody extends StatelessWidget {
  const FertillizerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrPlantBackground(
        child: Column(
          children: [
            SizedBox(
              height: 240.h,
            ),
            Text(
              '🌱 Fertilizers Usage Tips',
              style: TextStyle(
                  color: AppColors.signUpButtoColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 60.h,
            ),
            Center(child: FertListview()),
          ],
        ),
      ),
    );
  }
}
