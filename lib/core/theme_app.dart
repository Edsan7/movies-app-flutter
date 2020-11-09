import 'package:flutter/material.dart';

final themeApp = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.red,
  textTheme: TextTheme(bodyText2: TextStyle(fontSize: 18)),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
);
