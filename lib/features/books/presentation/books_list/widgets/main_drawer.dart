import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/routing/app_routes.dart';
import 'package:kutbi/core/theme/app_colors.dart';

import '../../../../profile/presentation/controller/user_controller.dart';
import '../controller/package_info_provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final isLoggedIn = ref
                  .read(userControllerProvider.notifier)
                  .isLoggedIn();
              final state = ref.watch(userControllerProvider);
              if (isLoggedIn && state.hasValue) {
                final user = state.requireValue;
                return UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  accountName: Text(
                    user.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(user.email ?? ''),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),

          ListTile(
            leading: const Icon(Icons.menu_book_rounded),
            title: Text(S.of(context).booksStore),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.bookmarks_rounded),
            title: Text(S.of(context).myBookmarks),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushNamed(context, AppRoutes.bookmarks);
            },
          ),

          ListTile(
            leading: const Icon(Icons.account_circle_rounded),
            title: Text(S.of(context).myAccount),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushNamed(context, AppRoutes.profile);
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: Text(S.of(context).settings),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),

          const Divider(),

          Consumer(
            builder: (context, ref, child) {
              final isLoggedIn = ref
                  .read(userControllerProvider.notifier)
                  .isLoggedIn();
              if (isLoggedIn) {
                return ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.red),
                  title: Text(
                    S.of(context).btnLogout,
                    style: TextStyle(color: AppColors.red),
                  ),
                  onTap: () async {
                    Navigator.pop(context);

                    final logoutSuccess = await ref
                        .read(userControllerProvider.notifier)
                        .logout();

                    if (logoutSuccess && !context.mounted) return;
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(packageInfoProvider);
                final version = state.value?.version ?? "1.0.0";
                return Text(
                  S.of(context).version(version),
                  style: TextStyle(color: AppColors.grey),
                );
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
