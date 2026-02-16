class SplashDelayUseCase {
  Future<void> delay() async {
    await Future.delayed(const Duration(milliseconds: 1500));
  }
}
