  //CARD TEST PAGE
//   import 'package:flutter/material.dart';
// import 'package:khizmat_new/consts/colors/const_colors.dart';
// import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
// import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
// import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';

// class CardTestPage extends StatefulWidget {
//   @override
//   _CardTestPageState createState() => _CardTestPageState();
// }

// class _CardTestPageState extends State<CardTestPage> {
//   List<String> items = List.generate(5, (index) => 'Element $index');

//   void moveTopToBottom() {
//     setState(() {
//       final top = items.removeLast();
//       items.insert(0, top); // добавляем в начало
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = AdaptiveSizes(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.otstup10),
//           child: Stack(
//             alignment: Alignment.center,
//             children: items.asMap().entries.map((entry) {
//               final index = entry.key;
//               final item = entry.value;

//               final isTop = index == items.length - 1;
//               final scale = 1 - (items.length - 1 - index) * 0.05;
//               final verticalOffset = (items.length - 1 - index) * 10.0;

//               final cardWidget = Transform.translate(
//                 offset: Offset(0, verticalOffset),
//                 child: Transform.scale(
//                   scale: scale,
//                   alignment: Alignment.center,
//                   child: buildCard(item, size, isTop),
//                 ),
//               );

//               if (isTop) {
//                 return Dismissible(
//                   key: ValueKey(item),
//                   direction: DismissDirection.vertical,
//                   onDismissed: (_) {
//                     moveTopToBottom(); // вместо удаления — отправляем вниз
//                   },
//                   child: cardWidget,
//                 );
//               }

