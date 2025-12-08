import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/methods/common_methods.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/button_or_container_with_two_parts.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/step_with_num_and_text.dart';

class ButtonModalBottomSheet extends StatefulWidget {
  const ButtonModalBottomSheet({super.key, required this.size});

  final AdaptiveSizes size;

  @override
  State<ButtonModalBottomSheet> createState() => _ButtonModalBottomSheetState();
}

class _ButtonModalBottomSheetState extends State<ButtonModalBottomSheet> {
  bool isShown = false;

  void showText() {
    setState(() {
      isShown = !isShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Container(
      // color: Colors.amber,
      width: double.infinity,
      height: widget.size.screenHeight * 0.75,
      child: Column(
        children: [
          ModalAppBar(mainText: "Проблемы со входом"),

          // SizedBox(height: widget.size.screenHeight*0.4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                textH2GreyTitle(
                  "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
                  textColor: lightBlackTextColor,
                ),
                SizedBox(height: widget.size.screenHeight * 0.02),

                StepWithNumAndText(
                  textNumber: "1",
                  mainTitle:
                      "Убедись что вы авторизованны на сервисе IMZO и прошли идентификацию в центре обслуживания.",
                  widget: widget,
                  secondText: SizedBox(
                    width: widget.size.screenWidth * 0.8,
                    child: GestureDetector(
                      onTap: () {
                        //NAVIGATSIYA BA FAQ PAGE
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainQuestionPage(),
                          ),
                        );
                      },
                      child: textH2GreyTitle(
                        "Подробнее",
                        textColor: primaryButtonColor,
                      ),
                    ),
                  ),
                  greyLine: Container(
                    height: widget.size.screenHeight * 0.06,
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                StepWithNumAndText(
                  widget: widget,
                  textNumber: "2",
                  mainTitle:
                      "Убедись что вы подключены к интернету и не имеете ограничения со стороны вашего интернет провайдера.",
                  greyLine: Container(
                    height: widget.size.screenHeight * 0.035,
                    width: 2,
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: widget.size.screenHeight * 0.02),

                Container(
                  decoration: BoxDecoration(
                    gradient: boxRadialGradient,
                    border: Border.all(color: greyBorderColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: size.verticalPadding20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWithH2BlackStyle(
                          "Связаться с специалистом поддержки",
                        ),
                        SizedBox(height: size.otstup15),
                        ButtonOrContainerWithTwoParts(
                          size: widget.size,
                          partOneWidget: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "7788",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ),
                          partTwoWidget: GestureDetector(
                            onTap: () {
                              makePhoneCall("870904004");
                            },
                            child: Text(
                              "Позвонить оператору",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          backGroundColor: Colors.white,
                          oneSideBorderColor: greyBorderColor,
                          horizontalPadPartOne: 0,
                        ),
                        SizedBox(height: widget.size.screenHeight * 0.012),
                        ButtonOrContainerWithTwoParts(
                          size: widget.size,
                          partOneWidget: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.telegram,
                                  size: widget.size.cancelIconSize30,
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ),
                          partTwoWidget: GestureDetector(
                            onTap: () {
                              openTelegram("@shahnavoz1");
                            },
                            child: Text(
                              "Написать в телеграм",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          backGroundColor: Colors.white,
                          oneSideBorderColor: greyBorderColor,
                          horizontalPadPartOne: 0,
                        ),
                      ],
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

class ModalAppBar extends StatelessWidget {
  const ModalAppBar({super.key, required this.mainText});

  // final ButtonModalBottomSheet widget;
  final String mainText;

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 16, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWithH1Style(mainText),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.cancel,
                  color: greyIconColor,
                  size: size.cancelIconSize50,
                ),
              ),
            ],
          ),
        ),
        Divider(),
        SizedBox(height: size.otstup20),
      ],
    );
  }
}
