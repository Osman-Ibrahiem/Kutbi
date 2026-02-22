import 'dart:developer';

void logRequest(
  String method,
  Uri uri,
  Map<String, String>? headers,
  dynamic body,
) {
  log('''
  🔵    REQUEST [$method]
        URL: $uri
        Headers: $headers
        Body: $body
        ''');
}

void logResponse(int statusCode, dynamic body) {
  log('''
  🟢 RESPONSE [$statusCode]
     Body: $body
     ''');
}

void logError(dynamic error) {
  log('🔴 ERROR: $error');
}
