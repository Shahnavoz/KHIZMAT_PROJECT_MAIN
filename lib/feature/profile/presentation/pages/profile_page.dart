import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/support_modal.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/button_modal_bottom_sheet.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/dropDownModal.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/footer_company_text.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/documents/presentation/pages/my_documents_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/deeplink/user_profile.dart';
import 'package:khizmat_new/deeplink/auth_provider.dart';
import 'package:khizmat_new/feature/profile/data/repos/profile_service.dart';
import 'package:khizmat_new/feature/profile/presentation/pages/private_policy.dart';
import 'package:khizmat_new/feature/profile/presentation/widgets/open_map_page.dart';
import 'package:khizmat_new/generated/l10n.dart';
import 'package:map_launcher/map_launcher.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final profileService = ProfileService();

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final user = ref.watch(userProfileProvider);
    final displayName =
        user?.displayName.isNotEmpty == true ? user!.displayName : '—';
    final displayPhone = user?.displayPhone ?? '';
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
              // gradient: RadialGradient(
              //   colors: [Color(0xFF5EB681), Color(0xFFEBEBEB)],
              //   stops: [1.0, 1.0],
              //   center: Alignment.topRight,
              // ),
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
          Positioned.fill(
            child: RefreshIndicator(
              onRefresh: () => ref.read(userProfileProvider.notifier).reload(),
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
                          textWithH1Style(
                            S.of(context).profile,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: size.otstup30),

                          Container(
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              // boxShadow: [
                              //   BoxShadow(
                              //     offset: Offset(1, -5),
                              //     spreadRadius: 5,
                              //     blurRadius: 15,
                              //     color: Colors.grey[100]!,
                              //   ),
                              // ],
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
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     border: Border.all(
                                      //       width: 2,
                                      //       color: primaryGreenColor,
                                      //     ),
                                      //     borderRadius: BorderRadius.circular(12),
                                      //     // shape: BoxShape.circle,
                                      //   ),
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(2.0),
                                      //     child: Container(
                                      //       width: 50,
                                      //       height: 60,
                                      //       decoration: BoxDecoration(
                                      //         // border: Border.all(),
                                      //         borderRadius: BorderRadius.circular(
                                      //           12,
                                      //         ),
                                      //         // color: Colors.grey[200],
                                      //       ),

                                      //       child: Center(
                                      //         child: Text(
                                      //           "${name[0].toUpperCase()}${LastName[0].toUpperCase()}",
                                      //           style: TextStyle(
                                      //             fontSize: 22,
                                      //             fontWeight: FontWeight.bold,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(width: size.otstup10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.screenWidth * 0.6,
                                            child: scrollTextWithH1Style(
                                              displayName,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: size.screenWidth*0.5,
                                          //   child: smartScrollableLastLine(
                                          //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                          //   ),
                                          // ),
                                          SizedBox(height: size.otstup5),
                                          textWithH2BlackStyle(displayPhone),
                                          SizedBox(height: size.otstup5),
                                          ContainerAsButton(
                                            width: size.screenWidth * 0.55,
                                            textColor: primaryGreenColor,
                                            size: size,
                                            text: S.of(context).verifiedProfile,
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
                              vertical: size.otstup25,
                            ),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWithH1Style(
                                      S.of(context).commonSettings,
                                      fontsize: 18,
                                    ),
                                    SizedBox(height: size.otstup5),

                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     vertical: 5,
                                    //   ),
                                    //   child: ProfileSettingContainer(
                                    //     size: size,
                                    //     text: "Настройка профиля",
                                    //     color: primaryGreenColor,
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     vertical: 5,
                                    //   ),
                                    //   child: ProfileSettingContainer(
                                    //     size: size,
                                    //     text: "Настройка уведомлений",
                                    //     color: primaryGreenColor,
                                    //   ),
                                    // ),
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
                                          text: S.of(context).languageSettings,
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
                                    textWithH1Style(
                                      S.of(context).help,
                                      fontsize: 18,
                                    ),
                                    SizedBox(height: size.otstup5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: GestureDetector(
                                        onTap:
                                            () => showMapSelectionBottomSheet(
                                              context,
                                            ),
                                        child: ProfileSettingContainer(
                                          size: size,
                                          text: S.of(context).whereAreWe,
                                          color: primaryGreenColor,
                                        ),
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
                                              return SupportCard(
                                                size: size,
                                                widget: ButtonModalBottomSheet(
                                                  size: size,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: ProfileSettingContainer(
                                          size: size,
                                          text: S.of(context).support,
                                          color: primaryGreenColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => MyDocumentsPage(
                                                    selectedIndex: 0,
                                                    document: [],
                                                  ),
                                            ),
                                          );
                                        },
                                        child: ProfileSettingContainer(
                                          size: size,
                                          text: S.of(context).myDocuments,
                                          color: primaryGreenColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      const PrivatePolicyPage(),
                                            ),
                                          );
                                        },
                                        child: ProfileSettingContainer(
                                          size: size,
                                          text: S.of(context).privatePolicy,
                                          color: primaryGreenColor,
                                        ),
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
                                    SizedBox(height: size.otstup70),

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
                                              ref
                                                  .read(authProvider.notifier)
                                                  .logout();
                                            },
                                            child: textWithH1Style(
                                              S.of(context).exitTheApp,
                                              fontsize: 15,
                                              color: primaryGreenColor,
                                            ),
                                          ),
                                          SizedBox(height: size.otstup35),
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
              ), // RefreshIndicator
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
                // Padding(
                //   padding: EdgeInsets.only(left: size.otstup10),
                //   child: SvgPicture.asset(
                //     "assets/icons/profileIcon.svg",
                //     color: color,
                //     width: size.imageSize60,
                //   ),
                // ),
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

var targetLocation = Coords(38.573542, 68.80071);
const targetTitle = "Наш адрес";
const targetDescription = "ЦОН";

Future<void> showMapSelectionBottomSheet(BuildContext context) async {
  try {
    final availableMaps = await MapLauncher.installedMaps;

    if (availableMaps.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).notInstalledMap)));
      return;
    }

    if (availableMaps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "На устройстве не установлено ни одной карты.\nУстановите Google Maps, Яндекс.Карты или 2GIS.",
          ),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    if (!context.mounted) return;

    // Показываем красивый bottom sheet
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Заголовок и полоса
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      S.of(context).chooseTheMap,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: availableMaps.length,
                      itemBuilder: (context, index) {
                        final map = availableMaps[index];
                        return ListTile(
                          leading:
                              map.icon != null
                                  ? SvgPicture.asset(
                                    map.icon, // это String — путь к .svg
                                    height: 36,
                                    width: 36,
                                    placeholderBuilder:
                                        (context) =>
                                            const Icon(Icons.map, size: 36),
                                  )
                                  : const Icon(Icons.map, size: 36),
                          title: Text(
                            map.mapName,
                            style: const TextStyle(fontSize: 17),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            await map.showMarker(
                              coords: targetLocation,
                              title: targetTitle,
                              description: targetDescription,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  } catch (e) {
    debugPrint("Ошибка при работе с картами: $e");
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
