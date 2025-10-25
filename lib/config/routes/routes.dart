import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutterwallpaper/presentation/home/favourite_page.dart';
import 'package:flutterwallpaper/presentation/home/favourite_wallpaper_detail.dart';
import 'package:flutterwallpaper/presentation/providers/favourite_controller.dart';

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
      case '/FavListPage':
        return _materialRoute(FavListPage());

      case '/WallpaerDetailPage':
        var wallpaperListPageArgs =
            settings.arguments as WallaperDetailPageArguments;
        return _materialRoute(WallaperDetailPage(
          page: wallpaperListPageArgs.page,
          category: wallpaperListPageArgs.category,
          index: wallpaperListPageArgs.index,
          favController: wallpaperListPageArgs.favController,
        ));

      case '/FavDetailPage':
        var wallpaperListPageArgs =
            settings.arguments as WallaperDetailPageArguments;
        return _materialRoute(FavWallaperDetailPage(
          index: wallpaperListPageArgs.index,
          favController: wallpaperListPageArgs.favController,
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

  static void onFavPressed(BuildContext context, int page, String category) {
    Navigator.pushNamed(context, '/FavListPage',
        arguments: WallaperListPageArguments(page, category));
  }

  static void onWallpaperItemPressed(BuildContext context, int page,
      String category, int index, FavoritesStateNotifier favController) {
    Navigator.pushNamed(context, '/WallpaerDetailPage',
        arguments:
            WallaperDetailPageArguments(page, category, index, favController));
  }

  static Future<void> onFavItemPressed(BuildContext context, int index,
      FavoritesStateNotifier favController, WidgetRef ref) async {
    var result = await Navigator.pushNamed(context, '/FavDetailPage',
        arguments: WallaperDetailPageArguments(0, "", index, favController));

    if (result == "reload") {
      ref.refresh(favRepositoryProvider); // Refresh the provider
    }
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
  final FavoritesStateNotifier favController;

  WallaperDetailPageArguments(
      this.page, this.category, this.index, this.favController);
}
