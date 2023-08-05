// Create a provider for the WallpaperRepository concrete implementation
import 'package:flutterwallpaper/data/data_sources/remote/wallpaper_service.dart';
import 'package:flutterwallpaper/data/repository/wallpaper_repository_impl.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final wallpaperRepositoryProvider = Provider<WallpaperRepository>((ref) {
  // Replace WallpaperRepositoryImpl with the actual implementation of the repository
  return WallpaperRepositoryImpl(WallpaperService());
});
