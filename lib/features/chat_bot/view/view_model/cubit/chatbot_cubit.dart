import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:doct_plant/core/utils/api_service.dart';
import 'package:meta/meta.dart';
import 'package:doct_plant/core/errors/failure.dart'; // Adjust if needed

part 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  final Dio dio;

  ChatbotCubit({required this.dio}) : super(ChatbotInitial());

  Future<Either<Failure, String>> sendPrompt(String prompt) async {
    if (prompt.isEmpty) {
      final failure = ServerFailure("Prompt cannot be empty");
      emit(ChatbotFailure(errMessage: failure.errMessage));
      return left(failure);
    }

    emit(ChatbotLoading());

    final url = ApiService.baseChatBotUrl;

    try {
      final response = await dio.post(
        url!,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        },
      );

      final data = response.data;

      // ✅ Check for deeply nested structure: candidates > content > parts > text
      final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];

      if (text != null && text is String) {
        emit(ChatbotSuccess(text));
        return right(text);
      } else {
        final failure = ServerFailure("Invalid or missing AI response");
        emit(ChatbotFailure(errMessage: failure.errMessage));
        return left(failure);
      }
    } on DioException catch (dioError) {
      final failure = ServerFailure.fromDioException(dioError);
      emit(ChatbotFailure(errMessage: failure.errMessage));
      return left(failure);
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(ChatbotFailure(errMessage: failure.errMessage));
      return left(failure);
    }
  }
}
