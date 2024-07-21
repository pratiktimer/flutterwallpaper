import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class WallpaperPlugin {
  static const MethodChannel _channel = MethodChannel('your_plugin');

  Future<void> setWallpaperFromUrl(String imageUrl) async {
    final filePath = await _downloadImage(imageUrl);
    if (filePath != null) {
      await _setWallpaper(filePath);
    } else {
      throw Exception('Failed to download image');
    }
  }

  Future<String?> _downloadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final documentDirectory = await getApplicationDocumentsDirectory();
        final file = File('${documentDirectory.path}/temp_wallpaper.jpg');
        file.writeAsBytesSync(response.bodyBytes);
        return file.path;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _setWallpaper(String filePath) async {
    if (Platform.isWindows) {
      await _channel.invokeMethod('setWallpaper', {'filePath': filePath});
    } else if (Platform.isAndroid) {
      // Handle Android implementation
    }
  }
}
