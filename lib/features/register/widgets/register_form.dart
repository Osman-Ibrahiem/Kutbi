import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/assets.gen.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/widgets/email_field.dart';
import 'package:kutbi/core/widgets/name_field.dart';
import 'package:kutbi/core/widgets/password_field.dart';
import 'package:kutbi/core/widgets/primary_button.dart';

import '../controller/register_controller.dart';
import '../state/register_state.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(registerControllerProvider) is Loading;
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Assets.images.appLogo.image(
            width: 64,
            height: 64,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),

          NameField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            enabled: !isLoading,
          ),
          const SizedBox(height: 12),

          EmailField(
            controller: _emailController,
            textInputAction: TextInputAction.next,
            enabled: !isLoading,
          ),
          const SizedBox(height: 12),

          PasswordField(
            controller: _passwordController,
            textInputAction: TextInputAction.next,
            enabled: !isLoading,
          ),
          const SizedBox(height: 12),

          PasswordField(
            matchWithController: _passwordController,
            textInputAction: TextInputAction.done,
            hintText: S.of(context).confirmPassword,
            enabled: !isLoading,
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 20),

          PrimaryButton.text(
            text: S.of(context).btnRegister,
            isLoading: isLoading,
            enabled: !isLoading,
            onPressed: _submit,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    ref.read(registerControllerProvider.notifier).reset();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    await ref
        .read(registerControllerProvider.notifier)
        .register(name: name, email: email, password: password);
  }
}
