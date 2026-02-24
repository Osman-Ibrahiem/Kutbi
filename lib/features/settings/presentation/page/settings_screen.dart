import 'package:flutter/material.dart';

import '../../../../core/generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/settings_screen_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).settings,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SettingsScreenBody(),
    );
  }
}
