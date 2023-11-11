import 'package:flutterwallpaper/data/models/category_name_dto.dart';

import '../../core/resources/data_state.dart';
import '../../data/models/category_dto.dart';
import '../../data/models/color_category_dto.dart';
import '../../data/models/image_color_category_dto.dart';
import '../entities/wallpaper.dart';

abstract class WallpaperRepository {
  // API Methods
  Future<DataState<List<WallpaperEntity>>> fetchWallpapers(
      int page, String category);

  Future<DataState<List<CategoryDTO>>> fetchCategories();

  Future<DataState<List<CategoryNameDTO>>> fetchNameCategories();

  Future<DataState<List<ColorCategoryDTO>>> fetchColorCategories();

  Future<DataState<List<ImageColorCategoryDTO>>> fetchImageColorCategories();
}

abstract class LocalWallpaperRepository {
  // Database methods
  Future<List<WallpaperEntity>> getFavourites();

  Future<void> addToFavourite(WallpaperEntity article);

  Future<void> removeFromfavourite(WallpaperEntity article);
}
