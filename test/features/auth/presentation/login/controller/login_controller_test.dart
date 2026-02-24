import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kutbi/core/utils/api_exception.dart';
import 'package:kutbi/features/auth/domain/models/user_model.dart';
import 'package:kutbi/features/auth/domain/usecases/login/login_use_case.dart';
import 'package:kutbi/features/auth/presentation/login/controller/login_controller.dart';
import 'package:kutbi/features/auth/presentation/login/state/login_state.dart';
import 'package:mocktail/mocktail.dart';

class LoginUseCaseMock extends Mock implements LoginUseCase {}

void main() {
  late LoginUseCaseMock useCaseMock;

  setUp(() {
    useCaseMock = LoginUseCaseMock();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [loginUseCaseProvider.overrideWithValue(useCaseMock)],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('LoginController', () {
    final testUser = UserModel(id: '1', email: 'test@test.com', name: 'Test');

    test('initial state should be Initial', () {
      final container = createContainer();
      expect(container.read(loginControllerProvider), isA<Initial>());
    });

    test('login should emit Loading then Success on success', () async {
      when(
        () => useCaseMock(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => testUser);

      final container = createContainer();
      final notifier = container.read(loginControllerProvider.notifier);

      final states = <LoginState>[];
      container.listen(loginControllerProvider, (_, next) => states.add(next));

      await notifier.login(email: 'test@test.com', password: 'password');

      expect(states[0], isA<Loading>());
      expect(states[1], isA<Success>());
      expect((states[1] as Success).user, testUser);
    });

    test('login should emit Loading then Failure on error', () async {
      when(
        () => useCaseMock(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(ApiException(message: 'Error'));

      final container = createContainer();
      final notifier = container.read(loginControllerProvider.notifier);

      final states = <LoginState>[];
      container.listen(loginControllerProvider, (_, next) => states.add(next));

      await notifier.login(email: 'test@test.com', password: 'password');

      expect(states[0], isA<Loading>());
      expect(states[1], isA<Failure>());
      expect(
        (states[1] as Failure).message,
        'ApiException: Error (statusCode: null)',
      );
    });
  });
}
