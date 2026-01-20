import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/documents/presentation/pages/my_documents_page.dart';
import 'package:khizmat_new/feature/history/presentation/pages/history_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/new_home_page.dart';
import 'package:khizmat_new/feature/profile/presentation/pages/profile_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  // List<Widget> icons = [
  //   Icon(Icons.home),
  //   Icon(Icons.payment),
  //   Icon(Icons.grid_view),
  //   Icon(Icons.person),
  // ];
  final List<String> icons = [
    "assets/icons/mainPageIcon.svg",
    "assets/icons/UslugaPageIcon.svg",
    "assets/icons/historyPageIcon.svg",
    "assets/icons/profilePageIcon.svg",
    // Icons.home,
    // Icons.account_balance,
    // Icons.access_time,
    // Icons.person,
  ];

  final List<String> labels = ["Главная", "Документы", "История", "Профиль"];
  List<Widget> pages = [
    NewHomePage(),
    MyDocumentsPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 78,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            bool isActive = _currentIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   icons[index],
                  //   size: size.cancelIconSize50,
                  //   color: isActive ? navActiveIconColor : navIconColor,
                  // ),
                  SvgPicture.asset(
                    icons[index],
                    color: isActive ? primaryButtonColor : greyBorderColor,
                  ),
                  const SizedBox(height: 7),
                  if (!isActive)
                    Text(
                      labels[index],
                      style: const TextStyle(
                        fontSize: 12,
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
    );
  }
}