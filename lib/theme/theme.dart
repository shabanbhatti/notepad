
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  scrollbarTheme: ScrollbarThemeData(thumbColor: WidgetStatePropertyAll(Colors.grey)),
  primaryColor: Colors.black,
  cardTheme: CardTheme(color: const Color.fromARGB(255, 239, 239, 239),),
  dialogTheme: DialogTheme(backgroundColor:  const Color.fromARGB(255, 239, 239, 239),),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black, selectionHandleColor: Colors.black),
  snackBarTheme: SnackBarThemeData(backgroundColor:Colors.amber, )
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.white,
  scrollbarTheme: ScrollbarThemeData(thumbColor: WidgetStatePropertyAll(Colors.grey)),
  cardTheme: CardTheme(color: const Color.fromARGB(255, 55, 54, 54)),
  dialogTheme: DialogTheme(backgroundColor:  const Color.fromARGB(255, 55, 54, 54),),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white, selectionHandleColor: Colors.white),
  snackBarTheme: SnackBarThemeData(backgroundColor:Colors.amber )
);
