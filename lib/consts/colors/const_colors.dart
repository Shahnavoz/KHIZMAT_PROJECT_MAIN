import 'package:flutter/material.dart';

//BUTTON'S COLORS
const Color backgroundColor = Color(0xFFE5F5EE);
const Color primaryButtonColor = Color(0xFF26AC71);
const Color secondaryColorForScroll=Color(0xFF90C0BD);
const Color nonActiveDotColor = Color(0xFFEAF7F1);
const Color greenButtonBorderColor = Color(0xFF219C65);
const Color greyButtonBorderColor = Color(0xFFF7F7F7);
const Color greyButtonbackColor = Color(0xFFD4D4D4);
const Color notSoBlackButtonColor = Color(0xFF343434);
const Color primaryGreyTextColor = Color(0xFFA9A9A9);
const Color secondaryGreyTextColor = Color(0xFF5E5E5E);
const Color activeIconColor = Color(0xFF26AC71);
const Color nonActiveIconColor = Color(0xFFA2B8AE);
const Color dividerColor = Color.fromARGB(255, 195, 245, 224);
const Color greyIconColor = Color(0xFFD4D4D4);
const Color lightBlackTextColor = Color(0xFF4E4E4E);
const Color greyDateColor = Color(0xFFAFAFAF);
const Color greyTextFBorderColor = Color(0xFFE8E8E8);
const Color mainPagePartBackGround = Color(0xFFE0F4EB);
const Color wrapItemColor = Color(0xFFA2B8AE);
const Color textFieldBorderColor = Color(0xFFE2E2E2);
const Color boxGreyTabBorder = Color(0xFFF7F7F7);
const LinearGradient gradientColor = LinearGradient(
  colors: [Color(0xFF000000), Color(0xFF26AC71), Color(0xFFA2B8AE)],
);
const LinearGradient newGradientColor = LinearGradient(
  colors: [Color(0xFF015057), Color(0xFF000000), Color(0xFF015057)],
);
const RadialGradient boxRadialGradient = RadialGradient(
  colors: [
    Color(0xFFFFFFFF), // белый в центре
    Color.fromARGB(255, 200, 231, 239), // зелёный на середине
    Color(0xFFFFFFFF), // белый по краям
  ],
  stops: [0.0, 0.5, 1.0], // позиции цветов
  center: Alignment.center, // по умолчанию центр
  radius: 1, // размер градиента (0.0–1.0)
);
const RadialGradient wrapRadialGradient = RadialGradient(
  colors: [
    Color(0xFF015057), // белый в центре
    Color(0x26AC711F), // зелёный на середине
    Color(0xFFFFFFFF), // белый по краям
  ],
  stops: [0.0, 0.12 % 0], // позиции цветов
  center: Alignment.center, // по умолчанию центр
  radius: 1, // размер градиента (0.0–1.0)
);
const RadialGradient boxBlueRadialGradient = RadialGradient(
  colors: [
    Color(0xFFFFFFFF), // белый в центре
    Color.fromARGB(255, 197, 237, 244), // зелёный на середине
    Color(0xFFFFFFFF), // белый по краям
  ],
  stops: [0.0, 0.5, 1.0], // позиции цветов
  center: Alignment.center, // по умолчанию центр
  radius: 1, // размер градиента (0.0–1.0)
);
const LinearGradient buttonsTitleGradient = LinearGradient(
  colors: [Color(0xFF015057), Color(0xFF90C0BD)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0.0, 0.5],
);

const borderLinearGradient = LinearGradient(
  colors: [
    Color(0xFFF9F9F9), // первый цвет
    Color(0xFF26AC71), // второй цвет
    Color(0xFFF5F5F5), // третий цвет
  ],
  stops: [
    0.0, // первый цвет в начале
    0.12, // второй цвет на 12%
    1.0, // третий цвет в конце
  ],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

const Color greyBorderColor = Color(0xFFD4D4D4);

//TEXT'S COLORS

EdgeInsetsGeometry internalPadding = EdgeInsets.symmetric(horizontal: 25);
