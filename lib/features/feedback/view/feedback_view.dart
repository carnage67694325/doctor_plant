import 'package:doct_plant/features/feedback/view/view_model/cubit/view_feedback_cubit.dart';
import 'package:doct_plant/features/feedback/view/widgets/feedback_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  @override
  void initState() {
    BlocProvider.of<ViewFeedbackCubit>(context).viewFeedback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const FeedbackViewBody();
  }
}
