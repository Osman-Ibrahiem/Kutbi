import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/assets.gen.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/widgets/email_field.dart';
import 'package:kutbi/core/widgets/password_field.dart';
import 'package:kutbi/core/widgets/primary_button.dart';
import 'package:kutbi/features/login/presentation/controllers/login_controller.dart';

import '../state/login_state.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginControllerProvider, _handleStateChange);
    final loginState = ref.watch(loginControllerProvider);

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

          EmailField(
            controller: _emailController,
            textInputAction: TextInputAction.next,
            enabled: !loginState.isLoading,
          ),
          const SizedBox(height: 12),

          PasswordField(
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            enabled: !loginState.isLoading,
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 20),

          PrimaryButton.text(
            text: S.of(context).btnLogin,
            isLoading: loginState.isLoading,
            onPressed: _submit,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    ref.read(loginControllerProvider.notifier).reset();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    await ref
        .read(loginControllerProvider.notifier)
        .login(email: email, password: password);
  }

  void _handleStateChange(LoginState? previous, LoginState next) {
    if (next.status == LoginStatus.success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('✅ تم تسجيل الدخول بنجاح!')));
    } else if (next.status == LoginStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(next.errorMessage ?? S.of(context).error_unknown),
        ),
      );
    }
  }
}
