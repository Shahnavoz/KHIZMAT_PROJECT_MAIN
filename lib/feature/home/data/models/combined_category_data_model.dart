import 'package:khizmat_new/feature/home/data/models/podcategories_model.dart';
import 'package:khizmat_new/feature/home/data/models/podcategory_specialization_model.dart';

class CombinedCategoryData {
  final Map<int, List<SubcategoryByDocumentIdModel>> subcategoriesByCategory;
  final Map<int, List<Specialization>> specializationsByDocId;

  CombinedCategoryData({
    required this.subcategoriesByCategory,
    required this.specializationsByDocId,
  });
}
