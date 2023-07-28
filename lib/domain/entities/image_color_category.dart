import 'package:equatable/equatable.dart';

class ImageColorCategoryEntity extends Equatable {
  final String? name;
  final String? hexValue;
  final String? imageUrl;

  const ImageColorCategoryEntity(
      {required this.name, required this.hexValue, required this.imageUrl});

  @override
  List<Object?> get props {
    return [name, hexValue, imageUrl];
  }
}
