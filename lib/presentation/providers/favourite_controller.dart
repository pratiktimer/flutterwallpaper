import 'package:flutterwallpaper/domain/entities/wallpaper.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final favRepositoryProvider =
    FutureProvider<FavoritesStateNotifier>((ref) async {
  // Replace WallpaperRepositoryImpl with the actual implementation of the repository
  final localRepo = ref.watch(localWallpaperRepositoryProvider);
  return FavoritesStateNotifier(localRepo);
});

class FavoritesStateNotifier
    extends StateNotifier<AsyncValue<List<WallpaperEntity>>> {
  final LocalWallpaperRepository _localWallpaperRepository;

  FavoritesStateNotifier(this._localWallpaperRepository)
      : super(const AsyncLoading()) {
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    state = const AsyncLoading();
    try {
      final favorites = await _localWallpaperRepository
          .getFavourites(); // Adjust this based on your implementation

      state = AsyncData(favorites);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> _addToFavorites(WallpaperEntity wallpaper) async {
    state.whenData((favorites) {
      state = AsyncData([...favorites, wallpaper]);
    });
    await _localWallpaperRepository.addToFavourite(wallpaper);
  }

  Future<void> _removeFromFavorites(WallpaperEntity wallpaper) async {
    state.whenData((favorites) {
      state = AsyncData(
          favorites.where((item) => item.id != wallpaper.id).toList());
    });
    await _localWallpaperRepository.removeFromfavourite(wallpaper);
  }

  Future<void> addRemoveFavourites(WallpaperEntity wallpaper) async {
    if (isFavorite(wallpaper)) {
      _removeFromFavorites(wallpaper);
    } else {
      _addToFavorites(wallpaper);
    }
  }

  bool isFavorite(WallpaperEntity wallpaper) {
    return state.maybeWhen(
      data: (favorites) => favorites.any((item) => item.id == wallpaper.id),
      orElse: () => false,
    );
  }
}
