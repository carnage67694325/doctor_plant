part of 'image_analysis_cubit.dart';

@immutable
sealed class ImageAnalysisState {}

final class ImageAnalysisInitial extends ImageAnalysisState {}

final class ImageAnalysisLoading extends ImageAnalysisState {}

final class ImageAnalysisSuccess extends ImageAnalysisState {
  final String analysisResult;

  ImageAnalysisSuccess({required this.analysisResult});
}

final class ImageAnalysisFailure extends ImageAnalysisState {
  final String errMessage;

  ImageAnalysisFailure({required this.errMessage});
}
