import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doct_plant/constants/endpoints.dart';
import 'package:doct_plant/core/Preferences/prefs_handler.dart';
import 'package:doct_plant/core/errors/failure.dart';
import 'package:doct_plant/core/utils/api_service.dart';
import 'package:meta/meta.dart';

part 'report_problem_state.dart';

class ReportProblemCubit extends Cubit<ReportProblemState> {
  final ApiService apiService;
  ReportProblemCubit(this.apiService) : super(ReportProblemInitial());
  Future<Either<Failure, void>> sumbitProblem(String desc) async {
    emit(ReportProblemLoading());

    try {
      String? userToken = await PrefasHandelr.getAuthToken();
      await apiService.postReportProblem(
          endpoint: Endpoints.kReportProblem,
          body: {
            "descripcion": desc,
          },
          userToken: userToken!);

      emit(ReportProblemSuccess());

      return right(null);
    } on DioException catch (dioError) {
      final failure = ServerFailure.fromDioException(dioError);
      emit(ReportProblemFaiulre(errMessage: failure.errMessage));
      return left(failure);
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(ReportProblemFaiulre(errMessage: failure.errMessage));
      return left(failure);
    }
  }
}
