import '../../core/resources/data_state.dart';
import '../entities/wallpaper.dart';

abstract class WallpaperRepository {
  // API Methods
  Future<DataState<List<WallpaperEntity>>> fetchWallpapers(
      int page, String category);
}
