import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportPoblemTextfiled extends StatelessWidget {
  const ReportPoblemTextfiled({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).w,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        maxLines: 4,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Describe your problem',
            floatingLabelStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
            alignLabelWithHint: true,
            labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(width: 2, color: Colors.grey.withAlpha(100))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(width: 2, color: Colors.grey.withAlpha(100))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: AppColors.tileColor))),
      ),
    );
  }
}
