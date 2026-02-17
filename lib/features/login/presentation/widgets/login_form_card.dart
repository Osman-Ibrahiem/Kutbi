import 'package:flutter/material.dart';
import 'package:kutbi/core/generated/assets.gen.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/widgets/email_field.dart';
import 'package:kutbi/core/widgets/password_field.dart';
import 'package:kutbi/core/widgets/primary_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 12),

          Text(
            S.of(context).welcomeBack,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),

          EmailField(controller: _emailCtrl),
          const SizedBox(height: 12),

          PasswordField(controller: _passCtrl),
          const SizedBox(height: 20),

          PrimaryButton.text(
            onPressed: _submit,
            text: S.of(context).btnLogin,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
  }
}
