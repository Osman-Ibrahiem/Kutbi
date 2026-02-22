import 'package:flutter_test/flutter_test.dart';
import 'package:kutbi/data/datasources/auth_data_source.dart';
import 'package:kutbi/data/services/remote/baas/auth_service.dart';
import 'package:kutbi/domain/models/user_model.dart';
import 'package:mocktail/mocktail.dart';

class AuthServiceMock extends Mock implements AuthService {}

void main() {
  late AuthDataSource dataSource;
  late AuthServiceMock authServiceMock;

  setUp(() {
    authServiceMock = AuthServiceMock();
    dataSource = AuthDataSource(authServiceMock);
  });

  group('AuthDataSource', () {
    const testEmail = 'test@test.com';
    const testPassword = 'password';
    const testName = 'Test';
    final testUser = UserModel(id: '1', email: testEmail, name: testName);

    test('login should call signOut then signIn and return user', () async {
      when(() => authServiceMock.signOut()).thenAnswer((_) async {});
      when(
        () => authServiceMock.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => testUser);

      final result = await dataSource.login(
        email: testEmail,
        password: testPassword,
      );

      expect(result, equals(testUser));
      verifyInOrder([
        () => authServiceMock.signOut(),
        () => authServiceMock.signIn(email: testEmail, password: testPassword),
      ]);
    });
  });
}
