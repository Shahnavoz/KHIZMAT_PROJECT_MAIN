import 'package:khizmat_new/feature/home/data/models/usluga_detail_info.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_specialization.dart';

class CombinedUslugaData {
  final Map<int, List<UslugaDetailInfo>> uslugaDetailInfo;
  final Map<int, List<MySpecialization>> uslugaSpecialization;
  // final Map<int, List<Requirement>> uslugaRequirement;

  CombinedUslugaData({
    required this.uslugaDetailInfo,
    required this.uslugaSpecialization,
    // required this.uslugaRequirement,
  });
}

class SpecializationData {
  final Map<int, List<MySpecialization>> uslugaSpecialization;
  SpecializationData({required this.uslugaSpecialization});
}


// class _DocResult {
//   final int docId;
//   final UslugaDetailInfo detail;
//   final List<MySpecialization> specializations;
//   final int categoryId;

//   _DocResult({
//     required this.docId,
//     required this.detail,
//     required this.specializations,
//     required this.categoryId,
//   });
// }