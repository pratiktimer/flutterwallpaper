import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/data/models/developer_dto.dart';

abstract class DeveloperRepository {
  Future<DataState<DeveloperDTO>> FetchDeveloper();
}
