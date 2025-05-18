import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton({
    super.key,
    this.onPressed,
    this.child,
    this.backgroundColor,
  });
  final void Function()? onPressed;
  final Widget? child;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(300.w, 50.h),
          backgroundColor: backgroundColor ?? AppColors.loginButtonColor,
        ),
        onPressed: () {},
        child: child);
  }
}
