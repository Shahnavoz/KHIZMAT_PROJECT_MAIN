import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/different_providers.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/dropdown_test.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/button_modal_bottom_sheet.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/button_or_container_with_two_parts.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/footer_company_text.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my_animated_dot_indicator.dart';
import 'package:khizmat_new/feature/bottomNavBar/presentation/pages/bottom_nav_page.dart';
import 'package:khizmat_new/generated/l10n.dart';

class MainEnterPage extends ConsumerStatefulWidget {
  const MainEnterPage({super.key});

  @override
  ConsumerState<MainEnterPage> createState() => _MainEnterPageState();
}

class _MainEnterPageState extends ConsumerState<MainEnterPage> {
  var controller = CarouselSliderController();
  var pageController = PageController();
  var emailController = TextEditingController(text: "fiz_fo@gmail.com");
  var passwordController = TextEditingController(text: "x5a9Iexz7XRX");
  final _formKey = GlobalKey<FormState>();
  var storage = FlutterSecureStorage();
  Future<void> login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse("https://apikhizmat.ehukumat.tj/v1/oauth/email/login"),

        headers: <String, String>{
          "Content-Type": "application/json;Charset=utf-8",
          "Accept": "application/json",
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json['data'] != null &&
            json['data']['token'] != null &&
            json['data']['token']['access_token'] != null) {
          final token = json['data']['token']['access_token'];
          await storage.write(key: 'token', value: token);
          print('Login successful! Token: $token');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavPage()),
            // MaterialPageRoute(builder: (context) => TestHomePage()),
          );
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Success:')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Neverniy email ili parol')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(' ${e.toString()}')));
      }
      print("ERROR:$e");
    }
  }

  void showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    pageController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> texts = [
      {
        "title": S.of(context).poluchay_uslugi_ne_vikhodya_iz_doma,
        "subtitle":
            "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
      },
      {
        "title": "Что такое ИМЗО?",
        "subtitle":
            "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
      },
      {
        "title": "Что такое eKhukumat",
        "subtitle":
            "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
      },
    ];
    final size = AdaptiveSizes(context);
    final dotProvider = ref.watch(dotIndexProvider);
    final obsecure = ref.watch(obsecureTextProvider);
    return Scaffold(
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: size.screenHeight * 0.02,
              right: 20,
              left: 20,
              bottom: 10,
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: SvgPicture.asset('assets/logos/ЛОГО.svg'),
                          ),
                          LanguageDropdown(),
                        ],
                      ),

                      SizedBox(height: size.screenHeight * 0.03),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: greyTextFBorderColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: size.verticalPadding20,
                          ),
                          child: Column(
                            children: [
                              CarouselSlider.builder(
                                carouselController: controller,
                                itemCount: texts.length,

                                itemBuilder: (context, index, newValue) {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: boxRadialGradient,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                size.horizontalPadding20,
                                          ),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/icons/Group 831885407.png',
                                                width: size.imageSize100,
                                              ),
                                              SizedBox(height: 20),
                                              SizedBox(
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  texts[index]['title'],
                                                  style: h1Title,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              SizedBox(height: size.otstup20),
                                              SizedBox(
                                                width: size.screenWidth * 0.65,
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  texts[index]['subtitle'],
                                                  style: h2TitleNotSoBold,
                                                  maxLines: 4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        MyAnimatedDotIndicator(
                                          currentPage: dotProvider,
                                          texts: texts,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  // height: 150,
                                  aspectRatio: 1.09,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    ref.read(dotIndexProvider.notifier).state =
                                        index;
                                  },
                                ),
                              ),
                              SizedBox(height: size.otstup20),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWithH1Style(
                                    S.of(context).proizvesti_vkhod,
                                  ),
                                  SizedBox(height: size.screenHeight * 0.012),
                                  textWithH2GreyStyle(
                                    S.of(context).cherez_imzo,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              SizedBox(height: size.otstup20),

                              ButtonOrContainerWithTwoParts(
                                backGroundColor: primaryButtonColor,
                                oneSideBorderColor: greenButtonBorderColor,
                                size: size,
                                partOneWidget: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/imzo_icon1.svg",
                                  ),
                                ),
                                partTwoWidget: Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Container(
                                              width: double.infinity,
                                              height: size.screenHeight * 0.5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15,
                                                    ),
                                                child: Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Authorization"),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                            icon: Icon(
                                                              Icons.cancel,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      MyTextFieldWithPrefix(
                                                        onChanged: (p0) {
                                                          
                                                        },
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty)
                                                            return 'Pole obyazatelnoe';

                                                          final emailRegex = RegExp(
                                                            r'^[^@]+@[^@]+\.[^@]',
                                                          );
                                                          if (!emailRegex
                                                              .hasMatch(
                                                                value,
                                                              )) {
                                                            return 'Neverniy format';
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            emailController,
                                                        prefixIcon: Icon(
                                                          Icons.email,
                                                        ),
                                                        hintText: "Email",
                                                      ),
                                                      SizedBox(
                                                        height: size.otstup15,
                                                      ),
                                                      MyTextFieldWithPrefix(
                                                        onChanged: (p0) {
                                                          
                                                        },
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return "Required pole";
                                                          } else if (value
                                                                  .length <
                                                              6) {
                                                            return "At least 6 signs";
                                                          }
                                                          return null;
                                                        },
                                                        // obsecureText:
                                                        //     obsecure,
                                                        controller:
                                                            passwordController,
                                                        prefixIcon: GestureDetector(
                                                          onTap: () {
                                                            // print(obsecure);
                                                            // ref.read(obsecureTextProvider.notifier).state=true;
                                                            // print(obsecure);
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                          ),
                                                        ),
                                                        hintText: "Password",
                                                      ),
                                                      SizedBox(
                                                        height: size.otstup15,
                                                      ),

                                                      My_Button(
                                                        width: double.infinity,
                                                        size: size,
                                                        child: Text("Enter"),
                                                        backgroundColor:
                                                            backgroundColor,
                                                        borderColor:
                                                            primaryButtonColor,
                                                        onPressed: () {
                                                          final form =
                                                              _formKey
                                                                  .currentState;
                                                          if (form != null &&
                                                              form.validate()) {
                                                            login(
                                                              emailController
                                                                  .text,
                                                              passwordController
                                                                  .text,
                                                            );
                                                            // emailController.clear();
                                                            // passwordController.clear();
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Center(
                                      child: buttonWhiteTextStyle(
                                        S.of(context).voyti_cherez_imzo,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.otstup20),
                              My_Button(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return ButtonModalBottomSheet(size: size);
                                    },
                                  );
                                },
                                size: size,
                                backgroundColor: greyButtonbackColor,
                                borderColor: greyBorderColor,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Text(
                                    S.of(context).ne_udayotsa_voyti,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Divider(),
                      SizedBox(height: size.otstup15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainQuestionPage(),
                                ),
                              );
                            },
                            child: textWithH1Style("Вопросы ответы"),
                          ),
                          textWithH1Style("7788", color: primaryButtonColor),
                        ],
                      ),
                      SizedBox(height: size.otstup15),
                      FooterCompanyText(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
