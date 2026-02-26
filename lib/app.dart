import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/generated/l10n.dart';
import 'core/routing/app_routes.dart';
import 'core/services/remote/baas/firebase_analytics_service.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/controller/locale_controller.dart';
import 'features/settings/presentation/controller/theme_controller.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final locale = ref.watch(localeControllerProvider);
    final analyticsService = ref.read(analyticsServiceProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => S.of(context).appTitle,
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale.toLocale,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode.toThemeMode,
      navigatorObservers: [analyticsService.observer],
    );
  }
}
