import 'package:flutter/material.dart';

class AppColors {
  static const fundo = Color(0xFF06121C);
  static const hero = Color(0xFF0A1C2A);
  static const superficie = Color(0xFF0D2230);
  static const linha = Color(0xFF1C3A4D);
  static const brilho = Color(0xFF4FD1FF);
  static const ouro = Color(0xFFFFC15A);
  static const texto = Color(0xFFE6F3FA);
  static const mutado = Color(0xFF8FB0C2);
}

ThemeData buildTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.fundo,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.brilho,
      onPrimary: Color(0xFF04141D),
      secondary: AppColors.ouro,
      surface: AppColors.superficie,
      onSurface: AppColors.texto,
    ),
    textTheme: base.textTheme.apply(bodyColor: AppColors.texto, displayColor: AppColors.texto),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.fundo, foregroundColor: AppColors.texto),
  );
}

InputDecoration decoracao(String rotulo) => InputDecoration(
      labelText: rotulo,
      filled: true,
      fillColor: AppColors.superficie,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
