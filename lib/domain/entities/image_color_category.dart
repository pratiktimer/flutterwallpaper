import 'package:equatable/equatable.dart';
import 'package:flutterwallpaper/core/constants/constants.dart';

class ImageColorCategoryEntity extends Equatable {
  final String? name;
  final String? hexValue;
  final String? imageUrl;

  String get defaultUrl =>
      imageUrl?.isNotEmpty == true ? imageUrl! : FlutteryConstant.defaultUrl;

  const ImageColorCategoryEntity(
      {required this.name, required this.hexValue, required this.imageUrl});

  @override
  List<Object?> get props {
    return [name, hexValue, imageUrl];
  }

  String get categoryName => name ?? "Biker";
}
