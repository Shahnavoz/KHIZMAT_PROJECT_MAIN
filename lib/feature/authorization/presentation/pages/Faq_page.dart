import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final List<Map<String, String>> faqList = [
    {
      'question': 'Как пользоваться приложением?',
      'answer':
          'Вы можете искать, сохранять в избранное и общаться с другими пользователями.'
          'Вы можете искать, сохранять в избранное и общаться с другими пользователями.'
          'Вы можете искать, сохранять в избранное и общаться с другими пользователями.'
          'Вы можете искать, сохранять в избранное и общаться с другими пользователями.'
    },
    {
      'question': 'Как изменить свой профиль?',
      'answer': 'Перейдите в Профиль > Редактировать, чтобы внести изменения.',
    },
    {
      'question': 'Как связаться с поддержкой?',
      'answer':
          'Напишите нам через раздел Чат или по указанной почте внизу страницы.',
    },
    {
      'question': 'Как пользоваться приложением?',
      'answer':
          'Вы можете искать, сохранять в избранное и общаться с другими пользователями.',
    },
    {
      'question': 'Как изменить свой профиль?',
      'answer': 'Перейдите в Профиль > Редактировать, чтобы внести изменения.',
    },
    {
      'question': 'Как связаться с поддержкой?',
      'answer':
          'Напишите нам через раздел Чат или по указанной почте внизу страницы.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isNarrow = media.size.width < 600;
    final horizontalPadding = isNarrow ? 1.0 : 1.0;
    final titleFontSize = isNarrow ? 16.0 : 18.0;
    final answerFontSize = isNarrow ? 14.0 : 15.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 0,
            ),
            child: ExpansionPanelList.radio(
              expandedHeaderPadding: EdgeInsets.zero,
              materialGapSize: 0,
              elevation: 0,
              dividerColor: dividerColor,
              children:
                  faqList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return ExpansionPanelRadio(
                      value: index,
                      canTapOnHeader: true,
                      headerBuilder:
                          (context, isExpanded) => ListTile(
                            title: Text(
                              item['question'] ?? '',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                      body: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item['answer'] ?? '',
                          style: TextStyle(
                            fontSize: answerFontSize,
                            color: Color(0xFF444444),
                            height: 1.2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
