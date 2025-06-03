part of 'plant_diagonsis_cubit.dart';

@immutable
sealed class UploadImageState {}

final class UploadImageInitial extends UploadImageState {}

final class UpLoadImageLoading extends UploadImageState {}

final class UploadImageFailure extends UploadImageState {
  final String erroMessage;

  UploadImageFailure({required this.erroMessage});
}

final class UploadImageSucces extends UploadImageState {
  final String imagePath;
  final String? imageToken;

  UploadImageSucces({
    required this.imagePath,
    this.imageToken,
  });
}
