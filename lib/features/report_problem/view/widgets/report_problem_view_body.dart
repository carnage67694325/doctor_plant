import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/report_problem/view/widgets/report_problem_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportProblemViewBody extends StatefulWidget {
  const ReportProblemViewBody({super.key});

  @override
  State<ReportProblemViewBody> createState() => _ReportProblemViewBodyState();
}

class _ReportProblemViewBodyState extends State<ReportProblemViewBody> {
  final TextEditingController textEditingController = TextEditingController();
  bool isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      setState(() {
        isTextEmpty = textEditingController.text.trim().isEmpty;
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrPlantBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ReportPoblemTextfiled(
              controller: textEditingController,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isTextEmpty ? Colors.grey : AppColors.tileColor,
                minimumSize: Size(150.w, 50.h),
              ),
              onPressed: isTextEmpty
                  ? null
                  : () {
                      // Your submit logic
                    },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
