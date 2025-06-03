import 'dart:developer';
import 'dart:io';
import 'package:doct_plant/constants/endpoints.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doct_plant/core/Preferences/prefs_handler.dart';
import 'package:doct_plant/core/errors/failure.dart';
import 'package:doct_plant/core/utils/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'plant_diagonsis_state.dart';

class PlantDiagonsisCubit extends Cubit<PlantDiagonsisState> {
  final ApiService apiService;

  PlantDiagonsisCubit(
    this.apiService,
  ) : super(PlantDiagonsisInitial());
  Future<void> pickImage() async {
    try {
      emit(PlantDiagonsisLoading());

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        await PrefasHandelr.storeUserProfileImagePath(image.path);
        emit(PlantDiagonsisSucces(imagePath: image.path));

        // Upload image after storing and emitting success
        final String? userToken = await PrefasHandelr.getAuthToken();
        if (userToken == null) {
          emit(PlantDiagonsisFailure(erroMessage: "Missing user token"));
          return;
        }

        final File imageFile = File(image.path);
        await uploadImageToAPI(
            imageFile, userToken); // Fire and forget (or await for status)
      } else {
        emit(PlantDiagonsisFailure(erroMessage: 'No image selected'));
      }
    } catch (e) {
      emit(PlantDiagonsisFailure(erroMessage: 'Error picking image: $e'));
    }
  }

  Future<Either<Failure, String>> uploadImageToAPI(
      File file, String userToken) async {
    try {
      final formData = FormData.fromMap({
        'File': await MultipartFile.fromFile(
          file.path,
          contentType:
              MediaType.parse(lookupMimeType(file.path) ?? 'image/png'),
        ),
      });

      final response = await apiService.postImage(
        endpoint: Endpoints.kUploadImage,
        body: formData,
        userToken: userToken,
      );

      final imageToken = response['token'] as String;
      await PrefasHandelr.storeImageToken(imageToken);
      log(imageToken);
      return right(imageToken);
    } on DioException catch (dioError) {
      final failure = ServerFailure.fromDioException(dioError);
      emit(PlantDiagonsisFailure(erroMessage: failure.errMessage));
      return left(failure);
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(PlantDiagonsisFailure(erroMessage: failure.errMessage));
      return left(failure);
    }
  }
}
