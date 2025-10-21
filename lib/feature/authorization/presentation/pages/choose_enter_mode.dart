import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';

class ChooseEnterMode extends StatefulWidget {
  const ChooseEnterMode({super.key});

  @override
  State<ChooseEnterMode> createState() => _ChooseEnterModeState();
}

class _ChooseEnterModeState extends State<ChooseEnterMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: internalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Выберите сценарий взаимодейсвтия', style: h1Title),
              SizedBox(height: 12,),
              Container(
                height: MediaQuery.of(context).size.height*0.7,
                decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      child: Row(
                        children: [
                          Container(
                            // width: MediaQuery.sizeOf(context).width * 0.1,
                            decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Text(
                                  '1',
                                  style: TextStyle(fontSize: 50),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Гостевой режим', style: h2Title),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  maxLines: 3,
                                  'Получайте доступ к услугам в одном приложении',
                                  style: h2TitleNotSoBold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Container(
                            // width: MediaQuery.sizeOf(context).width * 0.1,
                            decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Text('1', style: TextStyle(fontSize: 50)),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Гостевой режим', style: h2Title),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  maxLines: 3,
                                  'Получайте доступ к услугам в одном приложении',
                                  style: h2TitleNotSoBold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
