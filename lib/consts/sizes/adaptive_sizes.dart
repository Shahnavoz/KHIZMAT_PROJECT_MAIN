import 'package:flutter/material.dart';

class AdaptiveSizes {
  final BuildContext context;
  late final double screenWidth;
  late final double screenHeight;
  //IMAGE SIZE
  late final double imageSize100;
  late final double imageSize50;
  late final double cancelIconSize30;
  late final double cancelIconSize50;
  late final double horizontalPadding20;
  late final double verticalPadding20;


  late final double otstup20;
  late final double otstup30;
  late final double otstup50;
  late final double otstup60;
  late final double otstup35;
  late final double otstup25;
  late final double otstup15;
  late final double otstup10;
  late final double otstup5;

  AdaptiveSizes(this.context) {
    final media = MediaQuery.of(context).size;

    screenWidth = media.width;
    screenHeight = media.height;

    imageSize100 = screenWidth * 0.1;
    imageSize50 = screenWidth * 0.06;
    cancelIconSize30 = screenWidth * 0.080;
    cancelIconSize50 = screenWidth * 0.090;
    horizontalPadding20=screenWidth*0.02;
    verticalPadding20=screenHeight*0.02;

    otstup20=screenHeight*0.020;
    otstup25=screenHeight*0.025;
    otstup15=screenHeight*0.015;
    otstup30=screenHeight*0.03;
    otstup50=screenHeight*0.05;
    otstup60=screenHeight*0.06;
    otstup35=screenHeight*0.035;
    otstup10=screenHeight*0.01;
    otstup5=screenHeight*0.005;
  }
}
