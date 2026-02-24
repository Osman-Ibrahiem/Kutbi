import 'package:flutter_test/flutter_test.dart';
import 'package:kutbi/features/auth/data/datasources/auth_data_source.dart';
import 'package:kutbi/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:kutbi/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kutbi/features/auth/domain/models/user_model.dart';
import 'package:kutbi/features/auth/domain/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class AuthDataSourceMock extends Mock implements AuthDataSource {}

class AuthLocalDataSourceMock extends Mock implements AuthLocalDataSource {}

class UserModelFake extends Fake implements UserModel {}

void main() {
  late AuthRepository repository;
  late AuthDataSourceMock authDataSourceMock;
  late AuthLocalDataSourceMock localDataSourceMock;

  setUpAll(() {
    registerFallbackValue(UserModelFake());
  });

  setUp(() {
    authDataSourceMock = AuthDataSourceMock();
    localDataSourceMock = AuthLocalDataSourceMock();
    repository = AuthRepositoryImpl(
      authDataSource: authDataSourceMock,
      localDataSource: localDataSourceMock,
    );
  });

  group('AuthRepository', () {
    final testUser = UserModel(
      id: '1',
      email: 'test@test.com',
      name: 'Test User',
    );

    test('login should call login on remote and cache on local', () async {
      when(
        () => authDataSourceMock.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => testUser);
      when(() => localDataSourceMock.cacheUser(any())).thenAnswer((_) async {});

      final result = await repository.login(
        email: 'test@test.com',
        password: 'password',
      );

      expect(result, equals(testUser));
      verifyInOrder([
        () => authDataSourceMock.login(
          email: 'test@test.com',
          password: 'password',
        ),
        () => localDataSourceMock.cacheUser(testUser),
      ]);
    });
  });
}
