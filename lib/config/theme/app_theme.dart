import 'package:flutter/material.dart';

const colorList = <Color>[
  Color(0xFF00338D),
  Color(0xFFF009FDA),
  Color(0xFFF0AB00),
];

class AppTheme {
  final int selectedColor;
  final bool isDarkmode;

  AppTheme({
    this.selectedColor = 1,
    this.isDarkmode = false,
  })  : assert(selectedColor >= 0, 'Selected color must be greater than 0'),
        assert(selectedColor < colorList.length,
            'Selected color must be less than or equal to ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        //brightness: Brightness.dark,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[selectedColor],
        appBarTheme: const AppBarTheme(centerTitle: false),
        fontFamily: 'MyriamPro', // Añadido aquí
      );

  AppTheme copyWith({int? selectedColor, bool? isDarkmode}) => AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkmode: isDarkmode ?? this.isDarkmode,
      );
}
