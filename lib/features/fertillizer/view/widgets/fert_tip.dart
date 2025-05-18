import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FertTip extends StatelessWidget {
  const FertTip({super.key, required this.tip});
  final String tip;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        color: AppColors.primaryColor,
        child: Center(
          child: SizedBox(
            width: 320.w,
            child: Text(
              maxLines: 3,
              textAlign: TextAlign.center,
              tip,
              style: TextStyle(
                  color: AppColors.signUpButtoColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
