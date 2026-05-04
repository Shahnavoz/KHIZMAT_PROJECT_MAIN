import 'package:khizmat_new/feature/documents/data/models/my_applications_model.dart';

class ApplicationResponse {
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final List<ApplicationItem> applications;

  ApplicationResponse({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.applications,
  });

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationResponse(
      totalItems: json['totalItems'] as int,
      totalPages: json['totalPages'] as int,
      currentPage: json['currentPage'] as int,
      applications:
          (json['data']['application_list'] as List)
              .map((e) => ApplicationItem.fromJson(e))
              .toList(),
    );
  }
}
