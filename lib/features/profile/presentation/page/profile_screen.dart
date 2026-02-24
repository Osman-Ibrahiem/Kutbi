import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/routing/app_routes.dart';
import 'package:kutbi/core/theme/app_colors.dart';
import 'package:kutbi/core/widgets/app_snackbar.dart';

import '../controller/user_controller.dart';
import '../state/profile_event.dart';
import '../widgets/profile_screen_body.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<ProfileEvent>>(
      profileEventsProvider,
      (previous, next) => _handleStateChange(next, context),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).myAccount,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: const ProfileScreenBody(),
    );
  }

  void _handleStateChange(
    AsyncValue<ProfileEvent> event,
    BuildContext context,
  ) {
    event.whenData((event) {
      if (event is ShowSnackBar) {
        if (event.isError) {
          AppSnackBar.showError(context, event.message);
        } else {
          AppSnackBar.showSuccess(context, event.message);
        }
      }

      if (event is NavigateToLogin) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      }
    });
  }
}
