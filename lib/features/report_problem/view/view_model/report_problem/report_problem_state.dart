part of 'report_problem_cubit.dart';

@immutable
sealed class ReportProblemState {}

final class ReportProblemInitial extends ReportProblemState {}

final class ReportProblemLoading extends ReportProblemState {}

final class ReportProblemSuccess extends ReportProblemState {}

final class ReportProblemFaiulre extends ReportProblemState {
  final String errMessage;

  ReportProblemFaiulre({required this.errMessage});
}
