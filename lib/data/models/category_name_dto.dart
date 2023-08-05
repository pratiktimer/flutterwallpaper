import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:flutterwallpaper/domain/entities/category_name.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_name_dto.g.dart';

@JsonSerializable()
@Entity(tableName: 'categoryname', primaryKeys: ['name'])
class CategoryNameDTO extends CategoryNameEntity {
  const CategoryNameDTO({required super.name});

  factory CategoryNameDTO.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return CategoryNameDTO.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    return toJson();
  }

  factory CategoryNameDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryNameDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryNameDTOToJson(this);
}
