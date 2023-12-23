import 'package:get_it/get_it.dart';
import 'package:location_box/app/product/init/state/theme/view_model.dart';
import 'package:location_box/app/view/maps/view_model/google_maps_view_model.dart';

final class ProductStateGetIt {
  ProductStateGetIt._();
  static final _getIt = GetIt.I;

  static void setup() {
    _getIt
      ..registerLazySingleton<AppThemeViewModel>(AppThemeViewModel.new)
      ..registerLazySingleton<GoogleMapsViewModel>(GoogleMapsViewModel.new);
  }

  static AppThemeViewModel get appThemeViewModel =>
      _getIt.get<AppThemeViewModel>();

  static GoogleMapsViewModel get googleMapsViewModel =>
      _getIt.get<GoogleMapsViewModel>();
}
