import 'package:flutterwallpaper/data/data_sources/local/app_database.dart';
import 'package:flutterwallpaper/domain/entities/wallpaper.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import '../models/wallpaper_dto.dart';

class LocalWallpaperRepositoryImpl implements LocalWallpaperRepository {
  final AppDatabase _appDatabase;
  LocalWallpaperRepositoryImpl(this._appDatabase);

  @override
  Future<void> addToFavourite(WallpaperEntity article) {
    return _appDatabase.wallpaperDAO
        .insertWallpaper(WallpaperDTO.fromEntity(article));
  }

  @override
  Future<void> removeFromfavourite(WallpaperEntity article) {
    return _appDatabase.wallpaperDAO
        .deleteWallpaper(WallpaperDTO.fromEntity(article));
  }

  @override
  Future<List<WallpaperEntity>> getFavourites() {
    return _appDatabase.wallpaperDAO.getWallpapers();
  }
}
