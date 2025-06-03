import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doct_plant/constants/endpoints.dart';
import 'package:doct_plant/core/Preferences/prefs_handler.dart';
import 'package:doct_plant/core/errors/failure.dart';
import 'package:doct_plant/core/utils/api_service.dart';
import 'package:meta/meta.dart';

part 'image_analysis_state.dart';

class ImageAnalysisCubit extends Cubit<ImageAnalysisState> {
  final ApiService apiService;
  ImageAnalysisCubit(this.apiService) : super(ImageAnalysisInitial());
  Future<Either<Failure, String>> analyzeImage() async {
    try {
      final String? imageToken = await PrefasHandelr.getImageToken();
      emit(ImageAnalysisLoading());
      final response = await apiService.analyzeImage(
        endpoint: Endpoints.kAnalyzeImage,
        imageToken: imageToken!,
      );
      final result = response['result'] as String;
      emit(ImageAnalysisSuccess(analysisResult: result));
      return Right(imageToken);
    } on DioException catch (dioError) {
      final failure = ServerFailure.fromDioException(dioError);
      emit(ImageAnalysisFailure(errMessage: failure.errMessage));
      return left(failure);
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(ImageAnalysisFailure(errMessage: failure.errMessage));
      return left(failure);
    }
  }
}
