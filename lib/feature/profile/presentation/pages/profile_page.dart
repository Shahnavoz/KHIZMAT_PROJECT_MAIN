import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/dropDownModal.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/footer_company_text.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';
import 'package:khizmat_new/feature/profile/data/repos/profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String name = "Шахриер";
  final String LastName = "Мирзония";
  final profileService = ProfileService();
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: Colors.transparent
      //   automaticallyImplyLeading: false,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           shape: BoxShape.circle,
      //         ),

      //         child: Padding(
      //           padding: EdgeInsets.only(left: 10),
      //           child: IconButton(
      //             onPressed: () {},
      //             icon: Icon(Icons.arrow_back_ios, color: primaryButtonColor),
      //           ),
      //         ),
      //       ),
      //       Container(
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           shape: BoxShape.circle,
      //         ),

      //         child: IconButton(
      //           onPressed: () {},
      //           icon: Icon(Icons.abc, color: primaryButtonColor),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF5EB681), Color(0xFFEBEBEB)],
                stops: [1.0, 1.0],
                center: Alignment.topRight,
              ),
            ),
            // child: Image.asset(
            //   "assets/images/image 17.png",
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            // ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              border: Border.all(),
            ),
          ),
          Positioned(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.otstup60,
                      left: size.otstup20,
                      right: size.otstup20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.otstup20),
                        textWithH1Style("Профиль", textAlign: TextAlign.start),
                        SizedBox(height: size.otstup30),

                        Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1, -5),
                                spreadRadius: 5,
                                blurRadius: 15,
                                color: Colors.grey[100]!,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.otstup10,
                              vertical: size.otstup15,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: primaryGreenColor,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        // shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          width: 50,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            // border: Border.all(),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            // color: Colors.grey[200],
                                          ),

                                          child: Center(
                                            child: Text(
                                              "${name[0].toUpperCase()}${LastName[0].toUpperCase()}",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: size.otstup10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: size.screenWidth * 0.6,
                                          child: scrollTextWithH1Style(
                                            "${name} ${LastName}",
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: size.screenWidth*0.5,
                                        //   child: smartScrollableLastLine(
                                        //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                        //   ),
                                        // ),
                                        SizedBox(height: size.otstup5),
                                        textWithH2BlackStyle("+992934752002"),
                                        SizedBox(height: size.otstup5),
                                        ContainerAsButton(
                                          width: size.screenWidth * 0.55,
                                          textColor: primaryGreenColor,
                                          size: size,
                                          text: "Подтвержденный профиль",
                                          backGroundColor: Colors.grey[100]!,
                                          borderColor: greyTextFBorderColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.otstup15),

                                // Divider(color: greyTextFBorderColor),
                                // SizedBox(height: size.otstup18),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     ProfileContainerWithInfo(
                                //       size: size,
                                //       title: "2",
                                //       subTitle: "Подписи",
                                //     ),
                                //     ProfileContainerWithInfo(
                                //       size: size,
                                //       title: "3",
                                //       subTitle: "Ожидание услуг",
                                //     ),
                                //     ProfileContainerWithInfo(
                                //       size: size,
                                //       title: "21",
                                //       subTitle: "Получено услуг",
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.otstup25),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: greyTextFBorderColor),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.otstup20,
                            vertical: size.otstup15,
                          ),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWithH1Style(
                                    "Общие настройки",
                                    fontsize: 18,
                                  ),
                                  SizedBox(height: size.otstup5),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: ProfileSettingContainer(
                                      size: size,
                                      text: "Настройка профиля",
                                      color: primaryGreenColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: ProfileSettingContainer(
                                      size: size,
                                      text: "Настройка уведомлений",
                                      color: primaryGreenColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          context: context,
                                          builder: (context) {
                                            return Dropdownmodal();
                                          },
                                        );
                                      },
                                      child: ProfileSettingContainer(
                                        size: size,
                                        text: "Настройки языка",
                                        color: primaryGreenColor,
                                      ),
                                    ),
                                  ),
                                  // ListView.builder(
                                  //   physics: NeverScrollableScrollPhysics(),
                                  //   padding: EdgeInsets.zero,
                                  //   shrinkWrap: true,
                                  //   itemCount: 3,
                                  //   itemBuilder: (context, index) {
                                  //     return Padding(
                                  //       padding: const EdgeInsets.symmetric(
                                  //         vertical: 5,
                                  //       ),
                                  //       child: ProfileSettingContainer(
                                  //         size: size,
                                  //         text: "Настройка уведомлений",
                                  //         color:
                                  //             index % 2 == 0
                                  //                 ? primaryGreenColor
                                  //                 : secondaryGreenColor,
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                ],
                              ),
                              SizedBox(height: size.otstup15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWithH1Style("Помощь", fontsize: 18),
                                  SizedBox(height: size.otstup5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: ProfileSettingContainer(
                                      size: size,
                                      text: "Где мы находимся ?",
                                      color: primaryGreenColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: ProfileSettingContainer(
                                      size: size,
                                      text: "Поддержка",
                                      color: primaryGreenColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: ProfileSettingContainer(
                                      size: size,
                                      text: "Документы",
                                      color: primaryGreenColor,
                                    ),
                                  ),

                                  // ListView.builder(
                                  //   padding: EdgeInsets.zero,
                                  //   physics: NeverScrollableScrollPhysics(),
                                  //   shrinkWrap: true,
                                  //   itemCount: 2,
                                  //   itemBuilder: (context, index) {
                                  //     return Padding(
                                  //       padding: const EdgeInsets.symmetric(
                                  //         vertical: 5,
                                  //       ),
                                  //       child: ProfileSettingContainer(
                                  //         size: size,
                                  //         text: "Настройка уведомлений",
                                  //         color:
                                  //             index % 2 == 0
                                  //                 ? primaryGreenColor
                                  //                 : prima,
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  SizedBox(height: size.otstup15),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.otstup5,
                                    ),
                                    child: Column(
                                      children: [
                                        My_Button(
                                          borderRadius: 50,
                                          width: double.infinity,
                                          size: size,
                                          backgroundColor: Colors.white,
                                          borderColor: greyTextFBorderColor,
                                          onPressed: () {
                                            setState(() {
                                              // profileService.logOut();
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: textWithH1Style(
                                            "Выход с приложения",
                                            fontsize: 15,
                                            color: primaryGreenColor,
                                          ),
                                        ),
                                        SizedBox(height: size.otstup5),
                                        FooterCompanyText(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSettingContainer extends StatelessWidget {
  const ProfileSettingContainer({
    super.key,
    required this.size,
    required this.text,
    required this.color,
  });

  final AdaptiveSizes size;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEFEFEF), width: 2),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.otstup5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.otstup10),
                  child: SvgPicture.asset(
                    "assets/icons/profileIcon.svg",
                    color: color,
                    width: size.imageSize60,
                  ),
                ),
                SizedBox(width: size.otstup18),
                textWithH1Style(text, fontsize: 16),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.otstup10),
              child: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            // ),
          ],
        ),
      ),
    );
  }
}

class ProfileContainerWithInfo extends StatelessWidget {
  const ProfileContainerWithInfo({
    super.key,
    required this.size,
    required this.title,
    required this.subTitle,
  });

  final AdaptiveSizes size;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.otstup10,
          vertical: size.otstup15,
        ),
        child: Column(
          children: [
            textWithH1Style(title, fontsize: 22),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.otstup10),
              child: Container(
                width: 90,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            textWithH1Style(
              subTitle,
              fontsize: 12,
              fontW: FontWeight.w600,
              color: Color(0xFF686868),
            ),
          ],
        ),
      ),
    );
  }
}
