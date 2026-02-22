class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => 'ApiException: $message (statusCode: $statusCode)';
}

class NetworkException extends ApiException {
  NetworkException({required super.message});
}

class TimeoutException extends ApiException {
  TimeoutException({required super.message});
}

class ServerException extends ApiException {
  ServerException({required super.message, super.statusCode});
}

class DataParsingException extends ApiException {
  DataParsingException({required super.message});
}

class LocalDatabaseException extends ApiException {
  LocalDatabaseException({required super.message});
}
