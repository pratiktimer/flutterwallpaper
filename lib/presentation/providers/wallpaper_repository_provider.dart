// Create a provider for the WallpaperRepository concrete implementation
import 'package:flutterwallpaper/data/data_sources/local/app_database.dart';
import 'package:flutterwallpaper/data/data_sources/remote/wallpaper_service.dart';
import 'package:flutterwallpaper/data/repository/local_wallpaper_repository_impl.dart';
import 'package:flutterwallpaper/data/repository/wallpaper_repository_impl.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final wallpaperRepositoryProvider = Provider<WallpaperRepository>((ref) {
  // Replace WallpaperRepositoryImpl with the actual implementation of the repository
  final wallpaperService = ref.watch(wallpaperServiceProvider);
  return WallpaperRepositoryImpl(wallpaperService);
});

final wallpaperServiceProvider = Provider<WallpaperService>((ref) {
  // Replace WallpaperRepositoryImpl with the actual implementation of the repository
  return WallpaperService();
});

final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  return database;
});

final localWallpaperRepositoryProvider =
    FutureProvider<LocalWallpaperRepository>((ref) async {
  // Replace WallpaperRepositoryImpl with the actual implementation of the repository
  final wallpaperService = await ref.watch(appDatabaseProvider.future);
  return LocalWallpaperRepositoryImpl(wallpaperService);
});
