import 'package:equatable/equatable.dart';
import 'package:flutterwallpaper/core/constants/constants.dart';

class DeveloperEntity extends Equatable {
  final String? name;
  final String? quote;
  final String? myquote;
  final String? backgroundImage;
  final String? profileImage;

  String get backGroundUrl => backgroundImage?.isNotEmpty == true
      ? backgroundImage!
      : FlutteryConstant.defaultUrl;

  String get profileUrl => profileImage?.isNotEmpty == true
      ? profileImage!
      : FlutteryConstant.defaultUrl;

  const DeveloperEntity(
      {required this.name,
      required this.quote,
      required this.myquote,
      required this.backgroundImage,
      required this.profileImage});

  @override
  List<Object?> get props {
    return [name, quote, backgroundImage, profileImage];
  }
}
