import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/image_color_category.dart';
part 'image_color_category_dto.g.dart';

@JsonSerializable()
@Entity(tableName: 'imagecolorcategory', primaryKeys: ['name'])
class ImageColorCategoryDTO extends ImageColorCategoryEntity {
  const ImageColorCategoryDTO(
      {required super.name, required super.hexValue, required super.imageUrl});

  factory ImageColorCategoryDTO.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return ImageColorCategoryDTO.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    return toJson();
  }

  factory ImageColorCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$ImageColorCategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageColorCategoryDTOToJson(this);
}
