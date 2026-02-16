class SplashState {
  final bool showGradient;

  const SplashState({required this.showGradient});

  factory SplashState.initial() => const SplashState(showGradient: false);

  SplashState copyWith({bool? showGradient}) {
    return SplashState(showGradient: showGradient ?? this.showGradient);
  }
}
