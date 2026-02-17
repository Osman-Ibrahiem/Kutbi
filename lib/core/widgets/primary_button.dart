import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool enabled;
  final bool isLoading;

  final Widget child;

  const PrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.padding ,
    this.borderRadius = 10,
    this.enabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (enabled && !isLoading) ? onPressed : null,
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
  }) => PrimaryButton(
    key: key,
    onPressed: onPressed,
    padding: padding,
    borderRadius: borderRadius,
    enabled: enabled,
    isLoading: isLoading,
    child: Text(text, style: textStyle, textAlign: textAlign),
  );
}
