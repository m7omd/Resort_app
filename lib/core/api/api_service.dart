import 'dart:io';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../config/environment/env_helper.dart';
import '../data/data_source/local/cache_helper.dart';
import '../utils/app_constant.dart';
import 'dio_logger.dart';
import 'package:http_parser/http_parser.dart';

//
// class ApiService {
//   final Dio _dio;
//
//   ApiService(this._dio) {
//     initDio();
//   }
//
//   Future<void> initDio() async {
//     String? token = await CacheHelper.getData(key: "token");
//     print("tokeeeeeeeeee${token}");
//
//     // String? language = await CacheHelper().getLanguage();
//     String? languageCode = CacheHelper.getLanguageCode() ?? 'en';
//
//     _dio.options
//       ..baseUrl = EnvConfig.apiUrl
//       ..responseType = ResponseType.json
//       ..connectTimeout = const Duration(seconds: 20)
//       ..sendTimeout = const Duration(seconds: 20)
//       ..receiveTimeout = const Duration(seconds: 20)
//       ..followRedirects = false
//       ..headers = {
//         "lang": languageCode,
//         "Content-Type": "application/json",
//         // "Authorization": "enaUfX7erDieyqKOyUcT9usumw8B7D5IxVS9oGhksXd4KXZW6IUvZiUu2xHjN4FdSef8cx",
//         // "Authorization": "Bearer $token",
//         if (token != null) "Authorization": "Bearer $token",
//         // AppStrings.contentType: AppStrings.applicationJson,
//         // AppStrings.accept: AppStrings.applicationJson,
//       };
//     // ..validateStatus = (status) {
//     //   return status != null && status < 500;
//     // };
//     if (kDebugMode) {
//       _dio.interceptors.add(DioLogInterceptor());
//     }
//   }
//
//   Future get({required String endPoint, dynamic data, Map<String, dynamic>? parameters}) async {
//     var response = await _dio.get(endPoint, data: data, queryParameters: parameters);
//     return _parseResponse(response);
//   }
//
//   Future<Map<String, dynamic>> post({required String endPoint, required dynamic data}) async {
//     var response = await _dio.post(endPoint, data: data);
//     return _parseResponse(response);
//   }
//
//   Future<Map<String, dynamic>> put({required String endPoint, required dynamic data}) async {
//     var response = await _dio.put(endPoint, data: data);
//     return _parseResponse(response);
//   }
//
//   Future<Map<String, dynamic>> delete({required String endPoint}) async {
//     var response = await _dio.delete(endPoint);
//     return _parseResponse(response);
//   }
//
//   Future<dynamic> download({required String endPoint}) async {
//     var response = await _dio.get(endPoint, options: Options(responseType: ResponseType.bytes));
//     return response.data;
//   }
//
//   Map<String, dynamic> _parseResponse(Response response) {
//     return response.data as Map<String, dynamic>;
//   }
// }
//

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    initDio();
  }

  Future<void> initDio() async {
    String? languageCode = CacheHelper.getLanguageCode() ?? 'en';

    _dio.options
      ..baseUrl = EnvConfig.apiUrl
      ..responseType = ResponseType.json
      ..connectTimeout = const Duration(seconds: 60)
      ..sendTimeout = const Duration(seconds: 60)
      ..receiveTimeout = const Duration(seconds: 60)
      ..followRedirects = false
      ..headers = {"lang": languageCode, "Content-Type": "application/json"};

    // Interceptors
    if (kDebugMode) {
      _dio.interceptors.add(DioLogInterceptor());
    }
    _dio.interceptors.add(AuthInterceptor()); // 👈 هنا ضيفنا الانترسبتور
  }

  // Future get({required String endPoint, dynamic data, Map<String, dynamic>? parameters}) async {
  //   var response = await _dio.get(endPoint, data: data, queryParameters: parameters);
  //   return _parseResponse(response);
  // }

  Future get({required String endPoint, Map<String, dynamic>? parameters}) async {
    final response = await _dio.get(endPoint, queryParameters: parameters);
    return response.data; // ✅
  }

  Future<Map<String, dynamic>> post({required String endPoint, required dynamic data}) async {
    var response = await _dio.post(endPoint, data: data);
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> put({required String endPoint, required dynamic data}) async {
    var response = await _dio.put(endPoint, data: data);
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> delete({required String endPoint}) async {
    var response = await _dio.delete(endPoint);
    return _parseResponse(response);
  }
  Future<Uint8List> download({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    final response = await _dio.get(
      endPoint,
      queryParameters: data,
      options: Options(
        responseType: ResponseType.bytes, // 👈 مهم جدًا
      ),
    );

    if (response.data is Uint8List) {
      return response.data as Uint8List;
    }

    return Uint8List.fromList(List<int>.from(response.data));
  }

  Map<String, dynamic> _parseResponse(Response response) {
    return response.data;
  }

  Future<Map<String, dynamic>> postFormData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, File>? files,
  }) async {
    final formData = FormData();

    // Add normal fields
    data.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    // Add files if exist
    if (files != null) {
      for (var entry in files.entries) {
        final file = entry.value;
        final mimeType = lookupMimeType(file.path);

        formData.files.add(
          MapEntry(
            entry.key,
            await MultipartFile.fromFile(
              file.path,
              filename: file.uri.pathSegments.last,
              contentType: mimeType != null ? MediaType.parse(mimeType) : null,
            ),
          ),
        );
      }
    }

    final response = await _dio.post(endPoint, data: formData);
    return _parseResponse(response);
  }
}
