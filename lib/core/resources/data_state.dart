import 'package:flutterwallpaper/core/util/custom_exception.dart';

abstract class DataState<T> {
  final T? data;
  final CustomException? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(CustomException error) : super(error: error);
}
