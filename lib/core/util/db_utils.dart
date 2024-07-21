import 'package:flutterwallpaper/data/data_sources/local/app_database.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DatabaseUtils {
  static Future<AppDatabase> getAppDatabase(WidgetRef ref) async {
    final appDatabase = await ref.read(appDatabaseProvider.future);
    return appDatabase;
  }
}
