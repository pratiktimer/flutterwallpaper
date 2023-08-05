import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/core/util/custom_exception.dart';
import 'package:flutterwallpaper/domain/entities/wallpaper.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final wallpaperListNotifierProvider = StateNotifierProvider.family<
    WallpaperListNotifier, AsyncValue<List<WallpaperEntity>>, String>(
  (ref, category) {
    final wallpaperRepository = ref.watch(wallpaperRepositoryProvider);
    return WallpaperListNotifier(wallpaperRepository, category);
  },
);

class WallpaperListNotifier
    extends StateNotifier<AsyncValue<List<WallpaperEntity>>> {
  final WallpaperRepository _wallpaperRepository;
  String _currentCategory = '';
  int currentPage = 1;

  WallpaperListNotifier(this._wallpaperRepository, this._currentCategory)
      : super(const AsyncLoading()) {
    currentPage = 1;
    loadMoreItems(_currentCategory);
  }

  Future<void> loadMoreItems(String category) async {
    _currentCategory = category;
    try {
      // Call the appropriate method from the repository to load more items
      final DataState<List<WallpaperEntity>> dataStateList =
          await _wallpaperRepository.fetchWallpapers(
              currentPage, _currentCategory);

      final List<WallpaperEntity>? newItems = dataStateList.data;
      final currentState = state;

      final List<WallpaperEntity> updatedList = [
        ...?currentState.value,
        if (newItems != null) ...newItems,
      ];

      // Increment the current page for the next load
      currentPage++;

      state = AsyncData<List<WallpaperEntity>>(updatedList);
    } on CustomException catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Method to clear the existing data when the category changes
  void clearData() {
    state = const AsyncLoading();
    currentPage = 1;
  }

  @override
  void dispose() {
    // Call the close method of the notifier to clean up resources
    state = const AsyncLoading();
    super.dispose();
  }
}
