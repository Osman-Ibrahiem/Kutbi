import 'package:flutter/material.dart';
import 'package:kutbi/core/generated/l10n.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final bool enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextEditingController? matchWithController;

  const PasswordField({
    super.key,
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.hintText,
    this.matchWithController,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      obscureText: _obscure,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText ?? S.of(context).password,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
      ),
      validator: (v) => (widget.validator != null)
          ? widget.validator!(v)
          : _defaultValidator(context, v),
    );
  }

  String? _defaultValidator(BuildContext context, String? v) {
    final value = (v ?? '').trim();

    if (value.isEmpty) {
      return S.of(context).error_empty_password;
    }

    if (value.length < 6) {
      return S.of(context).error_invalid_password;
    }

    final other = widget.matchWithController?.text.trim();
    if (other != null && other.isNotEmpty && other != value) {
      return S.of(context).error_passwords_not_match;
    }

    return null;
  }
}
