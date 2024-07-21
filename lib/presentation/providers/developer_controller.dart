import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/data/repository/developer_repository_impl.dart';
import 'package:flutterwallpaper/domain/entities/developer.dart';

final developerProvider =
    FutureProvider<DataState<DeveloperEntity>>((ref) async {
  final developerRepository = ref.watch(developerRepositoryProvider);
  return developerRepository.FetchDeveloper();
});
