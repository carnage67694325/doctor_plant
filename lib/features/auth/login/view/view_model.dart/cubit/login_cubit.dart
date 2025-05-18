import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doct_plant/constants/endpoints.dart';
import 'package:doct_plant/core/Preferences/prefs_handler.dart';
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
      var resposne = await apiService.post(endpoint: Endpoints.kLogin, body: {
        "email": email,
        "password": password,
      });

      emit(LoginSuccess());
      if (resposne['token'] != null) {
        final token = resposne['token'];
        await PrefasHandelr.storeToken(
            token); // Store the token in SharedPreferences
      }
      return right(null);
    } on DioException catch (dioError) {
      final failure = ServerFailure.fromDioException(dioError);
      emit(LoginFaiulre(erroMessage: failure.errMessage));
      return left(failure);
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(LoginFaiulre(erroMessage: failure.errMessage));
      return left(failure);
    }
  }
}
