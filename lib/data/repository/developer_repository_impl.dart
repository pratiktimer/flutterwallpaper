import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/core/util/custom_exception.dart';
import 'package:flutterwallpaper/data/models/developer_dto.dart';
import 'package:flutterwallpaper/domain/repository/developer_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final developerRepositoryProvider =
    Provider<DeveloperRepositoryImpl>((ref) => DeveloperRepositoryImpl());

class DeveloperRepositoryImpl implements DeveloperRepository {
  @override
  Future<DataState<DeveloperDTO>> FetchDeveloper() async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection("developer");
      final docRef = collectionRef.doc("pratik");
      final docSnapshot = await docRef.get();
      final docData = docSnapshot.data() as Map<String, dynamic>;
      final developerDetail = DeveloperDTO.fromJson(docData);
      return DataSuccess(developerDetail);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }
}
