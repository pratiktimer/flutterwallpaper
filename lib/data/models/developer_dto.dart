import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:flutterwallpaper/domain/entities/developer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'developer_dto.g.dart';

@JsonSerializable()
@Entity(tableName: 'developer', primaryKeys: ['name'])
class DeveloperDTO extends DeveloperEntity {
  const DeveloperDTO(
      {required name,
      required quote,
      required myquote,
      required backgroundImage,
      required profileImage})
      : super(
            name: name,
            quote: quote,
            myquote: myquote,
            backgroundImage: backgroundImage,
            profileImage: profileImage);

  factory DeveloperDTO.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return DeveloperDTO.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    return toJson();
  }

  factory DeveloperDTO.fromJson(Map<String, dynamic> json) =>
      _$DeveloperDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DeveloperDTOToJson(this);
}
