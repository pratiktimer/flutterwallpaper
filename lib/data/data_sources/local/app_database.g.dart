// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WallpaperDao? _wallpaperDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `wallpaper` (`id` REAL, `landscape` TEXT, `medium` TEXT, `original` TEXT, `potrait` TEXT, `photographerUrl` TEXT, `large` TEXT, `large2x` TEXT, `photographer` TEXT, `tiny` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WallpaperDao get wallpaperDAO {
    return _wallpaperDAOInstance ??= _$WallpaperDao(database, changeListener);
  }
}

class _$WallpaperDao extends WallpaperDao {
  _$WallpaperDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _wallpaperDTOInsertionAdapter = InsertionAdapter(
            database,
            'wallpaper',
            (WallpaperDTO item) => <String, Object?>{
                  'id': item.id,
                  'landscape': item.landscape,
                  'medium': item.medium,
                  'original': item.original,
                  'potrait': item.potrait,
                  'photographerUrl': item.photographerUrl,
                  'large': item.large,
                  'large2x': item.large2x,
                  'photographer': item.photographer,
                  'tiny': item.tiny
                }),
        _wallpaperDTODeletionAdapter = DeletionAdapter(
            database,
            'wallpaper',
            ['id'],
            (WallpaperDTO item) => <String, Object?>{
                  'id': item.id,
                  'landscape': item.landscape,
                  'medium': item.medium,
                  'original': item.original,
                  'potrait': item.potrait,
                  'photographerUrl': item.photographerUrl,
                  'large': item.large,
                  'large2x': item.large2x,
                  'photographer': item.photographer,
                  'tiny': item.tiny
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WallpaperDTO> _wallpaperDTOInsertionAdapter;

  final DeletionAdapter<WallpaperDTO> _wallpaperDTODeletionAdapter;

  @override
  Future<List<WallpaperDTO>> getWallpapers() async {
    return _queryAdapter.queryList('SELECT * FROM wallpaper',
        mapper: (Map<String, Object?> row) => WallpaperDTO(
            id: row['id'] as double?,
            landscape: row['landscape'] as String?,
            medium: row['medium'] as String?,
            original: row['original'] as String?,
            potrait: row['potrait'] as String?,
            photographerUrl: row['photographerUrl'] as String?,
            large: row['large'] as String?,
            large2x: row['large2x'] as String?,
            photographer: row['photographer'] as String?,
            tiny: row['tiny'] as String?));
  }

  @override
  Future<void> insertWallpaper(WallpaperDTO articleDTO) async {
    await _wallpaperDTOInsertionAdapter.insert(
        articleDTO, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteWallpaper(WallpaperDTO articleDTO) async {
    await _wallpaperDTODeletionAdapter.delete(articleDTO);
  }
}
