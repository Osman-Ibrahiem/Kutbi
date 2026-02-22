import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool enabled;
  final bool isLoading;
  final Color? foregroundColor;

  final Widget child;

  const SecondaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.padding,
    this.borderRadius = 10,
    this.enabled = true,
    this.isLoading = false,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (enabled && !isLoading) ? onPressed : null,
      style: TextButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        foregroundColor: foregroundColor,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            )
          : child,
    );
  }

  factory SecondaryButton.text({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    EdgeInsetsGeometry? padding,
    double borderRadius = 10,
    TextStyle? textStyle,
    TextAlign? textAlign = TextAlign.center,
    bool enabled = true,
    bool isLoading = false,
    Color? foregroundColor,
  }) => SecondaryButton(
    key: key,
    onPressed: onPressed,
    padding: padding,
    borderRadius: borderRadius,
    enabled: enabled,
    isLoading: isLoading,
    foregroundColor: foregroundColor,
    child: Text(text, style: textStyle, textAlign: textAlign),
  );
}
