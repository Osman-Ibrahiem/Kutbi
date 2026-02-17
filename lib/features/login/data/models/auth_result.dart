class AuthResult {
  final bool success;
  final String? errorMessage;
  final String? userId;

  const AuthResult({
    required this.success,
    this.errorMessage,
    this.userId,
  });

  factory AuthResult.success(String userId) =>
      AuthResult(success: true, userId: userId);

  factory AuthResult.failure(String message) =>
      AuthResult(success: false, errorMessage: message);
}