import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider((ref) => true);

class AppTheme {
  static ThemeData lightTheme = ThemeData(brightness: Brightness.light,primaryColor: Colors.grey);
  static ThemeData darkTheme = ThemeData(brightness: Brightness.dark,primaryColor: Colors.grey);
}
