import 'dart:io';
import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:doct_plant/features/plant_diagnosis/view/view_model/cubit/plant_diagonsis_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadImageCard extends StatefulWidget {
  const UploadImageCard({
    super.key,
  });

  @override
  State<UploadImageCard> createState() => _UploadImageCardState();
}

class _UploadImageCardState extends State<UploadImageCard> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantDiagonsisCubit, PlantDiagonsisState>(
      listener: (context, state) {
        if (state is PlantDiagonsisSucces) {
          imagePath = state.imagePath;
        }
      },
      builder: (context, state) {
        return GestureDetector(
            onTap: () {
              BlocProvider.of<PlantDiagonsisCubit>(context).pickImage();
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    color: AppColors.primaryColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: imagePath != null
                          ? Image.file(
                              File(imagePath!),
                              height: 200.h,
                              width: 300.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 200.h,
                                width: 300.w,
                                color: Colors.grey.shade200,
                                child: const Center(
                                    child: Icon(
                                  Icons.error_outline,
                                  size: 64,
                                  color: Colors.grey,
                                )),
                              ),
                            )
                          : SizedBox(
                              height: 200.h,
                              width: 300.w,
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Pick Image",
                                  style: TextStyle(
                                      fontSize: 36.sp,
                                      color: AppColors.signUpButtoColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                    ))));
      },
    );
  }
}
