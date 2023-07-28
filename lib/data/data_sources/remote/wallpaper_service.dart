import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterwallpaper/data/models/category_dto.dart';
import '../../../core/util/custom_exception.dart';
import '../../models/category_name_dto.dart';
import '../../models/color_category_dto.dart';
import '../../models/image_color_category_dto.dart';
import '../../models/wallpaper_dto.dart';

class WallpaperService {
  Future<List<CategoryDTO>> fetchCategories() async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection("categories");
      final snap = await collectionRef.get();
      return snap.docs.map((doc) => CategoryDTO.fromDocument(doc)).toList();
    } catch (ex) {
      throw const CustomException();
    }
  }

  Future<List<CategoryNameDTO>> fetchNameCategories() async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection("namecategories");
      final snap = await collectionRef.get();
      return snap.docs.map((doc) => CategoryNameDTO.fromDocument(doc)).toList();
    } catch (ex) {
      throw const CustomException();
    }
  }

  Future<List<ColorCategoryDTO>> fetchColorCategories() async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection("colorcategories");
      final snap = await collectionRef.get();
      return snap.docs
          .map((doc) => ColorCategoryDTO.fromDocument(doc))
          .toList();
    } catch (ex) {
      throw const CustomException();
    }
  }

  Future<List<ImageColorCategoryDTO>> fetchImageColorCategories() async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection("imagecolorcategories");
      final snap = await collectionRef.get();
      return snap.docs
          .map((doc) => ImageColorCategoryDTO.fromDocument(doc))
          .toList();
    } catch (ex) {
      throw const CustomException();
    }
  }

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
