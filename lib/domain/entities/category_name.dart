import 'package:equatable/equatable.dart';

class CategoryNameEntity extends Equatable {
  final String? name;

  String get categoryName => name ?? "Biker";
  const CategoryNameEntity({
    required this.name,
  });

  @override
  List<Object?> get props {
    return [name];
  }
}
