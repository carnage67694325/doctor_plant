import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:doct_plant/core/utils/functions/error_snack.dart';
import 'package:doct_plant/core/utils/functions/success_snack.dart';
import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/report_problem/view/view_model/report_problem/report_problem_cubit.dart';
import 'package:doct_plant/features/report_problem/view/widgets/report_problem_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
        child: BlocConsumer<ReportProblemCubit, ReportProblemState>(
          listener: (context, state) {
            if (state is ReportProblemSuccess) {
              successSnackBar(context, 'Problem reported successfully!');
            } else if (state is ReportProblemFaiulre) {
              errorSnackBar(context, state.errMessage);
            }
          },
          builder: (context, state) {
            return Column(
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
                      : () async {
                          await BlocProvider.of<ReportProblemCubit>(context)
                              .sumbitProblem(textEditingController.text);
                        },
                  child: state is ReportProblemLoading
                      ? LoadingAnimationWidget.inkDrop(
                          color: AppColors.primaryColor, size: 25.h)
                      : Text(
                          'Submit',
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
