sealed class ProfileEvent {}

class ShowSnackBar extends ProfileEvent {
  final String message;
  final bool isError;

  ShowSnackBar(this.message, {this.isError = false});
}

class NavigateToLogin extends ProfileEvent {}
