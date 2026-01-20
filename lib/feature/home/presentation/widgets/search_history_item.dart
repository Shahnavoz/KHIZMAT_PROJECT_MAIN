enum SearchHistoryType { category, document }

class SearchHistoryItem {
  final SearchHistoryType type;
  final int id; // ID категории или документа
  final String title; // Название для отображения

  SearchHistoryItem({
    required this.type,
    required this.id,
    required this.title,
  });

  // Для сохранения в SharedPreferences
  Map<String, dynamic> toJson() => {
    'type': type.index,
    'id': id,
    'title': title,
  };

  factory SearchHistoryItem.fromJson(Map<String, dynamic> json) =>
      SearchHistoryItem(
        type: SearchHistoryType.values[json['type'] as int],
        id: json['id'] as int,
        title: json['title'] as String,
      );
}
