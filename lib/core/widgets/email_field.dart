import 'package:flutter/material.dart';
import 'package:kutbi/core/generated/l10n.dart';

class EmailField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;

  const EmailField({
    super.key,
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.textInputAction,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      enabled: enabled,
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: S.of(context).email,
        prefixIcon: const Icon(Icons.email_outlined),
      ),
      validator: (v) {
        final value = (v ?? '').trim();

        if (value.isEmpty) {
          return S.of(context).error_empty_email;
        }

        final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
        if (!emailRegex.hasMatch(value)) {
          return S.of(context).error_invalid_email;
        }

        return null;
      },
    );
  }
}
