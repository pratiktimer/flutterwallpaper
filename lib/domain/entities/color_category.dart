import 'package:equatable/equatable.dart';

class ColorCategoryEntity extends Equatable {
  final String? name;
  final String? hexValue;

  const ColorCategoryEntity({required this.name, required this.hexValue});

  @override
  List<Object?> get props {
    return [name, hexValue];
  }

  String get categoryName => name ?? "Biker";
}
