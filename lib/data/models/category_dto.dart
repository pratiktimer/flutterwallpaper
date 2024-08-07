import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/category.dart';
part 'category_dto.g.dart';

@JsonSerializable()
@Entity(tableName: 'category', primaryKeys: ['name'])
class CategoryDTO extends CategoryeEntity {
  const CategoryDTO({required id, required name, required url})
      : super(id: id, name: name, url: url);

  factory CategoryDTO.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return CategoryDTO.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    return toJson();
  }

  factory CategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDTOToJson(this);
}
