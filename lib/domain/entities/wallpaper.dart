import 'package:equatable/equatable.dart';
import 'package:flutterwallpaper/core/constants/constants.dart';

class WallpaperEntity extends Equatable {
  final double? id;
  final String? landscape;
  final String? medium;
  final String? original;
  final String? potrait;
  final String? photographerUrl;
  final String? large;
  final String? large2x;
  final String? photographer;
  final String? tiny;

  String get imageUrl => potrait?.isNotEmpty == true
      ? potrait!
      : large2x?.isNotEmpty == true
          ? large2x!
          : large?.isNotEmpty == true
              ? large!
              : original?.isNotEmpty == true
                  ? original!
                  : FlutteryConstant.defaultUrl;

  String get listimageUrl => medium?.isNotEmpty == true
      ? medium!
      : tiny?.isNotEmpty == true
          ? tiny!
          : original?.isNotEmpty == true
              ? original!
              : large?.isNotEmpty == true
                  ? large!
                  : FlutteryConstant.defaultUrl;

  const WallpaperEntity(
      {required this.id,
      required this.landscape,
      required this.medium,
      required this.original,
      required this.potrait,
      required this.photographerUrl,
      required this.large,
      required this.large2x,
      required this.photographer,
      required this.tiny});

  @override
  List<Object?> get props {
    return [
      id,
      landscape,
      medium,
      original,
      potrait,
      photographerUrl,
      large,
      large2x,
      photographer,
      tiny
    ];
  }
}
