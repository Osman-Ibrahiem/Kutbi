import 'package:flutter/material.dart';
import 'package:kutbi/features/login/presentation/widgets/login_form_card.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 420),
          child: LoginForm(),
        ),
      ),
    );
  }
}
