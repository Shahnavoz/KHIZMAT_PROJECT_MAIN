// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:khizmat_new/feature/documents/data/providers/my_application_provider.dart';

// class ApplicationsScreen extends ConsumerStatefulWidget {
//   const ApplicationsScreen({super.key});

//   @override
//   ConsumerState<ApplicationsScreen> createState() => _ApplicationsScreenState();
// }

// class _ApplicationsScreenState extends ConsumerState<ApplicationsScreen> {
//   final _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }

//   void _onScroll() {
//     if (_scrollController.position.extentAfter < 400) {
//       ref.read(applicationsNotifierProvider.notifier).loadNextPage();
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(applicationsNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Заявки')),
//       body: RefreshIndicator(
//         onRefresh: () => ref.read(applicationsNotifierProvider.notifier).refresh(),
//         child: state.when(
//           data: (data) => ListView.builder(
//             controller: _scrollController,
//             itemCount: data.items.length + (data.hasMore ? 1 : 0),
//             itemBuilder: (context, index) {
//               if (index == data.items.length) {
//                 return const Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Center(child: CircularProgressIndicator()),
//                 );
//               }

//               final app = data.items[index];
//               return ListTile(title: Text(app.document!.ru ?? 'Заявка ${index + 1}'));
//             },
//           ),
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (err, st) => Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('Ошибка: $err'),
//                 ElevatedButton(
//                   onPressed: () => ref.read(applicationsNotifierProvider.notifier).refresh(),
//                   child: const Text('Повторить'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }