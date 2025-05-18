import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doct_plant/features/common_diseases/model/dis_model.dart';

class PlantDiseaseCard extends StatelessWidget {
  final VoidCallback? onTap;
  final DisModel dis;

  const PlantDiseaseCard({
    super.key,
    this.onTap,
    required this.dis,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     spreadRadius: 2,
          //     blurRadius: 8,
          //     offset: Offset(0, 4), // shadow position
          //   ),
          // ],
          color: AppColors.primaryColor.withAlpha(0),
          borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        children: [
          SizedBox(
            height: 24.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: dis.image,
              height: 200.h,
              width: 300.w,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            dis.name,
            style: TextStyle(
              fontSize: 24.sp,
              color: AppColors.signUpButtoColor,
            ),
          ),
          Text(
            dis.desc,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          )
        ],
      ),
    );
  }
}
