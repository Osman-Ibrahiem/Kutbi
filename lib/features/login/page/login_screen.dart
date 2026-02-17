import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/widgets/app_snackbar.dart';

import '../controller/login_controller.dart';
import '../state/login_state.dart';
import '../widgets/login_screen_body.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginState>(
      loginControllerProvider,
      (previous, next) => _handleStateChange(next, context),
    );
    return Scaffold(body: const LoginScreenBody());
  }

  void _handleStateChange(LoginState state, BuildContext context) {
    if (state is Success) {
      debugPrint('User: ${state.user.toJson()}');
      AppSnackBar.showSuccess(context, S.of(context).success_login);
    } else if (state is Failure) {
      AppSnackBar.showError(context, state.message);
    }
  }
}
