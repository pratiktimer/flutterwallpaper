import 'package:floor/floor.dart';
import 'package:flutterwallpaper/data/models/wallpaper_dto.dart';

@dao
abstract class WallpaperDao {
  @Insert()
  Future<void> insertWallpaper(WallpaperDTO articleDTO);

  @delete
  Future<void> deleteWallpaper(WallpaperDTO articleDTO);

  @Query('SELECT * FROM wallpaper')
  Future<List<WallpaperDTO>> getWallpapers();
}
