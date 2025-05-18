import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doct_plant/constants/endpoints.dart';
import 'package:doct_plant/core/errors/failure.dart';
import 'package:doct_plant/core/utils/api_service.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService apiService;

  LoginCubit(this.apiService) : super(LoginInitial());

  Future<Either<Failure, void>> login(String email, String password) async {
    emit(LoginLoading());

    try {
      await apiService.post(endpoint: Endpoints.kLogin, body: {
        "email": email,
        "password": password,
      });
      emit(LoginSuccess());
      return right(null);
    } catch (e) {
      if (e is DioException) {
        emit(LoginFaiulre(erroMessage: e.toString()));

        return left(ServerFailure.fromDioException(e));
      } else {
        emit(LoginFaiulre(erroMessage: e.toString()));

        return left(ServerFailure(e.toString()));
      }
    }
  }
}
