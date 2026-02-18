class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class OfflineException implements Exception {
  final String message;

  OfflineException([this.message = "No Internet Connection"]);
}

class DataParsingException implements Exception {
  final String message;

  DataParsingException([this.message = "Failed to parse data"]);
}

class EmptyDataException implements Exception {
  final String message;

  EmptyDataException([this.message = "No data found"]);
}
