abstract class AppStateService{
  Future<void> setThemeMode({required bool themeMode});
  Future<bool> getThemeMode();
}