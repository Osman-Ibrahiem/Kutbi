import 'package:flutter/material.dart';

import 'secondary_button.dart';

class ErrorLayout extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String? title, message;
  final VoidCallback? onRetry;

  const ErrorLayout({
    super.key,
    this.icon,
    this.iconColor,
    this.title,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: iconColor?.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: iconColor),
            ),
            const SizedBox(height: 20),

            if (title != null)
              Text(
                title!,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],

            if (onRetry != null) ...[
              const SizedBox(height: 24),
              SecondaryButton.text(
                text: "Try Again",
                onPressed: onRetry,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  factory ErrorLayout.empty({
    Key? key,
    IconData? icon = Icons.inbox,
    Color? iconColor = Colors.grey,
    String? title = "No results found",
    String? message,
    VoidCallback? onRetry,
  }) => ErrorLayout(
    key: key,
    icon: icon,
    iconColor:iconColor,
    title: title,
    message: message,
    onRetry: onRetry,
  );

  factory ErrorLayout.noConnection({
    Key? key,
    IconData? icon = Icons.wifi_off,
    Color? iconColor = Colors.orange,
    String? title = "No Internet Connection",
    String? message,
    VoidCallback? onRetry,
  }) => ErrorLayout(
    key: key,
    icon: icon,
    iconColor:iconColor,
    title: title,
    message: message,
    onRetry: onRetry,
  );

  factory ErrorLayout.unknownError({
    Key? key,
    IconData? icon = Icons.error_outline,
    Color? iconColor = Colors.red,
    String? title = "Something went wrong",
    String? message,
    VoidCallback? onRetry,
  }) => ErrorLayout(
    key: key,
    icon: icon,
    iconColor:iconColor,
    title: title,
    message: message,
    onRetry: onRetry,
  );
}
