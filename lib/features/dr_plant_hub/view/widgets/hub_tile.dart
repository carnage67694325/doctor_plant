import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HubTile extends StatelessWidget {
  const HubTile({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final IconData icon;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 150.h,
          width: 180.w,
          decoration: BoxDecoration(
              color: AppColors.signUpButtoColor,
              borderRadius: BorderRadius.circular(16.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 45.sp,
                color: Colors.white,
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              )
            ],
          )),
    );
  }
}
