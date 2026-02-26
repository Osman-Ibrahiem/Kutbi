import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/generated/l10n.dart';
import '../../../../../core/widgets/app_snackbar.dart';
import '../controller/register_controller.dart';
import '../state/register_state.dart';
import '../widgets/register_screen_body.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RegisterState>(
      registerControllerProvider,
      (previous, next) => _handleStateChange(next, context),
    );
    return Scaffold(body: const RegisterScreenBody());
  }

  void _handleStateChange(RegisterState state, BuildContext context) {
    if (state is Success) {
      debugPrint('User: ${state.user.toJson()}');
      AppSnackBar.showSuccess(context, S.of(context).success_register);
      if (context.mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    } else if (state is Failure) {
      AppSnackBar.showError(context, state.message);
    }
  }
}