//               return cardWidget;
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCard(String item, AdaptiveSizes size, bool isTop) {
//     return SizedBox(
//       height: 140,
//       child: Card(
//         color: Colors.white,
//         // elevation: 6,
//         shadowColor: Colors.black26,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: greyTextFBorderColor),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.otstup15,
//             vertical: size.otstup15,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ContainerAsButton(
//                     size: size,
//                     text: "Гражданство",
//                     backGroundColor: const Color(0xFFBECBC5),
//                   ),
//                   textCWithH2GreyStyle(
//                     "№121223",
//                     fontweight: FontWeight.bold,
//                     color: lightBlackTextColor,
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.otstup10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   textWithH1Style(
//                     textAlign: TextAlign.start,
//                     "Уплата налога на транспортные средства (легковые автомобили)",
//                     fontsize: 16,
//                   ),
//                   SizedBox(height: size.otstup10),
//                   Row(
//                     children: [
//                       sameStyleDifColor("29.09.24", color: greyDateColor),
//                       SizedBox(width: size.otstup10),
//                       Container(width: 1, height: 13, color: Colors.grey),
//                       SizedBox(width: size.otstup10),
//                       sameStyleDifColor("14:00", color: greyDateColor),
//                       SizedBox(width: size.otstup15),
//                       sameStyleDifColor(
//                         "Успешно подписан",
//                         color: const Color(0xFF26AC71),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

  
  
  
  // return Scaffold(
      //   backgroundColor: Colors.black,
      //   body: Stack(
      //     children: [
      //       // Камера
      //       MobileScanner(
      //         controller: mobileScannerController,
      //         onDetect: (capture) {
      //           final barcode = capture.barcodes.first;
      //           if (barcode.rawValue != null) {
      //             _processScanedData(barcode.rawValue!);
      //           }
      //         },
      //       ),

      //       // Затемнение вокруг центральной области
      //       ColorFiltered(
      //         colorFilter: ColorFilter.mode(
      //           Colors.black.withOpacity(0.6),
      //           BlendMode.srcOut,
      //         ),
      //         child: Stack(
      //           children: [
      //             Container(
      //               decoration: const BoxDecoration(
      //                 color: Colors.black,
      //                 backgroundBlendMode: BlendMode.dstOut,
      //               ),
      //             ),
      //             Align(
      //               alignment: Alignment.center,
      //               child: Container(
      //                 width: scanAreaSize,
      //                 height: scanAreaSize,
      //                 decoration: BoxDecoration(
      //                   color: Colors.black,
      //                   borderRadius: BorderRadius.circular(12),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),

      //       // Рамка с углами
      //       Center(
      //         child: CustomPaint(
      //           size: Size(scanAreaSize, scanAreaSize),
      //           painter: _ScannerBorderPainter(),
      //         ),
      //       ),
      //       Positioned(
      //         top: 50,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             IconButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               icon: Icon(Icons.close, color: Colors.white, size: 35),
      //             ),
      //             SizedBox(width: 280),
      //             IconButton(
      //               onPressed: () {
      //                 setState(() {
      //                   isFlashOn = !isFlashOn;
      //                   mobileScannerController.toggleTorch();
      //                 });
      //               },
      //               icon: Icon(
      //                 isFlashOn ? Icons.flash_on : Icons.flash_off,
      //                 color: Colors.white,
      //                 size: 35,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),

      //       // Подпись внизу
      //       Positioned(
      //         bottom: 40,
      //         left: 0,
      //         right: 0,
      //         child: Center(
      //           child: Text(
      //             "Align QR Code within the frame",
      //             style: TextStyle(
      //               color: Colors.white.withOpacity(0.9),
      //               fontSize: 16,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // );

//       class _ScannerBorderPainter extends CustomPainter {
//   final Paint borderPaint =
//       Paint()
//         ..color = Colors.greenAccent
//         ..strokeWidth = 4
//         ..style = PaintingStyle.stroke;

//   @override
//   void paint(Canvas canvas, Size size) {
//     const double cornerLength = 30;
//     final double width = size.width;
//     final double height = size.height;

//     final path =
//         Path()
//           ..moveTo(0, cornerLength)
//           ..lineTo(0, 0)
//           ..lineTo(cornerLength, 0)
//           ..moveTo(width - cornerLength, 0)
//           ..lineTo(width, 0)
//           ..lineTo(width, cornerLength)
//           ..moveTo(0, height - cornerLength)
//           ..lineTo(0, height)
//           ..lineTo(cornerLength, height)
//           ..moveTo(width - cornerLength, height)
//           ..lineTo(width, height)
//           ..lineTo(width, height - cornerLength);

//     canvas.drawPath(path, borderPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }




/*
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khizmat_e_hukumat/consts/colors/const_colors.dart';
import 'package:khizmat_e_hukumat/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_e_hukumat/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_e_hukumat/feature/authorization/presentation/pages/main_question_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();
  var searchController = TextEditingController();
  double scrollOffset = 0;

  final double headerHeight = 420; // высота верхнего блока

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        scrollOffset = _controller.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    // максимальное смещение = половина верхнего блока
    final double stopAt = headerHeight / 2;
    final double currentOffset =
        (scrollOffset ?? 0) > stopAt ? stopAt : (scrollOffset ?? 0);

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 15),
                Text("Shahnavoz", style: h1Title),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_none_outlined),
                ),
                Icon(Icons.qr_code),
              ],
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Stack(
          children: [
            /// 🔹 Верхний блок (фон)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child:
              //VERKHNIY BLOC
              Container(
                // height: headerHeight,
                child: Column(
                  children: [
                    Container(
                      // height: headerHeight,
                      // height: size.screenHeight * 0.65,
                      width: double.infinity,
                      // color: mainPagePartBackGround,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.otstup20,
                          vertical: size.otstup20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(10, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: activeIconColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.otstup20,
                                          vertical: size.horizontalPadding20,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Штрафы",
                                                  style: wrapTextRobotoTitle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: size.otstup15),
                            MyTextFieldWithPrefix(
                              controller: searchController,
                              hintText: "Поиск",
                              backGroundColor: boxGreyTabBorder,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        ButtonsTabBar(
                          buttonMargin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              // topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.black,

                            // color: Colors.grey[100]!
                          ),
                          // unselectedBackgroundColor: Colors.grey[100]!,
                          unselectedDecoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              // topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.transparent,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: size.screenWidth * 0.052,
                            // vertical: 5,
                          ),
                          labelStyle: const TextStyle(color: Colors.white),
                          unselectedLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: const [
                            Tab(text: 'Уведомления'),
                            Tab(text: 'Заявления'),
                            Tab(text: 'Документы'),
                          ],
                        ),
                        Stack(
                          // clipBehavior: Clip.antiAlias,
                          children: [
                            Positioned(
                              top: 100,
                              // bottom: 0,
                              left: 0,
                              child: Container(
                                // width: size.screenWidth * 0.55,
                                // height: size.screenHeight * 0.6,
                                decoration: BoxDecoration(
                                  // gradient:boxBlueRadialGradient ,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "assets/images/ElipseBlue.svg",
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              // bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  fit: BoxFit.cover,
                                  "assets/images/elipseGreeen.svg",
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.otstup20,
                              ),
                              child: Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  border: Border.all(color: greyBorderColor),
                                ),
                                child: TabBarView(
                                  children: [
                                    //UVEDOMLENIYA
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/icons/Group 831885407.png',
                                            width: size.imageSize100,
                                          ),
                                          SizedBox(height: 20),
                                          SizedBox(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "У вас нет новостей",
                                              style: h1Title,
                                              maxLines: 2,
                                            ),
                                          ),
                                          SizedBox(height: size.otstup20),
                                          SizedBox(
                                            width: size.screenWidth * 0.65,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "Получайте доступ к услугам в одном приложении",
                                              style: h2TitleNotSoBold,
                                              maxLines: 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //ZAYAVKI
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/icons/Group 831885407.png',
                                            width: size.imageSize100,
                                          ),
                                          SizedBox(height: 20),
                                          SizedBox(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "У вас нет новостей",
                                              style: h1Title,
                                              maxLines: 2,
                                            ),
                                          ),
                                          SizedBox(height: size.otstup20),
                                          SizedBox(
                                            width: size.screenWidth * 0.65,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "Получайте доступ к услугам в одном приложении",
                                              style: h2TitleNotSoBold,
                                              maxLines: 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //DOCUMENTI
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.otstup15,
                                        vertical: size.otstup15,
                                      ),
                                      child: Column(
                                        children: [
                                          sameStyleDifColor(
                                            "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
                                          ),
                                          SizedBox(height: 5),
                                          Expanded(
                                            child: ListView.separated(
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: size.otstup15,
                                                        ),
                                                        Image.asset(
                                                          'assets/icons/Group 831885407.png',
                                                          width:
                                                              size.imageSize100,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: size.otstup15,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        //OTSTUP
                                                        SizedBox(height: 8),
                                                        SizedBox(
                                                          child: Text(
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            "Сертификаты",
                                                            style: h1Title,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        // SizedBox(
                                                        //   height: size.otstup5,
                                                        // ),
                                                        SizedBox(
                                                          // width: size.screenWidth * 0.64,
                                                          child: Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  sameStyleDifColor(
                                                                    "29.09.24",
                                                                    color:
                                                                        greyDateColor,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        size.otstup10,
                                                                  ),
                                                                  Container(
                                                                    width: 1,
                                                                    height: 13,
                                                                    color:
                                                                        Colors
                                                                            .grey,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        size.otstup10,
                                                                  ),
                                                                  sameStyleDifColor(
                                                                    "14:00",
                                                                    color:
                                                                        greyDateColor,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        size.otstup15,
                                                                  ),
                                                                  sameStyleDifColor(
                                                                    "Успешно подписан",
                                                                    color: Color(
                                                                      0xFF26AC71,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        sameStyleDifColor(
                                                          "Смотреть",
                                                          color: Color(
                                                            0xFF26AC71,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 0),
                                              itemCount: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, currentOffset),
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  children: [
                    SizedBox(height: headerHeight / 0.8),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),

                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            spreadRadius: 10,
                            color: Colors.grey[200]!,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.otstup15,
                          vertical: size.otstup15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWithH1Style("Популярные услуги"),
                            SizedBox(height: size.otstup35),

                            SizedBox(
                              height: size.screenHeight * 0.2,
                              child: GridView.builder(
                                itemCount: 50,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: size.otstup20,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 0.3,
                                    ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: greyBorderColor,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.otstup15,
                                        vertical: size.otstup15,
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/Group 831885407.png",
                                          ),
                                          SizedBox(width: size.otstup15),
                                          SizedBox(
                                            width: size.screenWidth * 0.36,
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              "Архитектура и градостроительство",
                                              style: categoryTextRobotoTitle,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    

                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */


 // backgroundColor: Colors.white,
        // backgroundColor: Colors.black,
        // appBar: AppBar(
        //   flexibleSpace: Container(
        //     decoration: BoxDecoration(gradient: newGradientColor),
        //     child: Padding(
        //       padding: EdgeInsets.only(
        //         top: size.otstup50,
        //         left: size.otstup20,
        //         right: size.otstup20,
        //         bottom: size.otstup10,
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Row(
        //             children: [
        //               CircleAvatar(),
        //               SizedBox(width: 15),
        //               textWithH1Style("Shahnavoz", color: Colors.white),
        //             ],
        //           ),
        //           Row(
        //             children: [
        //               IconButton(
        //                 onPressed: () {},
        //                 icon: Icon(
        //                   Icons.notifications_none_outlined,
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Icon(Icons.qr_code, color: Colors.white),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        //RADIAL GRADIENT
        
                    // gradient: newGradientColor,
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

                    //LENEAR gRADIENT
                    
                                    // gradient: LinearGradient(
                                    //   colors: [
                                    //     Color(0xFFF9F9F9), // 0%
                                    //     Color(
                                    //       0x1F26AC71,
                                    //     ), // 50% (12% прозрачности)
                                    //     Color(
                                    //       0x1F26AC71,
                                    //     ), // 50% (12% прозрачности)
                                    //     Color(0xFFF5F5F5),
                                    //   ],
                                    //   stops: [0.0, 0.5, 2.0, 1.0],
                                    //   begin: Alignment.topLeft,
                                    //   end: Alignment.bottomRight,
                                    // ),
                                    // gradient: borderLinearGradient,

                                    //BUTTON BAR
                                    

                          // ButtonsTabBar(
                          //   // center: true,
                          //   buttonMargin: EdgeInsets.zero,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.only(
                          //       topLeft: Radius.circular(10),
                          //       topRight: Radius.circular(10),
                          //       // bottomRight: Radius.circular(10),
                          //     ),
                          //     border: Border.all(color: Colors.amber),
                          //     color: Color(0xFF015057),
                          //     gradient: RadialGradient(
                          //       radius: 30.0,
                          //       center: Alignment.center,
                          //       colors: [
                          //         Color(0xFF015057),
                          //         Color(0xFF26AC71),
                          //         Color(0xFFFFFFFF),
                          //       ],
                          //       stops: [0.0, 0.12, 1.0],
                          //     ),

                          //     // color: Colors.grey[100]!
                          //   ),
                          //   // unselectedBackgroundColor: Colors.grey[100]!,
                          //   unselectedDecoration: BoxDecoration(
                          //     borderRadius: BorderRadius.only(
                          //       // bottomRight: Radius.circular(10),
                          //       topLeft: Radius.circular(10),
                          //       topRight: Radius.circular(10),
                          //     ),
                          //     color: Colors.transparent,
                          //   ),
                          //   contentPadding: EdgeInsets.symmetric(
                          //     horizontal: size.screenWidth * 0.127,
                          //     // vertical: 5,
                          //   ),
                          //   labelStyle: const TextStyle(color: Colors.white),
                          //   unselectedLabelStyle: const TextStyle(
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          //   tabs: const [
                          //     Tab(text: 'Уведомления'),
                          //     Tab(text: 'Заявления'),
                          //     // Tab(text: 'Документы'),
                          //   ],
                          // ),
                          
                                    //DOCUMENTI
                          
                                    // Padding(
                                    //   padding: EdgeInsets.symmetric(
                                    //     horizontal: size.otstup15,
                                    //     vertical: size.otstup15,
                                    //   ),
                                    //   child: Column(
                                    //     children: [
                                    //       sameStyleDifColor(
                                    //         "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
                                    //       ),
                                    //       SizedBox(height: 5),
                                    //       Expanded(
                                    //         child: ListView.separated(
                                    //           physics:
                                    //               NeverScrollableScrollPhysics(),
                                    //           itemBuilder: (
                                    //             context,
                                    //             index,
                                    //           ) {
                                    //             return Row(
                                    //               // mainAxisAlignment: MainAxisAlignment.center,
                                    //               crossAxisAlignment:
                                    //                   CrossAxisAlignment
                                    //                       .center,
                                    //               children: [
                                    //                 Column(
                                    //                   children: [
                                    //                     // SizedBox(
                                    //                     //   height: size.otstup15,
                                    //                     // ),
                                    //                     Image.asset(
                                    //                       'assets/icons/Group 831885407.png',
                                    //                       width:
                                    //                           size.imageSize100,
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //                 SizedBox(
                                    //                   width: size.otstup15,
                                    //                 ),
                                    //                 Column(
                                    //                   crossAxisAlignment:
                                    //                       CrossAxisAlignment
                                    //                           .start,
                                    //                   mainAxisAlignment:
                                    //                       MainAxisAlignment
                                    //                           .center,
                                    //                   children: [
                                    //                     //OTSTUP
                                    //                     SizedBox(height: 8),
                                    //                     SizedBox(
                                    //                       child: Text(
                                    //                         textAlign:
                                    //                             TextAlign
                                    //                                 .center,
                                    //                         "Сертификаты",
                                    //                         style:
                                    //                             h1Title18,
                                    //                         maxLines: 2,
                                    //                       ),
                                    //                     ),
                                    //                     // SizedBox(
                                    //                     //   height: size.otstup5,
                                    //                     // ),
                                    //                     SizedBox(
                                    //                       // width: size.screenWidth * 0.64,
                                    //                       child: Row(
                                    //                         children: [
                                    //                           Row(
                                    //                             children: [
                                    //                               sameStyleDifColor(
                                    //                                 "29.09.24",
                                    //                                 color:
                                    //                                     greyDateColor,
                                    //                               ),
                                    //                               SizedBox(
                                    //                                 width:
                                    //                                     size.otstup10,
                                    //                               ),
                                    //                               Container(
                                    //                                 width:
                                    //                                     1,
                                    //                                 height:
                                    //                                     13,
                                    //                                 color:
                                    //                                     Colors.grey,
                                    //                               ),
                                    //                               SizedBox(
                                    //                                 width:
                                    //                                     size.otstup10,
                                    //                               ),
                                    //                               sameStyleDifColor(
                                    //                                 "14:00",
                                    //                                 color:
                                    //                                     greyDateColor,
                                    //                               ),
                                    //                               SizedBox(
                                    //                                 width:
                                    //                                     size.otstup15,
                                    //                               ),
                                    //                               sameStyleDifColor(
                                    //                                 "Успешно подписан",
                                    //                                 color: Color(
                                    //                                   0xFF26AC71,
                                    //                                 ),
                                    //                               ),
                                    //                             ],
                                    //                           ),
                                    //                           // Text(
                                    //                           //   // textAlign: TextAlign.center,
                                    //                           //   "Получайте доступ к услугам в одном приложении",
                                    //                           //   style: h2TitleNotSoBold,
                                    //                           //   maxLines: 4,
                                    //                           // ),
                                    //                         ],
                                    //                       ),
                                    //                     ),
                                    //                     sameStyleDifColor(
                                    //                       "Смотреть",
                                    //                       color: Color(
                                    //                         0xFF26AC71,
                                    //                       ),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ],
                                    //             );
                                    //           },
                                    //           separatorBuilder:
                                    //               (context, index) =>
                                    //                   SizedBox(height: 0),
                                    //           itemCount: 3,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),


                                    
                              // SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              //   child:
                              //    Row(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: List.generate(10, (index) {
                              //       return Padding(
                              //         padding:
                              //             index != 0
                              //                 ? EdgeInsets.only(left: 8)
                              //                 : EdgeInsets.only(left: 0),
                              //         child: Container(
                              //           decoration: BoxDecoration(
                              //             gradient: LinearGradient(
                              //               colors: [
                              //                 Color(0xFFF9F9F9), // 0%
                              //                 Color(
                              //                   0x1F26AC71,
                              //                 ), // 50% (12% прозрачности)
                              //                 Color(
                              //                   0x1F26AC71,
                              //                 ), // 50% (12% прозрачности)
                              //                 Color(0xFFF5F5F5),
                              //               ],
                              //               stops: [0.0, 0.5, 2.0, 1.0],
                              //               begin: Alignment.topLeft,
                              //               end: Alignment.bottomRight,
                              //             ),
                              //             // gradient: borderLinearGradient,
                              //             borderRadius: BorderRadius.only(
                              //               topLeft: Radius.circular(13),
                              //               topRight: Radius.circular(13),
                              //             ),
                              //           ),
                              //           child: Container(
                              //             margin: EdgeInsets.all(3.3),
                              //             decoration: BoxDecoration(
                              //               // color: Colors.black,
                              //               // border: Border.all(
                              //               //   color: Color(0xFF26AC71),

                              //               // ),
                              //               gradient: RadialGradient(
                              //                 radius: 30.0,
                              //                 center: Alignment.center,
                              //                 colors: [
                              //                   Color(0xFF015057),
                              //                   Color(0xFF26AC71),
                              //                   Color(0xFFFFFFFF),
                              //                 ],
                              //                 stops: [0.0, 0.12, 1.0],
                              //               ),
                              //               borderRadius: BorderRadius.only(
                              //                 topLeft: Radius.circular(10),
                              //                 topRight: Radius.circular(10),
                              //               ),
                              //             ),
                              //             child: Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                 horizontal: size.otstup20,
                              //                 vertical:
                              //                     size.horizontalPadding20,
                              //               ),
                              //               child: Column(
                              //                 children: [
                              //                   Row(
                              //                     children: [
                              //                       textWithH1Style(
                              //                         "Штрафы",
                              //                         color: Colors.white,
                              //                         fontsize: 16,
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     }),
                              //   ),
                              // ),
                              // SizedBox(height: size.otstup15),
                              // MyTextFieldWithPrefix(
                              //   controller: searchController,
                              //   hintText: "Поиск",
                              //   backGroundColor: boxGreyTabBorder,
                              // ),

                              // SizedBox(height: 20),

                              //  SizedBox(
                              //   height: 100,
                              //    child: TabBar(tabs: [
                              //     Text("data")
                              //    ]),
                              //  )
                              // ButtonsTabBar(
                              //   tabs: [
                              //     Tab(text: "Data"),
                              //     Tab(text: "Data"),
                              //     Tab(text: "Data"),
                              //   ],
                              // ),

