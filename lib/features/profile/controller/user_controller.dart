import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/l10n.dart';

import '../../../domain/models/user_model.dart';
import '../../../domain/usecases/login/logout_use_case.dart';
import '../../../domain/usecases/profile/delete_account_use_case.dart';
import '../../../domain/usecases/profile/get_current_user_use_case.dart';
import '../../../domain/usecases/profile/update_profile_use_case.dart';
import '../../../domain/usecases/splash/is_logged_in_use_case.dart';
import '../state/profile_event.dart';

class UserController extends AsyncNotifier<UserModel> {
  late final GetCurrentUserUseCase getCurrentUserUseCase;
  late final UpdateProfileUseCase updateProfileUseCase;
  late final IsLoggedInUseCase isLoggedInUseCase;
  late final LogoutUseCase logoutUseCase;
  late final DeleteAccountUseCase deleteAccountUseCase;

  UserController();

  final _eventController = StreamController<ProfileEvent>.broadcast();

  Stream<ProfileEvent> get events => _eventController.stream;

  @override
  Future<UserModel> build() async {
    getCurrentUserUseCase = ref.read(getCurrentUserUseCaseProvider);
    updateProfileUseCase = ref.read(updateProfileUseCaseProvider);
    isLoggedInUseCase = ref.read(isLoggedInUseCaseProvider);
    logoutUseCase = ref.read(logoutUseCaseProvider);
    deleteAccountUseCase = ref.read(deleteAccountUseCaseProvider);

    ref.onDispose(() => _eventController.close());

    return await getCurrentUserUseCase();
  }

  Future<bool> isLoggedIn() async {
    return await isLoggedInUseCase();
  }

  Future<void> updateUser({String? newName, String? photoUrl}) async {
    final currentUser = state.value;

    state = await AsyncValue.guard<UserModel>(() async {
      return await updateProfileUseCase(name: newName, photoUrl: photoUrl);
    });

    state.when(
      data: (user) {
        _eventController.add(
          ShowSnackBar(S.current.profileUpdatedSuccessfully),
        );
      },
      error: (e, st) {
        if (currentUser != null) {
          state = AsyncData(currentUser);
        }

        _eventController.add(ShowSnackBar(e.toString(), isError: true));
      },
      loading: () {},
    );
  }

  Future<void> logout() async {
    await logoutUseCase();
  }

  Future<void> deleteAccount() async {
    final currentUser = state.value;

    try {
      await deleteAccountUseCase();

      _eventController.add(ShowSnackBar(S.current.accountDeletedSuccessfully));
      _eventController.add(NavigateToLogin());
    } catch (e, st) {
      if (currentUser != null) {
        state = AsyncData(currentUser);
      }

      _eventController.add(ShowSnackBar(e.toString(), isError: true));
    }
  }
}

final userControllerProvider =
    AsyncNotifierProvider.autoDispose<UserController, UserModel>(
      UserController.new,
    );

final profileEventsProvider = StreamProvider<ProfileEvent>((ref) {
  final notifier = ref.watch(userControllerProvider.notifier);
  return notifier.events;
});
