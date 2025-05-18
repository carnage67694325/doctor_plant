import 'dart:developer';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);

  get message => null;
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    // Log the full exception for debugging
    log('DioException caught: ${dioException.toString()}');
    if (dioException.response != null) {
      log('Raw response data: ${dioException.response?.data}');
      log('Response status code: ${dioException.response?.statusCode}');
      log('Response headers: ${dioException.response?.headers}');
    }

    // Handle specific DioException types
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with the API server.');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with the API server.');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with the API server.');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response?.statusCode, dioException.response?.data);

      case DioExceptionType.cancel:
        return ServerFailure('Request to the API server was canceled.');

      case DioExceptionType.connectionError:
        if (dioException.message?.contains('SocketException') == true) {
          return ServerFailure('No internet connection.');
        }
        return ServerFailure('Unexpected error, please try again.');

      default:
        return ServerFailure('An unknown error occurred. Please try again.');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    // Default fallback message if specific error messages are not available
    const fallbackMessage = 'An error occurred with the server.';

    // Handle cases where the response is in the expected format
    if (response is Map<String, dynamic>) {
      // Check for expected "error" and "message" fields in the response
      final error = response['error'];
      final message = response['message'];

      if (error != null && message != null) {
        return ServerFailure('$error: $message');
      }

      // Parse based on status code with fallback messages for specific codes
      if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
        return ServerFailure(message ?? fallbackMessage);
      } else if (statusCode == 404) {
        return ServerFailure('Request not found - please try later.');
      } else if (statusCode == 500) {
        return ServerFailure((message ?? fallbackMessage) +
            '\nThe server encountered an internal error. Please try again later, or contact support if the issue persists.');
      } else {
        return ServerFailure(message ?? fallbackMessage);
      }
    } else if (response != null) {
      // Handle unexpected formats by printing the raw response
      log('Unexpected response format: $response');
      return ServerFailure('Server responded with unexpected data: $response');
    } else {
      return ServerFailure(
          'Server responded with status code $statusCode but did not provide further details. Please try again.');
    }
  }
}
