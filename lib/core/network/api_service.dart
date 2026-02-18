import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../errors/exceptions.dart';

class ApiService {
  final http.Client _client;
  final String baseUrl;

  ApiService({required http.Client client, required this.baseUrl})
    : _client = client;

  Future<dynamic> get({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    debugPrint('REQUEST [GET] => $uri');

    try {
      final response = await _client
          .get(uri, headers: headers ?? {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 10));

      debugPrint('RESPONSE [${response.statusCode}] => ${response.body}');

      return _processResponse(response);
    } on SocketException {
      throw OfflineException("No Internet Connection");
    } on http.ClientException {
      throw OfflineException("Connection Failed");
    } catch (e) {
      if (e is OfflineException ||
          e is ServerException ||
          e is EmptyDataException) {
        rethrow;
      }
      throw ServerException("Unexpected Error: $e");
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          final decodedBody = json.decode(response.body);
          return decodedBody;
        } catch (e) {
          throw DataParsingException("Failed to decode JSON");
        }
      case 400:
        throw ServerException("Bad Request: ${response.body}");
      case 401:
      case 403:
        throw ServerException("Unauthorized");
      case 404:
        throw ServerException("Not Found");
      case 500:
        throw ServerException("Internal Server Error");
      default:
        throw ServerException("Error loading data: ${response.statusCode}");
    }
  }
}

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(
    client: ref.read(httpClientProvider),
    baseUrl: 'https://api.itbook.store/1.0/',
  );
});
