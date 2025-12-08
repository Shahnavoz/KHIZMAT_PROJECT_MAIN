import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/themes/themes.dart';

class ButtonsBarTitles extends ConsumerWidget {
  const ButtonsBarTitles({super.key, required this.size});

  final AdaptiveSizes size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeProvider = ref.watch(themeProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xFFF9F9F9), // 0%
        //     Color(0x1F26AC71), // 50% (12% прозрачности)
        //     Color(0x1F26AC71), // 50% (12% прозрачности)
        //     Color(0xFFF5F5F5),
        //   ],
        //   stops: [0.0, 0.5, 2.0, 1.0],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          left: 0,
          right: 0,
        ), // толщина границы
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            // border: Border.all()
            // gradient: RadialGradient(
            //   radius: 30.0,
            //   center: Alignment.center,
            //   colors: [
            //     Color(0xFF015057),
            //     Color(0xFF26AC71),
            //     Color(0xFFFFFFFF),
            //   ],
            //   stops: [0.0, 0.5, 1.0],
            // ), // основной фон кнопок
          ),
          child: ButtonsTabBar(
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            unselectedLabelStyle: TextStyle(
              color: appThemeProvider ? Colors.black : Colors.white,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.screenWidth * 0.145,
            ),
            buttonMargin: EdgeInsets.zero,
            decoration: BoxDecoration(
              // color: Color(0xFF00858F),
              color: primaryGreenColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              // gradient: RadialGradient(
              //   radius: 30.0,
              //   center: Alignment.center,
              //   colors: [
              //     Color(0xFF015057),
              //     Color(0xFF26AC71),
              //     Color(0xFFFFFFFF),
              //   ],
              //   stops: [0.0, 0.12, 1.0],
              // ),
            ),
            unselectedDecoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            tabs: const [Tab(text: 'Уведомления'), Tab(text: 'Заявления')],
          ),
        ),
      ),
    );
  }
}

// import 'package:buttons_tabbar/buttons_tabbar.dart';
// import 'package:flutter/material.dart';
// import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';

// class ButtonsBarTitles extends StatelessWidget {
//   const ButtonsBarTitles({super.key, required this.size});

//   final AdaptiveSizes size;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//         child: Container(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//           ),
//           child: ButtonsTabBar(
//             // radius: 0,
//             labelStyle: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//             unselectedLabelStyle: TextStyle(
//               // fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//             contentPadding: EdgeInsets.symmetric(
//               horizontal:
//                   size.screenWidth *
//                   0.057, // Уменьшенный отступ для более плотного размещения
//             ),
//             buttonMargin: const EdgeInsets.symmetric(
//               horizontal: 0,
//             ),
//             decoration: const BoxDecoration(
//               // color: Color(0xFF00858F),
//               // gradient: buttonsTitleGradient,
//               color: Color(0xFF015057),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             unselectedDecoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             // Убедитесь, что вкладки имеют одинаковую ширину
//             tabs: const [
//               Tab(
//                 child: SizedBox(
//                   width: 134, // Фиксированная ширина для центрирования
//                   child: Center(
//                     child: Text(
//                       'Уведомления',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ),
//               Tab(
//                 child: SizedBox(
//                   width: 134, // Фиксированная ширина для центрирования
//                   child: Center(
//                     child: Text(
//                       'Заявления',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
