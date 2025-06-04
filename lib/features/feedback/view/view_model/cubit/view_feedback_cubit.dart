import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doct_plant/constants/endpoints.dart';
import 'package:doct_plant/core/errors/failure.dart';
import 'package:doct_plant/core/utils/api_service.dart';
import 'package:doct_plant/features/feedback/models/feedback_model/feedback_model.dart';
import 'package:meta/meta.dart';

part 'view_feedback_state.dart';

class ViewFeedbackCubit extends Cubit<ViewFeedbackState> {
  final ApiService apiService;
  ViewFeedbackCubit(this.apiService) : super(ViewFeedbackInitial());
  Future<Either<Failure, List<FeedbackModel>>> viewFeedback() async {
    emit(ViewFeedbackLoading());

    try {
      var response = await apiService.get(endPoints: Endpoints.kReportProblem);

      List<FeedbackModel> feedbacks = response
          .map((e) => FeedbackModel.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(ViewFeedbackSuccess(feedbacks: feedbacks));
      return right(feedbacks);
    } on DioException catch (dioError) {
      final failure = ServerFailure.fromDioException(dioError);
      emit(ViewFeedbackFailure(errMessage: failure.errMessage));
      return left(failure);
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(ViewFeedbackFailure(errMessage: failure.errMessage));
      return left(failure);
    }
  }
}
