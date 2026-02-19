import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/routing/app_routes.dart';
import 'package:kutbi/core/theme/app_colors.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            accountName: const Text(
              "Osman Ibrahiem",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("osman@example.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: AppColors.primary),
            ),
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

              // Navigator.pushNamed(context, AppRoutes.account);
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: Text(S.of(context).settings),
            onTap: () {
              Navigator.pop(context);

              // Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.red),
            title: Text(
              S.of(context).btnLogout,
              style: TextStyle(color: AppColors.red),
            ),
            onTap: () {
              Navigator.pop(context);

              // ref.read(authNotifierProvider.notifier).logout();

              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              S.of(context).version("1.0.0"),
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
