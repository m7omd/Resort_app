import 'package:dio/dio.dart';


class MapClientConsumer {
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Dio client = Dio(BaseOptions(baseUrl: "EnvConfig.mapUrl"));

      final response = await client.get(path, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle the response status code and error message if it's not 200
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.unknown,
        );
      }
    } on DioException catch (error) {
      // Pass the DioException to the error handler
      return _handleDioError(error);
    } catch (error) {
      // Handle any other unexpected errors
      return _handleGenericError(error);
    }
  }

  // Error handling method for DioException
  dynamic _handleDioError(DioException error) {
    // You can log the error or return a custom error response based on the exception
    print('DioException: ${error.message}');

    // Return a structured error response or throw an exception
    return {'success': false, 'message': error.message};
  }

  // Generic error handler for unexpected errors
  dynamic _handleGenericError(dynamic error) {
    print('Unexpected error: $error');
    return {'success': false, 'message': 'An unexpected error occurred'};
  }
}
