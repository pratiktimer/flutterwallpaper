import 'package:equatable/equatable.dart';

class CategoryeEntity extends Equatable {
  final int id;
  final String? name;
  final String? url;

  const CategoryeEntity(
      {required this.id, required this.name, required this.url});

  @override
  List<Object?> get props {
    return [name];
  }
}
