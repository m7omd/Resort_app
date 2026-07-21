import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get fileName => kReleaseMode ? ".env.production" : ".env.development";
  static String get apiUrl => dotenv.env['API_BASE_URL'] ?? 'MY_FALLBACK';
  static String get mapUrl => dotenv.env['GOOGLE_MAP_API_URL'] ?? 'MY_FALLBACK';
  static String get notificationServerKey => dotenv.env['NOTIFICATION_SERVER_KEY'] ?? 'MY_FALLBACK';
  static String get googleMapApiKey => dotenv.env['GOOGLE_MAP_API_KEY'] ?? 'MY_FALLBACK';
  static String get socketBaseUrl => dotenv.env['SOCKET_BASE_URL'] ?? 'MY_FALLBACK';
  static String get revenuecatAppleApiKey => dotenv.env['PURCHASES_APPLE_API_KEY'] ?? 'MY_FALLBACK';
  static String get revenuecatGoogleApiKey =>
      dotenv.env['PURCHASES_GOOGLE_API_KEY'] ?? 'MY_FALLBACK';

  static String getImageUrl(String? path) {
    final normalizedBase = apiUrl.endsWith('/') ? apiUrl.substring(0, apiUrl.length - 1) : apiUrl;
    final normalizedPath = path!.startsWith('/') ? path.substring(1) : path;
    return '$normalizedBase/$normalizedPath';
  }

  static String formatNumber(double value) {
    final formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(value);
  }
}
