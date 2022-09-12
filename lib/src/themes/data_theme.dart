// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTheme {


  static final TextTheme textTheme = TextTheme(
    headline1: _headLine1,
    headline2: _headLine2,
    headline3: _headLine3,
    headline4: _headLine4,
    headline5: _headLine5,
    headline6: _headLine6,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
    subtitle1: _subTitle1,
    subtitle2: _subTitle2,
    caption: _caption,
  );

  static const TextStyle _headLine1 =
      TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold);

  static final TextStyle _headLine2 = _headLine1.copyWith();
  static final TextStyle _headLine3 = _headLine2.copyWith();
  static final TextStyle _headLine4 = _headLine3.copyWith();
  static final TextStyle _headLine5 = _headLine4.copyWith();
  static final TextStyle _headLine6 =
      _headLine5.copyWith(fontFamily: 'Akrobat');
  static final TextStyle _subTitle1 = _headLine6.copyWith();
  static final TextStyle _subTitle2 = _subTitle1.copyWith();
  static final TextStyle _bodyText1 = _subTitle2.copyWith();
  static final TextStyle _bodyText2 = _bodyText1.copyWith();
  static final TextStyle _caption = _bodyText2.copyWith();

  static ThemeData themeData(bool ligthMode) {
    return ThemeData(
        primaryColor: const Color.fromRGBO(239, 35, 60, 1),
        primaryColorDark: const Color.fromRGBO(217, 4, 41, 1),
        primaryColorLight: const Color.fromRGBO(255, 0, 110, 1),
        tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.grey,
            labelColor: ligthMode ? const Color.fromRGBO(217, 4, 41, 1) : Colors.white),
        colorScheme: ColorScheme(
            primary: const Color.fromRGBO(239, 35, 60, 1),
            primaryVariant: const Color.fromRGBO(217, 4, 41, 1),
            secondary: const Color.fromRGBO(249, 65, 68, 1),
            secondaryVariant: const Color.fromRGBO(249, 45, 8, 1),
            surface: Colors.white,
            background: Colors.grey,
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: const Color.fromRGBO(43, 45, 66, 1),
            onSurface: const Color.fromRGBO(43, 45, 66, 1),
            onBackground: const Color.fromRGBO(43, 45, 66, 1),
            onError: Colors.white,
            brightness: ligthMode ? Brightness.dark : Brightness.light,),
        textTheme: textTheme);
  }
}
