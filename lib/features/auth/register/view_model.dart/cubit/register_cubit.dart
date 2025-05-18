import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doct_plant/constants/endpoints.dart';
import 'package:doct_plant/core/errors/failure.dart';
import 'package:doct_plant/core/utils/api_service.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ApiService apiService;
  RegisterCubit(this.apiService) : super(RegisterInitial());
  Future<Either<Failure, void>> register(
      {required String email,
      required String password,
      required String name,
      required String confirmPassword}) async {
    emit(RegisterLoading());

    try {
      await apiService.post(endpoint: Endpoints.kRegister, body: {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      });
      emit(RegisterSuccess());
      return right(null);
    } on DioException catch (dioError) {
      final failure = ServerFailure.fromDioException(dioError);
      emit(RegisterFailure(erroMessage: failure.errMessage));
      return left(failure);
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(RegisterFailure(erroMessage: failure.errMessage));
      return left(failure);
    }
  }
}
