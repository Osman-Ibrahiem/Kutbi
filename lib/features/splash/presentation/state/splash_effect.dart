sealed class SplashEffect {
  const SplashEffect();
}

class NavigateTo extends SplashEffect {
  final String route;
  const NavigateTo(this.route);
}
