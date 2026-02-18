import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  final String url;
  final BoxFit? fit;

  const ImageNetwork({super.key, required this.url, this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('IMG ERROR => $error');
        return const Center(child: Icon(Icons.image_not_supported_outlined));
      },
    );
  }
}
