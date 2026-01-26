import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_detail_model.dart';
import 'package:khizmat_new/feature/documents/data/repos/my_document_detail_service.dart';

final documentDetailInfoProvider =
    FutureProvider.family<MyDocumentDetailInfoModel, int>((ref, id) async {
      final repo = MyDocumentDetailService();
      return await repo.getDocumentDetailInfoById(id);
});
