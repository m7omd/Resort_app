import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioException.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioException.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioException.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('Send or Receive timeout with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('No internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Something was wrong, Please try again');
      default:
        return ServerFailure('Something was wrong, Please try again');
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 404 ||
        statusCode == 422) {
      return ServerFailure(response['message']);
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try again');
    } else {
      return ServerFailure('Something was wrong, Please try again');
    }
  }
}
