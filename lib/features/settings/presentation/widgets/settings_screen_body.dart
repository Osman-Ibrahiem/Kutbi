import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/generated/l10n.dart';
import '../../domain/models/app_locale.dart';
import '../../domain/models/app_theme_mode.dart';
import '../controller/locale_controller.dart';
import '../controller/theme_controller.dart';

typedef OptionItem<T> = ({T value, String label, IconData icon});

class SettingsScreenBody extends ConsumerWidget {
  const SettingsScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeControllerProvider);
    final currentLocale = ref.watch(localeControllerProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Theme Section ---
          _buildSection<AppThemeMode>(
            context: context,
            title: S.of(context).appearance,
            selectedValue: currentThemeMode,
            onChanged: (theme) {
              ref.read(themeControllerProvider.notifier).changeTheme(theme);
            },
            options: [
              (
                value: AppThemeMode.system,
                label: S.of(context).systemDefault,
                icon: Icons.brightness_auto,
              ),
              (
                value: AppThemeMode.light,
                label: S.of(context).light,
                icon: Icons.wb_sunny,
              ),
              (
                value: AppThemeMode.dark,
                label: S.of(context).dark,
                icon: Icons.dark_mode,
              ),
            ],
          ),

          const SizedBox(height: 30),

          // --- Language Section ---
          _buildSection<AppLocale>(
            context: context,
            title: S.of(context).language,
            selectedValue: currentLocale,
            onChanged: (locale) {
              ref.read(localeControllerProvider.notifier).changeLocale(locale);
            },
            options: [
              (
                value: AppLocale.system,
                label: S.of(context).systemDefault,
                icon: Icons.public,
              ),
              (
                value: AppLocale.english,
                label: S.of(context).english,
                icon: Icons.language,
              ),
              (
                value: AppLocale.arabic,
                label: S.of(context).arabic,
                icon: Icons.g_translate,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection<T>({
    required BuildContext context,
    required String title,
    required T selectedValue,
    required ValueChanged<T> onChanged,
    required List<OptionItem<T>> options,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOptionsTitle(context: context, title: title),
        const SizedBox(height: 5),
        _buildCardOptions<T>(
          context: context,
          selectedValue: selectedValue,
          onChanged: onChanged,
          options: options,
        ),
      ],
    );
  }

  Widget _buildOptionsTitle({
    required BuildContext context,
    required String title,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCardOptions<T>({
    required BuildContext context,
    required T selectedValue,
    required ValueChanged<T> onChanged,
    required List<OptionItem<T>> options,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: options.map((option) {
          return _buildOptionItem<T>(
            context: context,
            item: option,
            isSelected: option.value == selectedValue,
            onTap: () => onChanged(option.value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOptionItem<T>({
    required BuildContext context,
    required OptionItem<T> item,
    bool isSelected = false,
    GestureTapCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          item.icon,
          size: 20,
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        ),
      ),
      title: Text(
        item.label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: colorScheme.primary)
          : null,
    );
  }
}
