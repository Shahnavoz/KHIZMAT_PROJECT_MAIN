import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: "Уведомления"),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: size.otstup15),
        child: Column(
          children: [
            Row(
              children: List.generate(2, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.otstup15),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              index != selectedIndex
                                  ? greyTextFBorderColor
                                  : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color:
                            selectedIndex == index
                                ? primaryGreenColor
                                : Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.otstup10,
                          horizontal: size.otstup15,
                        ),
                        child: textWithH1Style(
                          index == 0 ? "Уведомления" : "Новости",
                          fontsize: 16,
                          color:
                              selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: size.otstup15),

            selectedIndex == 0
                ? Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Color(0xFFF7F7F7)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.otstup10,
                          horizontal: size.otstup15,
                        ),
                        child: textWithH1Style(
                          "25 ноября, среда",
                          textAlign: TextAlign.start,
                          color: Color(0xFFAFAFAF),
                        ),
                      ),
                    ),
                    SizedBox(height: size.otstup10),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.otstup10,
                          ),
                          child: Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: greyTextFBorderColor,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Color(0xFFF7FFFB),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(size.otstup10),
                                      child: Image.asset(
                                        "assets/images/Group (15).png",
                                        color: primaryGreenColor,
                                        width: size.imageSize50,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.otstup5),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: greyTextFBorderColor,
                                      ),
                                      color: Color(0xFFF7FFFB),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFF6FFFA),
                                          Color(0xFFFFFFFF),
                                        ],
                                        stops: [0.0,1.0]
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: greyTextFBorderColor,
                                              ),
                                            ),
                                          ),
                                          child: SizedBox(
                                            width: size.screenWidth * 0.83,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.otstup10,
                                                vertical: size.otstup10,
                                              ),
                                              child: Text(
                                                "Уважаемый абонент!Разрешение на начало строитель, выожрмол яво псмыфворпмс  ч фыпсдшг чффшспш пфысшг фпсноыча.",
                                                style: Roboto15T,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.otstup10,
                                            vertical: size.otstup10,
                                          ),
                                          child: Text(
                                            "15:30",
                                            style: Roboto15C,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: size.otstup10),
                      itemCount: 3,
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 200),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // border: Border.all(),
                            shape: BoxShape.circle,
                            color: greyTextFBorderColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Image.asset(
                              "assets/images/Group (15).png",
                              color: primaryGreenColor,
                            ),
                          ),
                        ),
                        SizedBox(height: size.otstup10),
                        textWithH1Style("Уведомлений пока нет"),
                        textWithH2GreyStyle(
                          "Мы обязательно оповестим вас, когда появится новая информация.",
                        ),
                        My_Button(
                          width: size.screenWidth * 0.35,
                          size: size,
                          backgroundColor: Colors.white,
                          borderColor: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: textWithH1Style("Назад", fontsize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
