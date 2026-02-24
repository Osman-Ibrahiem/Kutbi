import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/l10n.dart';

import '../../../../core/services/remote/baas/analytics_service.dart';
import '../../../../core/services/remote/baas/firebase_analytics_service.dart';
import '../../../auth/domain/models/user_model.dart';
import '../../../auth/domain/usecases/login/logout_use_case.dart';
import '../../../auth/domain/usecases/splash/is_logged_in_use_case.dart';
import '../../domain/usecases/profile/delete_account_use_case.dart';
import '../../domain/usecases/profile/get_current_user_use_case.dart';
import '../../domain/usecases/profile/update_profile_use_case.dart';
import '../state/profile_event.dart';

class UserController extends AsyncNotifier<UserModel> {
  late final GetCurrentUserUseCase getCurrentUserUseCase;
  late final UpdateProfileUseCase updateProfileUseCase;
  late final IsLoggedInUseCase isLoggedInUseCase;
  late final LogoutUseCase logoutUseCase;
  late final DeleteAccountUseCase deleteAccountUseCase;
  late final AnalyticsService _analytics;

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
    _analytics = ref.read(analyticsServiceProvider);

    ref.onDispose(() => _eventController.close());

    return getCurrentUserUseCase();
  }

  bool isLoggedIn() => isLoggedInUseCase();

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

  Future<bool> logout() async {
    try {
      await _logLogout();
      await logoutUseCase();
      return true;
    } catch (e, st) {
      return false;
    }
  }

  Future<void> deleteAccount() async {
    final currentUser = state.value;

    try {
      await _logDeleteAccount();
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

  Future<void> _logLogout() async {
    await _analytics.logEvent('logout');
    await _analytics.removeUserId();
  }

  Future<void> _logDeleteAccount() async {
    await _analytics.logEvent('delete_account');
    await _analytics.removeUserId();
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
