import 'package:flutter/material.dart';
import 'package:kutbi/core/generated/l10n.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  final String? hintText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool obscureText;
  final bool enableObscureToggle;

  final FormFieldValidator<String>? validator;

  const InputField({
    super.key,
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enableObscureToggle = false,
    this.validator,
  });

  factory InputField.email({
    final Key? key,
    final TextEditingController? controller,
    final String? initialValue,
    final bool enabled = true,
    final TextInputType? keyboardType = TextInputType.emailAddress,
    final TextInputAction? textInputAction,
    final ValueChanged<String>? onChanged,
    final ValueChanged<String>? onFieldSubmitted,
    final String? hintText,
    final Widget? prefixIcon = const Icon(Icons.email_outlined),
    final Widget? suffixIcon,
    final FormFieldValidator<String>? validator,
  }) {
    String? defaultValidator(v) {
      final value = (v ?? '').trim();

      if (value.isEmpty) {
        return S.current.error_empty_email;
      }

      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailRegex.hasMatch(value)) {
        return S.current.error_invalid_email;
      }

      return null;
    }

    return InputField(
      key: key,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      hintText: hintText ?? S.current.email,
      prefixIcon: prefixIcon,
      validator: validator ?? defaultValidator,
    );
  }

  factory InputField.password({
    final Key? key,
    final TextEditingController? controller,
    final String? initialValue,
    final bool enabled = true,
    final TextInputType? keyboardType,
    final TextInputAction? textInputAction,
    final ValueChanged<String>? onChanged,
    final ValueChanged<String>? onFieldSubmitted,
    final String? hintText,
    final Widget? prefixIcon = const Icon(Icons.lock_outline),
    final Widget? suffixIcon,
    final FormFieldValidator<String>? validator,
  }) {
    String? defaultValidator(v) {
      final value = (v ?? '').trim();

      if (value.isEmpty) {
        return S.current.error_empty_password;
      }

      if (value.length < 6) {
        return S.current.error_invalid_password;
      }

      return null;
    }

    return InputField(
      key: key,
      controller: controller,
      obscureText: true,
      enableObscureToggle: true,
      hintText: hintText ?? S.current.password,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      validator: validator ?? defaultValidator,
    );
  }

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscure,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildSuffix(),
      ),
    );
  }

  Widget? _buildSuffix() {
    if (widget.enableObscureToggle) {
      return IconButton(
        onPressed: () => setState(() => _obscure = !_obscure),
        icon: Icon(
          _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
      );
    }

    return widget.suffixIcon;
  }
}
