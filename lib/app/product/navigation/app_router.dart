

import 'package:auto_route/auto_route.dart';
import 'package:location_box/app/view/home/view/home_view.dart';
part 'app_router.gr.dart';



@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
      ];
}