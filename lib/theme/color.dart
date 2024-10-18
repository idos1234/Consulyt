import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme colorScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFFDE3F),
      secondary: Color(0xFF000000),
      tertiary:  Color(0xFF6D9B7B),
      error: Color(0xFFFF5449),
      surface: Color(0xFFFFFFFF),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onTertiary: Color(0xFFFFFFFF),
      onError: Color(0xFFFFFFFF),
      onSurface: Color(0xFF343A40)
    );
  }

  ThemeData light() {
    return theme(colorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface
  );
}