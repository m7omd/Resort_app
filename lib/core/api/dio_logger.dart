import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../config/routes/app_router.dart';
import '../data/data_source/local/cache_helper.dart';
import '../utils/imports.dart';

extension OptionsExtension on RequestOptions {}

enum _StatusType { succeed, failed }

class DioLogInterceptor extends Interceptor {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  final Logger logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      logger.i(
        "***|| ${options.method} ${options.uri} ||***"
        "\n param : ${options.queryParameters}"
        "\n token : ${options.headers['Authorization']}"
        "\n data : ${options.data}",
      );
    }

    handler.next(options);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   if (kDebugMode) {
  //     _StatusType statusType;
  //     if (response.statusCode == 200) {
  //       statusType = _StatusType.succeed;
  //     } else {
  //       statusType = _StatusType.failed;
  //     }
  //
  //     // Decode JSON data
  //     var decodedData = response.data is String ? jsonDecode(response.data) : response.data;
  //
  //     logger.f(
  //       "***|| INFO Response Request ${response.requestOptions.uri.path} ${statusType == _StatusType.succeed ? '✊' : ''} ||***"
  //       "\n Status code: ${response.statusCode}"
  //       "\n Status message: ${response.statusMessage}"
  //       "\n Data: ${encoder.convert(decodedData)}",
  //     );
  //   }
  //
  //   handler.next(response);
  // }
  //
  //



  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      _StatusType statusType;
      if (response.statusCode == 200) {
        statusType = _StatusType.succeed;
      } else {
        statusType = _StatusType.failed;
      }

      // لو responseType = bytes ما نطبعش المحتوى
      if (response.requestOptions.responseType == ResponseType.bytes) {
        logger.i(
          "***|| Binary Response (bytes) from ${response.requestOptions.uri.path} ||***"
              "\n Status code: ${response.statusCode}"
              "\n Status message: ${response.statusMessage}"
              "\n Data length: ${(response.data as List).length} bytes",
        );
      } else {
        // Decode JSON data
        var decodedData = response.data is String ? jsonDecode(response.data) : response.data;

        logger.f(
          "***|| INFO Response Request ${response.requestOptions.uri.path} ${statusType == _StatusType.succeed ? '✊' : ''} ||***"
              "\n Status code: ${response.statusCode}"
              "\n Status message: ${response.statusMessage}"
              "\n Data: ${encoder.convert(decodedData)}",
        );
      }
    }

    handler.next(response);
  }





  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      Logger(printer: PrettyPrinter(methodCount: 8)).e(
        "***|| ${err.requestOptions.uri.path} ||***"
        "\n response: ${err.response}"
        "\n message: ${err.message}"
        "\n type: ${err.type}",
        error: err.error,
        stackTrace: err.stackTrace,
      );
    }
    handler.next(err);
  }
}

//
// class AuthInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     // خد التوكين من الكاش كل مرة
//     String? token = await CacheHelper.getData(key: "token");
//     if (token != null) {
//       options.headers["Authorization"] = "Bearer $token";
//     }
//     super.onRequest(options, handler);
//   }
// }

/// الموضوع ده مهم راجعه //////////////////

// class AuthInterceptor extends Interceptor {
//   bool _isRefreshing = false;
//   final Dio _dio = Dio(); // هستخدمه للـ refresh request
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     String? token = await CacheHelper.getData(key: "token");
//     if (token != null) {
//       options.headers["Authorization"] = "Bearer $token";
//     }
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     // لو الخطأ 401 (Unauthorized)
//     if (err.response?.statusCode == 401 && !_isRefreshing) {
//       _isRefreshing = true;
//
//       try {
//         // خد refresh token من الكاش
//         String? refreshToken = await CacheHelper.getData(key: "refreshToken");
//
//         if (refreshToken != null) {
//           // ابعت request عشان تجيب access token جديد
//           final response = await _dio.post(
//             "https://yourapi.com/auth/refresh",
//             data: {"refreshToken": refreshToken},
//           );
//
//           if (response.statusCode == 200) {
//             final newToken = response.data["accessToken"];
//
//             // خزنه في الكاش
//             await CacheHelper.saveData(key: "token", value: newToken);
//
//             // عدّل الريكوست القديم وحط فيه التوكين الجديد
//             final RequestOptions requestOptions = err.requestOptions;
//             requestOptions.headers["Authorization"] = "Bearer $newToken";
//
//             // ابعت نفس الريكوست من جديد
//             final cloneReq = await _dio.fetch(requestOptions);
//             return handler.resolve(cloneReq);
//           }
//         }
//       } catch (e) {
//         return handler.next(err); // لو فشل الـ refresh رجّع الخطأ زي ماهو
//       } finally {
//         _isRefreshing = false;
//       }
//     }
//
//     super.onError(err, handler);
//   }
// }

///  لو معنديش ريفريش توكين ومحتاج اخرج للوجين ///////
class AuthInterceptor extends Interceptor {
  bool _isLoggingOut = false; // عشان مايفتحش اللوجين كذا مرة

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // خد التوكين من الكاش كل مرة
    String? token = await CacheHelper.getData(key: "token");
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
      /// if you need make token is valid and go to login screen////
      // options.headers["Authorization"] = "ggg $token";
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isLoggingOut) {
      _isLoggingOut = true;

      // امسح البيانات من الكاش
      await CacheHelper.removeData(key: "token");
      await CacheHelper.removeData(key: "refreshToken"); // لو موجود

      // افتح صفحة اللوجين
      // ملاحظة: هنا لازم يبقى عندك navigatorKey global عشان تقدر تعمل Navigation من interceptor
      // بالـ navigatorKey
      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        GoRouter.of(ctx).go("/login");
      }
      // navigatorKey.currentState?.pushNamedAndRemoveUntil("/login", (route) => false);
    }

    super.onError(err, handler);
  }
}
