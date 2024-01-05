import 'package:location_box/gen/src/asset/assets.gen.dart';

enum MarkerIcons {
  ic_favorite, 
  ic_star,
  ic_gym,
  ic_home,
  ic_default;
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
        return 'Default';
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
        return Assets.icons.icDefault.path;
    }
  }
}
