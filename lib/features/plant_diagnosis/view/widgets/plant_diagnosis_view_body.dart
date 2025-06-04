import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/plant_diagnosis/view/view_model/upload_image_cubit/plant_diagonsis_cubit.dart';
import 'package:doct_plant/features/plant_diagnosis/view/widgets/anaylze_button.dart';
import 'package:doct_plant/features/plant_diagnosis/view/widgets/upload_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlantDiagnosisViewBody extends StatelessWidget {
  const PlantDiagnosisViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UpLoadImageCubit, UploadImageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return DrPlantBackground(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UploadImageCard(),
              SizedBox(
                height: 20.h,
              ),
              state is UploadImageSucces ? AnalyzedButton() : SizedBox(),
              SizedBox(
                height: 85.h,
              ),
            ],
          ));
        },
      ),
    );
  }
}
