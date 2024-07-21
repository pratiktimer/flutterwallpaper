import 'package:equatable/equatable.dart';
import 'package:flutterwallpaper/core/constants/constants.dart';

class CategoryeEntity extends Equatable {
  final int id;
  final String? name;
  final String? url;

  String get imageUrl =>
      url?.isNotEmpty == true ? url! : FlutteryConstant.defaultUrl;

  const CategoryeEntity(
      {required this.id, required this.name, required this.url});

  @override
  List<Object?> get props {
    return [name];
  }

  String get categoryName => name ?? "Biker";
}
