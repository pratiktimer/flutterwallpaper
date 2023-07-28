import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/core/util/custom_exception.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import '../data_sources/remote/wallpaper_service.dart';
import '../models/wallpaper_dto.dart';

class WallpaperRepositoryImpl implements WallpaperRepository {
  final WallpaperService _wallpaerService;

  WallpaperRepositoryImpl(this._wallpaerService);

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
}
