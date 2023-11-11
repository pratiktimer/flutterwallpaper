import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterwallpaper/data/data_sources/local/app_database.dart';
import 'package:flutterwallpaper/data/repository/wallpaper_repository_impl.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data/data_sources/remote/wallpaper_service.dart';

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // final database =
  //     await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // sl.registerSingleton<AppDatabase>(database);
  // Register the FirebaseFirestore instance as a singleton
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Register the WallpaperService with the FirebaseFirestore dependency
  sl.registerSingleton<WallpaperService>(WallpaperService());

  // Register the WallpaperRepository with the WallpaperService dependency
  //sl.registerSingleton<WallpaperRepository>(WallpaperRepositoryImpl(sl()));
}
