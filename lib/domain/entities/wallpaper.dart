import 'package:equatable/equatable.dart';

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
    return [id, landscape, medium, original, potrait, photographerUrl];
  }
}
