import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/home/data/repos/my_documents_service.dart';

final myDocumentsProvider = FutureProvider((ref) async {
  final repo = MyDocumentsService();
  return await repo.getMyDocuments();
});
