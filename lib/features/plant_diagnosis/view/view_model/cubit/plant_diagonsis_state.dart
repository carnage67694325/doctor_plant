part of 'plant_diagonsis_cubit.dart';

@immutable
sealed class PlantDiagonsisState {}

final class PlantDiagonsisInitial extends PlantDiagonsisState {}

final class PlantDiagonsisLoading extends PlantDiagonsisState {}

final class PlantDiagonsisFailure extends PlantDiagonsisState {
  final String erroMessage;

  PlantDiagonsisFailure({required this.erroMessage});
}

final class PlantDiagonsisSucces extends PlantDiagonsisState {
  final String imagePath;
  final String? imageToken;

  PlantDiagonsisSucces({
    required this.imagePath,
    this.imageToken,
  });
}
