import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';

class MyDocumentsPage extends StatefulWidget {
  const MyDocumentsPage({super.key});

  @override
  State<MyDocumentsPage> createState() => _MyDocumentsPageState();
}

class _MyDocumentsPageState extends State<MyDocumentsPage> {
  var controller = TextEditingController();
  int selectedIndex = 0;
  int statusSelectedIndex = 0;
  List<String> tabBars = ["Все", "Активный", "Не подписанный"];
  List<Map<String, dynamic>> info = [
    {"count": "5", "text": "Сертификатов"},
    {"count": "12", "text": "Получено услуг"},
    {"count": "1", "text": "Истекло"},
  ];
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Scaffold(
      appBar: CustomAppbar(
        title: "Шахриер Мирзония",
        leadingWidget: CircleAvatar(),
      ),

      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.otstup20,
                  vertical: size.otstup15,
                ),
                child: Column(
                  children: [
                    MyTextFieldWithPrefix(
                      hintText: "Поиск вопросов",
                      controller: controller,
                      onChanged: (valie) {},
                      prefixIcon: Icon(Icons.search),
                    ),
                    SizedBox(height: size.otstup18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        2,
                        (index) => Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedIndex = index),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.otstup10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      selectedIndex == index
                                          ? primaryGreenColor
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color:
                                        selectedIndex == index
                                            ? Colors.transparent
                                            : greyTextFBorderColor,
                                  ),
                                ),
                                child: Center(
                                  child: textWithH1Style(
                                    index == 0 ? "Мои документы" : "Заявки",
                                    fontsize: 16,
                                    color:
                                        selectedIndex == index
                                            ? Colors.white
                                            : Color(0xFFA9A9A9),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.otstup10),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        border: Border.all(color: greyBorderColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.otstup10,
                          vertical: size.otstup15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            3,
                            (index) => ContainerInDocPage(
                              size: size,
                              index: index,
                              info: info,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.screenHeight * 0.05),
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: greyBorderColor)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    selectedIndex == 0
                        ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.otstup20,
                            vertical: size.otstup15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWithH1Style(
                                "Мои документы",
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: size.otstup18),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: greyTextFBorderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.otstup10,
                                    vertical: size.otstup5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(tabBars.length, (
                                      index,
                                    ) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          // horizontal: size.otstup5,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              statusSelectedIndex = index;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    selectedIndex == index
                                                        ? greyBorderColor
                                                        : greyTextFBorderColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color:
                                                  statusSelectedIndex == index
                                                      ? Colors.black
                                                      : Colors.transparent,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: size.otstup10,
                                                horizontal: size.otstup15,
                                              ),
                                              child: textWithH1Style(
                                                tabBars[index],
                                                fontsize: 16,
                                                color:
                                                    statusSelectedIndex == index
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),

                              SizedBox(height: size.otstup15),

                              statusSelectedIndex == 0
                                  ? ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: greyBorderColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.otstup15,
                                                vertical: size.otstup15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/Group 831885639.png",
                                                      ),
                                                      SizedBox(
                                                        width: size.otstup15,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          textWithH1Style(
                                                            "Справка несудимости",
                                                            fontsize: 16,
                                                          ),
                                                          textWithH2BlackStyle(
                                                            "Справки",
                                                            fontSize: 16,
                                                            textAlign:
                                                                TextAlign.start,
                                                            color:
                                                                primaryGreenColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color:
                                                                greyBorderColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                6.0,
                                                              ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: greyBorderColor,
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Color(0xFFF6FFFA),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: size.otstup15,
                                                  vertical: size.otstup15,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    textWithH1Style(
                                                      "Дата выдачи: 01.12.25",
                                                      fontsize: 14,
                                                      color: greyBorderColor,
                                                      fontW: FontWeight.w500,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            index == 0
                                                                ? Color(
                                                                  0xFF53CDE5,
                                                                )
                                                                : Color(
                                                                  0xFFF7EAEA,
                                                                ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.otstup30,
                                                              vertical:
                                                                  size.otstup10,
                                                            ),
                                                        child: textWithH1Style(
                                                          index == 0
                                                              ? "Активный"
                                                              : "Не подписанный",
                                                          fontsize: 13,
                                                          color:
                                                              index == 0
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (context, index) =>
                                            SizedBox(height: size.otstup10),
                                    itemCount: 2,
                                  )
                                  : statusSelectedIndex == 1
                                  ? ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: greyBorderColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.otstup15,
                                                vertical: size.otstup15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/Group 831885639.png",
                                                      ),
                                                      SizedBox(
                                                        width: size.otstup15,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          textWithH1Style(
                                                            "Справка несудимости",
                                                            fontsize: 16,
                                                          ),
                                                          textWithH2BlackStyle(
                                                            "Справки",
                                                            fontSize: 16,
                                                            textAlign:
                                                                TextAlign.start,
                                                            color:
                                                                primaryGreenColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color:
                                                                greyBorderColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                6.0,
                                                              ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: greyBorderColor,
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Color(0XffF6FFFA),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: size.otstup15,
                                                  vertical: size.otstup15,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    textWithH1Style(
                                                      "Дата выдачи: 01.12.25",
                                                      fontsize: 14,
                                                      color: greyBorderColor,
                                                      fontW: FontWeight.w300,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                          0xFF53CDE5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.otstup30,
                                                              vertical:
                                                                  size.otstup10,
                                                            ),
                                                        child: textWithH1Style(
                                                          "Активный",
                                                          fontsize: 13,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (context, index) =>
                                            SizedBox(height: size.otstup10),
                                    itemCount: 2,
                                  )
                                  : ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: greyBorderColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.otstup15,
                                                vertical: size.otstup15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/Group 831885639.png",
                                                      ),
                                                      SizedBox(
                                                        width: size.otstup15,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          textWithH1Style(
                                                            "Справка несудимости",
                                                            fontsize: 16,
                                                          ),
                                                          textWithH2BlackStyle(
                                                            "Справки",
                                                            fontSize: 16,
                                                            textAlign:
                                                                TextAlign.start,
                                                            color:
                                                                primaryGreenColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color:
                                                                greyBorderColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                6.0,
                                                              ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: greyBorderColor,
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Color(0xFFF6FFFA),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: size.otstup15,
                                                  vertical: size.otstup15,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    textWithH1Style(
                                                      "Дата выдачи: 01.12.25",
                                                      fontsize: 14,
                                                      color: greyBorderColor,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                          0xFFF7EAEA,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.otstup30,
                                                              vertical:
                                                                  size.otstup10,
                                                            ),
                                                        child: textWithH1Style(
                                                          "Не подписанный",
                                                          fontsize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (context, index) =>
                                            SizedBox(height: size.otstup10),
                                    itemCount: 2,
                                  ),
                            ],
                          ),
                        )
                        : Column(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerInDocPage extends StatelessWidget {
  const ContainerInDocPage({
    super.key,
    required this.size,
    required this.index,
    required this.info,
  });

  final AdaptiveSizes size;
  final int index;
  final List<Map<String, dynamic>> info;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.screenWidth * 0.28,
      decoration: BoxDecoration(
        border: Border.all(color: greyBorderColor),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.otstup5),
                  child: Text(
                    info[index]['count'].toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: size.screenWidth * 0.273,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: greyBorderColor)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      info[index]['text'],
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
