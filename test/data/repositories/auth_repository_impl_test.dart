import 'package:flutter_test/flutter_test.dart';
import 'package:kutbi/data/datasources/auth_data_source.dart';
import 'package:kutbi/data/datasources/local_data_source.dart';
import 'package:kutbi/data/repositories/auth_repository_impl.dart';
import 'package:kutbi/domain/models/user_model.dart';
import 'package:kutbi/domain/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class AuthDataSourceMock extends Mock implements AuthDataSource {}

class LocalDataSourceMock extends Mock implements LocalDataSource {}

class UserModelFake extends Fake implements UserModel {}

void main() {
  late AuthRepository repository;
  late AuthDataSourceMock authDataSourceMock;
  late LocalDataSourceMock localDataSourceMock;

  setUpAll(() {
    registerFallbackValue(UserModelFake());
  });

  setUp(() {
    authDataSourceMock = AuthDataSourceMock();
    localDataSourceMock = LocalDataSourceMock();
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
