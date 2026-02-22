import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool enabled;
  final bool isLoading;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final Widget child;

  const PrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.padding,
    this.borderRadius = 10,
    this.enabled = true,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (enabled && !isLoading) ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
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

  factory PrimaryButton.text({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    EdgeInsetsGeometry? padding,
    double borderRadius = 10,
    TextStyle? textStyle,
    TextAlign? textAlign = TextAlign.center,
    bool enabled = true,
    bool isLoading = false,
    Color? backgroundColor,
    Color? foregroundColor,
  }) => PrimaryButton(
    key: key,
    onPressed: onPressed,
    padding: padding,
    borderRadius: borderRadius,
    enabled: enabled,
    isLoading: isLoading,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    child: Text(text, style: textStyle, textAlign: textAlign),
  );
}
