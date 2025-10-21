// import 'package:flutter/material.dart';
// import 'package:khizmat_e_hukumat/consts/colors/const_colors.dart';
// import 'package:khizmat_e_hukumat/consts/sizes/adaptive_sizes.dart';
// import 'package:khizmat_e_hukumat/consts/text_styles/const_text_styles.dart';

// class TabBarZayavkiListView extends StatelessWidget {
//   const TabBarZayavkiListView({
//     super.key,
//     required this.size,
//   });

//   final AdaptiveSizes size;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.separated(
//         shrinkWrap: true,
//         physics:
//             NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: size.otstup10,
//             ),
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               mainAxisAlignment:
//                   MainAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment
//                           .spaceBetween,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Color(
//                           0xFF002629,
//                         ),
//                         // border:
//                         //     Border.all(),
//                         borderRadius:
//                             BorderRadius.circular(
//                               8,
//                             ),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal:
//                               size.otstup15,
//                           vertical:
//                               size.otstup5,
//                         ),
//                         child:
//                             textWithH1Style(
//                               "Гражданство",
//                               fontsize: 15,
//                               color:
//                                   Colors
//                                       .white,
//                             ),
//                       ),
//                     ),
        
//                     textCWithH2GreyStyle(
//                       "№121223",
//                       fontweight:
//                           FontWeight.bold,
//                       color:
//                           lightBlackTextColor,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: size.otstup10,
//                 ),
//                 Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment
//                           .start,
//                   children: [
//                     textWithH1Style(
//                       textAlign:
//                           TextAlign.start,
//                       "Уплата налога на транспортные средства (легковые автомобили)",
//                       fontsize: 16,
//                     ),
//                     SizedBox(
//                       height: size.otstup10,
//                     ),
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
//                                 width: 1,
//                                 height: 13,
//                                 color:
//                                     Colors
//                                         .grey,
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
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//         separatorBuilder:
//             (context, index) => SizedBox(height: size.otstup10,),
//         itemCount: 1,
//       ),
//     );
//   }
// }
