import 'package:floor/floor.dart';
import 'package:flutterwallpaper/data/data_sources/local/dao/wallpaper_dao.dart';
import 'package:flutterwallpaper/data/models/wallpaper_dto.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [WallpaperDTO])
abstract class AppDatabase extends FloorDatabase {
  WallpaperDao get wallpaperDAO;
}
