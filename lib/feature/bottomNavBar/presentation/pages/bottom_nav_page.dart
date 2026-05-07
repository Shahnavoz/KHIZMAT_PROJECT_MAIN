import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/feature/documents/presentation/pages/my_documents_page.dart';
import 'package:khizmat_new/feature/home/data/providers/all_updated_date_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/all_categories_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/new_home_page.dart';
import 'package:khizmat_new/feature/profile/presentation/pages/profile_page.dart';
import 'package:khizmat_new/generated/l10n.dart';

class BottomNavPage extends ConsumerStatefulWidget {
  const BottomNavPage({super.key});

  @override
  ConsumerState<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends ConsumerState<BottomNavPage> {
  int _currentIndex = 0;

  final List<String> icons = [
    "assets/icons/mainPageIcon.svg",
    "assets/icons/UslugaPageIcon.svg",
    "assets/icons/historyPageIcon.svg",
    "assets/icons/profilePageIcon.svg",
  ];

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (ctx) => AlertDialog(
                title: Text(S.of(context).exite),
                content: Text(S.of(context).areYouSure),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: Text(S.of(context).cancel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: Text(S.of(context).exite),
                  ),
                ],
              ),
        ) ??
        false;
  }

  /// Builds the Services tab — loads categories/documents from the provider
  /// and passes them to AllCategoriesPage.
  Widget _buildServicesTab() {
    final asyncData = ref.watch(allUpdatedDateProvider);
    return asyncData.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text(e.toString()))),
      data: (data) {
        if (data == null) {
          return const Scaffold(body: Center(child: Text('Нет данных')));
        }
        return AllCategoriesPage(
          categories: data.data.categories,
          documents: data.data.documents,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> labels = [
      S.of(context).main,
      S.of(context).documents,
      S.of(context).services,
      S.of(context).profile,
    ];

    final pages = [
      const NewHomePage(),
      MyDocumentsPage(selectedIndex: 0, document: const []),
      _buildServicesTab(),
      const ProfilePage(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (_currentIndex != 0) {
          setState(() => _currentIndex = 0);
        } else {
          final shouldExit = await _showExitDialog(context);
          if (shouldExit) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: greyBorderColor, width: 1)),
            color: Colors.white,
          ),
          height: 78,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final isActive = _currentIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _currentIndex = index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icons[index],
                      width: 25,
                      height: 25,
                      colorFilter: ColorFilter.mode(
                        isActive ? primaryButtonColor : greyBorderColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 7),
                    if (!isActive)
                      Text(
                        labels[index],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (isActive)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: navDotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
