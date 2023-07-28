import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/util/custom_exception.dart';
import '../../models/wallpaper_dto.dart';

class WallpaperService {
  Future<List<WallpaperDTO>> fetchWallpapers(int page, String category) async {
    try {
      final collectionRef = FirebaseFirestore.instance
          .collection("photos")
          .doc(category)
          .collection(page.toString());
      final snap = await collectionRef.get();
      return snap.docs.map((doc) => WallpaperDTO.fromDocument(doc)).toList();
    } catch (ex) {
      throw const CustomException();
    }
  }
}
