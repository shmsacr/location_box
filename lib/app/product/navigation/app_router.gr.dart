// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    GoogleMapsRoute.name: (routeData) {
      final args = routeData.argsAs<GoogleMapsRouteArgs>(
          orElse: () => const GoogleMapsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GoogleMapsView(
          key: args.key,
          locationModel: args.locationModel,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
  };
}

/// generated route for
/// [GoogleMapsView]
class GoogleMapsRoute extends PageRouteInfo<GoogleMapsRouteArgs> {
  GoogleMapsRoute({
    Key? key,
    LocationModel? locationModel,
    List<PageRouteInfo>? children,
  }) : super(
          GoogleMapsRoute.name,
          args: GoogleMapsRouteArgs(
            key: key,
            locationModel: locationModel,
          ),
          initialChildren: children,
        );

  static const String name = 'GoogleMapsRoute';

  static const PageInfo<GoogleMapsRouteArgs> page =
      PageInfo<GoogleMapsRouteArgs>(name);
}

class GoogleMapsRouteArgs {
  const GoogleMapsRouteArgs({
    this.key,
    this.locationModel,
  });

  final Key? key;

  final LocationModel? locationModel;

  @override
  String toString() {
    return 'GoogleMapsRouteArgs{key: $key, locationModel: $locationModel}';
  }
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
