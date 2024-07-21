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

final localWallpaperRepositoryProvider =
    Provider<LocalWallpaperRepository>((ref) {
  // Replace WallpaperRepositoryImpl with the actual implementation of the repository
  final appDatabase = ref.watch(appDatabaseInstanceProvider);
  return LocalWallpaperRepositoryImpl(appDatabase!);
});

// Initial provider to obtain AppDatabase asynchronously
final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  return database;
});

// Separate provider to provide the already obtained AppDatabase instance
final appDatabaseInstanceProvider = Provider<AppDatabase?>((ref) {
  // Use ref.watch to listen to changes in the appDatabaseProvider
  final appDatabaseFuture = ref.watch(appDatabaseProvider);
  // Use maybeWhen to check if the future has completed and provide the instance
  return appDatabaseFuture.maybeWhen(
    data: (appDatabase) => appDatabase,
    orElse: () => null,
  );
});

// final favRepositoryProvider =
//     FutureProvider<FavoritesStateNotifier>((ref) async {
//   final localRepo = ref.watch(localWallpaperRepositoryProvider);
//   final favoritesNotifier = FavoritesStateNotifier(localRepo);
//   await favoritesNotifier
//       .fetchFavorites(); // Fetch favorites when creating the provider
//   return favoritesNotifier;
// });
