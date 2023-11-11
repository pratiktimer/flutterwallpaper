import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../presentation/home/wallpaper_detail.dart';
import '../../../presentation/home/wallpapers_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomeApp());
      case '/WallpaerListPage':
        var wallpaperListPageArgs =
            settings.arguments as WallaperListPageArguments;
        return _materialRoute(WallaperListPage(
            page: wallpaperListPageArgs.page,
            category: wallpaperListPageArgs.category));

      case '/WallpaerDetailPage':
        var wallpaperListPageArgs =
            settings.arguments as WallaperDetailPageArguments;
        return _materialRoute(WallaperDetailPage(
          page: wallpaperListPageArgs.page,
          category: wallpaperListPageArgs.category,
          index: wallpaperListPageArgs.index,
        ));
      default:
        return _materialRoute(const HomeApp());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static void onWallpaerCategoryPressed(
      BuildContext context, int page, String category) {
    Navigator.pushNamed(context, '/WallpaerListPage',
        arguments: WallaperListPageArguments(page, category));
  }

  static void onWallpaperItemPressed(
      BuildContext context, int page, String category, int index) {
    Navigator.pushNamed(context, '/WallpaerDetailPage',
        arguments: WallaperDetailPageArguments(page, category, index));
  }
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class WallaperListPageArguments {
  final int page;
  final String category;

  WallaperListPageArguments(this.page, this.category);
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class WallaperDetailPageArguments {
  final int page;
  final String category;
  final int index;

  WallaperDetailPageArguments(this.page, this.category, this.index);
}
