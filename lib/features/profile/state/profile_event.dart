sealed class ProfileEvent {}

class ShowSnackBar extends ProfileEvent {
  final String message;

  ShowSnackBar(this.message);
}

class NavigateToLogin extends ProfileEvent {}
