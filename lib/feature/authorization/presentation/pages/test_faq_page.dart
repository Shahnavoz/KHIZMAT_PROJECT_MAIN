// import 'package:flutter/material.dart';

// class FaqPage extends StatefulWidget {
//   FaqPage({super.key});

//   @override
//   State<FaqPage> createState() => _FaqPageState();
// }

// class _FaqPageState extends State<FaqPage> {
//   final List<Map<String, String>> faqList = [
//     {
//       'question': 'Как пользоваться приложением?',
//       'answer':
//           'Вы можете искать, сохранять в избранное и общаться с другими пользователями.',
//     },
//     {
//       'question': 'Как изменить свой профиль?',
//       'answer': 'Перейдите в Профиль > Редактировать, чтобы внести изменения.',
//     },
//     {
//       'question': 'Как связаться с поддержкой?',
//       'answer':
//           'Напишите нам через раздел Чат или по указанной почте внизу страницы.',
//     },
//   ];

//   int? _expandedIndex;

//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context);
//     final isNarrow = media.size.width < 600;
//     final horizontalPadding = isNarrow ? 1.0 : 16.0;
//     final titleFontSize = isNarrow ? 16.0 : 18.0;
//     final answerFontSize = isNarrow ? 14.0 : 15.0;

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: horizontalPadding,
//             vertical: 1,
//           ),
//           child: ListView.separated(
//             // shrinkWrap: true,
//             // physics: NeverScrollableScrollPhysics(),
//             itemCount: faqList.length,
//             separatorBuilder: (_, __) => SizedBox(height: 0),
//             itemBuilder: (context, index) {
//               final item = faqList[index];
//               return Theme(
//                 data: Theme.of(context).copyWith(
//                   dividerColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   highlightColor: Colors.transparent,
//                 ),
//                 child: ExpansionTile(
//                   key: Key("faq$index"),
//                   initiallyExpanded: _expandedIndex == index,
//                   onExpansionChanged: (expanded) {
//                     setState(() {
//                       _expandedIndex = expanded ? index : null;
//                     });
//                   },
//                   tilePadding: EdgeInsets.zero, // убирает отступы у заголовка
//                   childrenPadding: EdgeInsets.zero,
//                   collapsedIconColor: const Color(0xFF2D5D70),
//                   iconColor: const Color(0xFF2D5D70),
//                   title: Text(
//                     item['question'] ?? '',
//                     style: TextStyle(
//                       fontSize: titleFontSize,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   children: [
//                     Text(
//                       item['answer'] ?? '',
//                       style: TextStyle(
//                         fontSize: answerFontSize,
//                         color: const Color(0xFF444444),
//                         height: 1.2,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
