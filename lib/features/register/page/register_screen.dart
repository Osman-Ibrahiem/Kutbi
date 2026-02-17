import 'package:flutter/material.dart';
import 'package:kutbi/core/generated/l10n.dart';

import '../widgets/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).registerTitle),
        centerTitle: true,
      ),
      body: RegisterScreenBody(),
    );
  }
}
