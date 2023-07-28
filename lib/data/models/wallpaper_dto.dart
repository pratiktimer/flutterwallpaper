import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/wallpaper.dart';
part 'wallpaper_dto.g.dart';

@JsonSerializable()
@Entity(tableName: 'wallpaer', primaryKeys: ['potrait'])
class WallpaperDTO extends WallpaperEntity {
  const WallpaperDTO(
      {double? id,
      String? landscape,
      String? medium,
      String? original,
      String? potrait,
      String? photographerUrl,
      String? large,
      String? large2x,
      String? photographer,
      String? tiny})
      : super(
            id: id,
            landscape: landscape,
            medium: medium,
            original: original,
            potrait: potrait,
            photographerUrl: photographerUrl,
            large: large,
            large2x: large2x,
            photographer: photographer,
            tiny: tiny);

  factory WallpaperDTO.fromJson(Map<String, dynamic> json) =>
      _$WallpaperDTOFromJson(json);

  Map<String, dynamic> toJson() => _$WallpaperDTOToJson(this);

  factory WallpaperDTO.fromDocument(DocumentSnapshot document) {
    final _data = document.data() as Map<String, dynamic>;
    return WallpaperDTO.fromJson(_data);
  }

  Map<String, dynamic> toDocument() {
    return toJson();
  }

  factory WallpaperDTO.fromEntity(WallpaperEntity entity) {
    return WallpaperDTO(
        id: entity.id,
        landscape: entity.landscape,
        medium: entity.medium,
        original: entity.original,
        potrait: entity.potrait,
        photographerUrl: entity.photographerUrl,
        large: entity.large,
        large2x: entity.large2x,
        photographer: entity.photographer);
  }
}
