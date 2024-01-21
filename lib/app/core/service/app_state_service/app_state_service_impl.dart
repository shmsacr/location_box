import 'package:hive/hive.dart';
import 'package:location_box/app/core/service/app_state_service/app_state_service.dart';
import 'package:location_box/app/product/model/app_state/app_state.dart';

class AppStateServiceImplement extends AppStateService {
  static const String _boxName = 'appStateBox';
  @override
  Future<bool> getThemeMode() async {
    Box<AppState> box = await Hive.openBox<AppState>(_boxName);
    AppState? appState = box.get(1);
    await box.close();
    return appState!.themeMode;
  }

  @override
  Future<void> setThemeMode({required bool themeMode}) async {
    Box<AppState> box = await Hive.openBox<AppState>(_boxName);
    await box.put(1, AppState(themeMode: themeMode));
    await box.close();
  }
}
