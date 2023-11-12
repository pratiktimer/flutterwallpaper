import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/core/util/custom_exception.dart';
import 'package:flutterwallpaper/data/data_sources/remote/wallpaper_service.dart';
import 'package:flutterwallpaper/data/models/category_dto.dart';
import 'package:flutterwallpaper/data/models/category_name_dto.dart';
import 'package:flutterwallpaper/data/models/color_category_dto.dart';
import 'package:flutterwallpaper/data/models/image_color_category_dto.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import '../models/wallpaper_dto.dart';

class WallpaperRepositoryImpl implements WallpaperRepository {
  final WallpaperService _wallpaerService;
  //final AppDatabase _appDatabase;
  WallpaperRepositoryImpl(this._wallpaerService);

  ///, this._appDatabase);

  @override
  Future<DataState<List<WallpaperDTO>>> fetchWallpapers(
      int size, String category) async {
    try {
      var result = await _wallpaerService.fetchWallpapers(size, category);
      return DataSuccess(result);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ColorCategoryDTO>>> fetchColorCategories() async {
    try {
      var result = await _wallpaerService.fetchColorCategories();
      return DataSuccess(result);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ImageColorCategoryDTO>>>
      fetchImageColorCategories() async {
    try {
      var result = await _wallpaerService.fetchImageColorCategories();
      return DataSuccess(result);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<CategoryNameDTO>>> fetchNameCategories() async {
    try {
      var result = await _wallpaerService.fetchNameCategories();
      return DataSuccess(result);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<CategoryDTO>>> fetchCategories() async {
    try {
      var result = await _wallpaerService.fetchCategories();
      return DataSuccess(result);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }
}
