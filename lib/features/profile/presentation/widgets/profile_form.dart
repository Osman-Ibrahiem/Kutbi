import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/assets.gen.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/theme/app_colors.dart';
import 'package:kutbi/core/widgets/input_field.dart';
import 'package:kutbi/core/widgets/primary_button.dart';
import 'package:kutbi/core/widgets/secondary_button.dart';

import '../controller/user_controller.dart';

class ProfileForm extends ConsumerStatefulWidget {
  const ProfileForm({super.key});

  @override
  ConsumerState<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isUpdating = false;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userControllerProvider).value;
    if (user != null) {
      _nameController.text = user.name ?? '';
      _emailController.text = user.email ?? '';
      _nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: _nameController.text.length),
      );
      _emailController.selection = TextSelection.fromPosition(
        TextPosition(offset: _emailController.text.length),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userControllerProvider, (prev, next) {
      if (next.value != null && !_isUpdating) {
        if (_nameController.text != next.value?.name) {
          _nameController.text = next.value?.name ?? '';
          _nameController.selection = TextSelection.fromPosition(
            TextPosition(offset: _nameController.text.length),
          );
        }
      }
    });

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

          InputField.name(
            controller: _nameController,
            textInputAction: TextInputAction.done,
            enabled: !_isUpdating && !_isDeleting,
          ),
          const SizedBox(height: 12),

          InputField.email(controller: _emailController, enabled: false),
          const SizedBox(height: 20),

          PrimaryButton.text(
            text: S.of(context).btnUpdate,
            isLoading: _isUpdating,
            enabled: !_isUpdating && !_isDeleting,
            onPressed: _updateProfile,
          ),

          const SizedBox(height: 12),
          PrimaryButton.text(
            text: S.of(context).btnDeleteAccount,
            backgroundColor: AppColors.red,
            foregroundColor: Colors.white,
            isLoading: _isDeleting,
            enabled: !_isUpdating && !_isDeleting,
            onPressed: _confirmDelete,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Future<void> _updateProfile() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isUpdating = true);
    await ref
        .read(userControllerProvider.notifier)
        .updateUser(newName: _nameController.text.trim());
    if (mounted) setState(() => _isUpdating = false);
  }

  void _confirmDelete() {
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(S.of(ctx).title_dialog_delete_account),
          content: Text(S.of(ctx).content_dialog_delete_account),
          actions: [
            SecondaryButton.text(
              text: S.of(ctx).btnCancel,
              onPressed: () => Navigator.pop(ctx),
            ),

            PrimaryButton.text(
              text: S.of(ctx).btnDelete,
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              onPressed: () async {
                Navigator.pop(ctx);
                await _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    setState(() => _isDeleting = true);
    await ref.read(userControllerProvider.notifier).deleteAccount();
    if (mounted) setState(() => _isDeleting = false);
  }
}
