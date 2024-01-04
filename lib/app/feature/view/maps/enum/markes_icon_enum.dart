import 'package:location_box/gen/src/asset/assets.gen.dart';

enum MarkerIcons {
  ic_favorite, // No need to pass key and value in this case
  ic_star,
  ic_gym,
  ic_home
}

extension MarkerIconExtension on MarkerIcons {
  String get key {
    switch (this) {
      case MarkerIcons.ic_favorite:
        return 'Favorite';
      case MarkerIcons.ic_star:
        return 'Star';
      case MarkerIcons.ic_gym:
        return 'Gym';
      case MarkerIcons.ic_home:
        return 'Home';
      default:
        return 'Home';
    }
  }

  String get value {
    switch (this) {
      case MarkerIcons.ic_favorite:
        return Assets.icons.icFavorite.path;
      case MarkerIcons.ic_star:
        return Assets.icons.icStar.path;
      case MarkerIcons.ic_gym:
        return Assets.icons.icGym.path;
      case MarkerIcons.ic_home:
        return Assets.icons.icHome.path;
      default:
        return Assets.icons.icHome.path;
    }
  }
}
