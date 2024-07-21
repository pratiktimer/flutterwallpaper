// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeveloperDTO _$DeveloperDTOFromJson(Map<String, dynamic> json) => DeveloperDTO(
      name: json['name'],
      quote: json['quote'],
      myquote: json['myquote'],
      backgroundImage: json['backgroundImage'],
      profileImage: json['profileImage'],
    );

Map<String, dynamic> _$DeveloperDTOToJson(DeveloperDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quote': instance.quote,
      'myquote': instance.myquote,
      'backgroundImage': instance.backgroundImage,
      'profileImage': instance.profileImage,
    };
