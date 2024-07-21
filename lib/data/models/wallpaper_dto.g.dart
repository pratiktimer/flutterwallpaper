// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallpaperDTO _$WallpaperDTOFromJson(Map<String, dynamic> json) => WallpaperDTO(
      id: (json['id'] as num?)?.toDouble(),
      landscape: json['landscape'] as String?,
      medium: json['medium'] as String?,
      original: json['original'] as String?,
      potrait: json['potrait'] as String?,
      photographerUrl: json['photographerUrl'] as String?,
      large: json['large'] as String?,
      large2x: json['large2x'] as String?,
      photographer: json['photographer'] as String?,
      tiny: json['tiny'] as String?,
    );

Map<String, dynamic> _$WallpaperDTOToJson(WallpaperDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'landscape': instance.landscape,
      'medium': instance.medium,
      'original': instance.original,
      'potrait': instance.potrait,
      'photographerUrl': instance.photographerUrl,
      'large': instance.large,
      'large2x': instance.large2x,
      'photographer': instance.photographer,
      'tiny': instance.tiny,
    };
