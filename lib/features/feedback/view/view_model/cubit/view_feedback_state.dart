part of 'view_feedback_cubit.dart';

@immutable
sealed class ViewFeedbackState {}

final class ViewFeedbackInitial extends ViewFeedbackState {}

final class ViewFeedbackLoading extends ViewFeedbackState {}

final class ViewFeedbackSuccess extends ViewFeedbackState {
  final List<FeedbackModel> feedbacks;

  ViewFeedbackSuccess({required this.feedbacks});
}

final class ViewFeedbackFailure extends ViewFeedbackState {
  final String errMessage;

  ViewFeedbackFailure({required this.errMessage});
}
