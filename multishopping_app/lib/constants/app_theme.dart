import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.amber[50],
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple[100],
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.deepPurple[300],
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[600], 
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple[700], 
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.deepPurple[800], 
    ),
  );
}
