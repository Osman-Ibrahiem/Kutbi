abstract class ApiClient {
  Future<T> get<T>({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });

  Future<T> post<T>({
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
  });

  Future<T> put<T>({
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
  });

  Future<void> delete({required String endpoint, Map<String, String>? headers});
}
