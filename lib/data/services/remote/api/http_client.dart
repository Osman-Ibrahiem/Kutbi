import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:kutbi/core/utils/api_exception.dart';
import 'package:kutbi/core/utils/logger.dart';

import 'api_client.dart';

class HttpClient implements ApiClient {
  final String baseUrl;
  final Duration timeout;

  const HttpClient({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
  });

  @override
  Future<T> get<T>({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) {
    final uri = _buildUri(endpoint, query);
    final finalHeaders = _defaultHeaders(headers);

    logRequest('GET', uri, finalHeaders, null);

    return _safeRequest(() {
      return http.get(uri, headers: finalHeaders);
    });
  }

  @override
  Future<T> post<T>({
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
  }) {
    final uri = Uri.parse('$baseUrl$endpoint');
    final finalHeaders = _defaultHeaders(headers);

    logRequest('POST', uri, finalHeaders, body);

    return _safeRequest(() {
      return http.post(uri, headers: finalHeaders, body: jsonEncode(body));
    });
  }

  @override
  Future<T> put<T>({
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
  }) {
    final uri = Uri.parse('$baseUrl$endpoint');
    final finalHeaders = _defaultHeaders(headers);

    logRequest('PUT', uri, finalHeaders, body);

    return _safeRequest(() {
      return http.put(uri, headers: finalHeaders, body: jsonEncode(body));
    });
  }

  @override
  Future<void> delete({
    required String endpoint,
    Map<String, String>? headers,
  }) {
    final uri = Uri.parse('$baseUrl$endpoint');
    final finalHeaders = _defaultHeaders(headers);

    logRequest('DELETE', uri, finalHeaders, null);

    return _safeRequest(() {
      return http.delete(uri, headers: finalHeaders);
    });
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? query) {
    return Uri.parse('$baseUrl$endpoint').replace(
      queryParameters: query?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  Map<String, String> _defaultHeaders(Map<String, String>? headers) {
    return {'Content-Type': 'application/json', ...?headers};
  }

  Future<T> _handleResponse<T>(http.Response response) async {
    logResponse(response.statusCode, response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null as T;
      return jsonDecode(response.body);
    }

    throw ServerException(
      message: response.body,
      statusCode: response.statusCode,
    );
  }

  Future<T> _safeRequest<T>(Future<http.Response> Function() request) async {
    try {
      final response = await request().timeout(timeout);
      return await _handleResponse<T>(response);
    } on SocketException {
      throw NetworkException(message: 'No Internet Connection');
    } on TimeoutException {
      throw TimeoutException(message: 'Request Timeout');
    } catch (e) {
      logError(e);
      rethrow;
    }
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return HttpClient(baseUrl: 'https://api.itbook.store/1.0/');
});
