import 'package:flutter_test/flutter_test.dart';
import 'package:kutbi/features/auth/domain/models/user_model.dart';
import 'package:kutbi/features/auth/domain/repositories/auth_repository.dart';
import 'package:kutbi/features/auth/domain/usecases/login/login_use_case.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late AuthRepositoryMock repositoryMock;

  setUp(() {
    repositoryMock = AuthRepositoryMock();
    useCase = LoginUseCase(repositoryMock);
  });

  group('LoginUseCase', () {
    const testEmail = 'test@test.com';
    const testPassword = 'password123';
    final testUser = UserModel(id: '1', email: testEmail, name: 'Test User');

    test('should call login on the repository and return user', () async {
      when(
        () => repositoryMock.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => testUser);

      final result = await useCase(email: testEmail, password: testPassword);

      expect(result, equals(testUser));
      verify(
        () => repositoryMock.login(email: testEmail, password: testPassword),
      ).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });

    test('should rethrow exceptions from the repository', () async {
      when(
        () => repositoryMock.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception('Invalid credentials'));

      expect(
        () => useCase(email: testEmail, password: testPassword),
        throwsA(isA<Exception>()),
      );
    });
  });
}
