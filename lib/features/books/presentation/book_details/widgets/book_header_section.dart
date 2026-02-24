import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/image_network.dart';

class BookHeaderSection extends StatelessWidget {
  final String imageUrl;

  const BookHeaderSection({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        SizedBox(
          height: 500,
          width: double.infinity,
          child: ImageNetwork(url: imageUrl, fit: BoxFit.cover),
        ),
        Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withAlpha(10),
                isDark ? AppColors.darkBackground : AppColors.lightBackground,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
