import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:flutterwallpaper/domain/entities/color_category.dart';
import 'package:json_annotation/json_annotation.dart';
part 'color_category_dto.g.dart';

@JsonSerializable()
@Entity(tableName: 'colorcategory', primaryKeys: ['name'])
class ColorCategoryDTO extends ColorCategoryEntity {
  const ColorCategoryDTO({required name, required hexValue})
      : super(name: name, hexValue: hexValue);
  factory ColorCategoryDTO.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return ColorCategoryDTO.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    return toJson();
  }

  factory ColorCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$ColorCategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ColorCategoryDTOToJson(this);
}
