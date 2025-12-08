// // 1. Основной — только шаги, требования и applicationId (кешируется надолго)
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';
// import 'package:khizmat_new/feature/home/data/models/step_requirement_model.dart';
// import 'package:khizmat_new/feature/home/data/repos/shagi_polucheniye_uslugi_service.dart';

// final stepsBaseProvider = FutureProvider.family<StepsBaseInfo, int>((ref, docId) async {
//   final repo = ShagiPolucheniyeUslugiService();

//   final application = await repo.startPostForm(docId);
//   final applicationId = application.data.applicationId;

//   final steps = await repo.getStepsWithInfo(docId, applicationId);
//   final requirements = await repo.getStepRequirement(docId);

//   // Важно: сохраняем applicationId в keepAlive
//   ref.keepAlive();

//   return StepsBaseInfo(
//     applicationId: applicationId,
//     stepsInfo: steps,
//     stepRequirement: requirements,
//   );
// });

// class StepsBaseInfo {
//   final int applicationId;
//   final ShagiPolucheniyeUslugiModel stepsInfo; // одна модель
//   final StepRequirementModel stepRequirement;

//   StepsBaseInfo({required this.applicationId, required this.stepsInfo, required this.stepRequirement});
// }