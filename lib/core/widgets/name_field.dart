import 'package:flutter/material.dart';
import 'package:kutbi/core/generated/l10n.dart';

class NameField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;

  const NameField({
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
      keyboardType: TextInputType.name,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: S.of(context).name,
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (v) {
        final value = (v ?? '').trim();

        if (value.isEmpty) {
          return S.of(context).error_name_empty;
        }

        return null;
      },
    );
  }
}
