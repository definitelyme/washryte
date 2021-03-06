import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Palette {
  Palette._();

  static Color fromHex(String hex) {
    if (!hex.startsWith('#')) hex = '#$hex';
    return Color(int.parse(hex.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color get random => Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);

  static String stringHex(
    Color color, {
    bool withAlpha = true,
    bool appendHash = false,
  }) {
    var value = color.toString().split('(0x')[1].split(')')[0];

    if (!withAlpha) value = value.length > 6 ? value.replaceRange(0, 2, '') : value;
    if (appendHash) value = '#$value';
    return value;
  }

  static MaterialColor material(Color color) => MaterialColor(color.value, swatch(color));

  static Map<int, Color> swatch(Color color) {
    var _color = color;
    int r, g, b;

    r = _color.red;
    g = _color.green;
    b = _color.blue;

    return {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };
  }

  // App Colors
  static const _primaryPrivate = 0xffF9F9F9;
  static const _secondaryPrivate = 0xff070D15;
  static const _accentPrivate = 0xff0088C0;

  static const MaterialColor primaryColor = MaterialColor(
    _primaryPrivate,
    <int, Color>{
      50: Color(0xFFf2f2f2),
      100: Color(0xFFefefef),
      200: Color(0xFFededed),
      300: Color(0xFFeaeaea),
      400: Color(0xFFe8e8e8),
      500: Color(_primaryPrivate),
      600: Color(0xFFcecece),
      700: Color(0xFFb7b7b7),
      800: Color(0xFFa0a0a0),
      900: Color(0xFF898989),
    },
  );

  static const MaterialColor secondaryColor = MaterialColor(
    _secondaryPrivate,
    <int, Color>{
      50: Color(0xFF83868a),
      100: Color(0xFF6a6e73),
      200: Color(0xFF51565b),
      300: Color(0xFF393d44),
      400: cardColorDark,
      500: Color(_secondaryPrivate),
      600: Color(0xFF060c13),
      700: Color(0xFF060a11),
      800: Color(0xFF05090f),
      900: Color(0xFF04080d),
    },
  );

  static const MaterialColor accentColor = MaterialColor(
    _accentPrivate,
    <int, Color>{
      50: Color(0xFF80c4e0),
      100: Color(0xFF66b8d9),
      200: Color(0xFF4dacd3),
      300: Color(0xFF33a0cd),
      400: Color(0xFF1a94c6),
      500: Color(_accentPrivate),
      600: Color(0xFF007aad),
      700: Color(0xFF006d9a),
      800: Color(0xFF005f86),
      900: Color(0xFF005273),
    },
  );

  static const MaterialColor paletteAccent = MaterialColor(0xFFFFD3D1, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFD3D1),
    400: Color(0xFFFFA29E),
    700: Color(0xFFFF8985),
  });

  static const Color cardColorLight = Colors.white;
  static const Color cardColorDark = Color(0xff20252c);

  static const Color accentYellow = Color(0xFFF5CB4C);
  static const Color accentGreen = Color(0xFF33CC3C);
  static const Color accentBlue = Color(0xFF2597BB);
  static const Color accentPurple = Color(0xFFBB6BD9);
  static const Color accentRed = Color(0xFFE35959);

  static const Color accent20 = Color(0xFFEEFFF5);
  static const Color accentPastel = Color(0xFFF3FFFA);
  // static const Color accent40 = Color(0xFFE69F96);
  // static const Color accent60 = Color(0xFFE87E70);

  static const Color settingsGreen = Color(0xFF2A8621);
  static const Color settingsPurple = Color(0xFF9B5EEA);
  static const Color settingsYellow = Color(0xFFF4D577);
  static const Color settingsTeal = Color(0xFF1997B0);

  static const Color pastelRed = Color(0xFFFFF3F3);
  static const Color pastelPurple = Color(0xFFFAEEFF);
  static const Color pastelYellow = Color(0xFFFAF5E5);
  static const Color accentLightYellow = pastelYellow;
  static const Color accentLightYellow2 = Color(0xFFFFF9DB);
  static const Color pastelGreen = Color(0xFFE7F9E8);
  static const Color pastelGreen2 = Color(0xFFF4FFF3);
  static const Color accentLightGreen = pastelGreen;
  static const Color accentLightBlue = Color(0xFFE3F6FC);
  static const Color pastelBlue = Color(0xFFDAF2FF);
  static const Color pastelBlue2 = Color(0xFFF3FDFF);

  static const Color textTitle = Color(0xFF24272F);
  static const Color text100 = Color(0xFF47484D);
  static const Color text80 = Color(0xFF353D51);
  static const Color text60 = Color(0xFF686E7C);
  static const Color text40 = Color(0xFF9A9EA8);
  static const Color text20 = Color(0xFFCDCFD3);

  static const Color subTextLight = Color(0xFFA7A7A7);
  static const Color subTextDark = Color(0xFFA7A7A7);

  static const Color neutralMoon = Color(0xFFFDFDFD);
  static const Color neutralF9 = Color(0xFFF9F9F9);
  static const Color neutralFA = Color(0xFFFAFAFA);
  static const Color neutralF4 = Color(0xFFF4F4F4);
  static const Color neutralF3 = Color(0xFFF3F3F3);
  static const Color neutralF5 = Color(0xFFF5F5F5);
  static const Color neutralC4 = Color(0xFFc4c4c4);
  static const Color neutralC7 = Color(0xFFC7C7C7);
  static const Color neutralE2 = Color(0xFFE2E2E2);
  static const Color neutralLabel = Color(0xFF62736B);

  static const Color flutterwave = Color(0xFFEBA12A);
  static const Color stripe2 = Color(0xFF2697D4);
  static const Color paystack = Color(0xFF00C3F7);
  static const Color addressDefaultBlue = pastelBlue;

  static const Color oAuthColor = Color(0xff2E3A59);

  // Dark Mode Colors
  static const Color accentDark = Color(0xFFD27D7D);
  static const Color text100Dark = Color(0xFF8D8D93);
  static const Color headingDark = Color(0xFFE2E2E2);
  static const Color inputTextDark = Color(0xFF212121);
  static const Color toggleDark = Color(0xFF393938);
  static const Color iconLight = Color(0xFFB7BCC2);
  static const Color iconDark = Color(0xFFACACAC);
  static const Color neutralMoonDark = neutralFA;
  static const Color neutralLabelDark = Color(0xFFACACAC);

  static const Color accentDarkPurple = Color(0xFF3B003B);
  static const Color accentDarkYellow = Color(0xFFD8AA1C);
  static const Color accentDarkYellow2 = Color(0xFFF5C739);
  static const Color accentDarkGreen = Color(0xFF237D28);
  static const Color accentDarkBlue = Color(0xFF3F7695);

  static const Color permissionGreen1 = Color(0xFF138750);
  static const Color permissionGreen2 = Color(0xFF177649);

  static const Color permissionGrey1 = Color(0xFFB9BABB);
  static const Color permissionGrey2 = Color(0xFF979797);
  static const Color welcomeGrey = Color(0xFF637381);

  static const Color lightRed = Color(0xFFff7862);

  static const Color yellow = Color(0xFFECAE12);
  static const Color fbButton = Color(0xFF425bb4);
  static const Color googleButton = Color(0xFF34bbf0);
  static const Color twitterButton = Color(0xFF00acee);
  static const Color loginButton = Color(0xFF3871b6);

  static const Color errorRed = Color(0xFFED4337);
  static const Color deepRed = Color(0xFFb3000e);

  static const Color successGreen = Color(0xFF4bb543);

  static const Color transparent = Colors.transparent;
  static const Color infoBlue = Color(0xff42a5f5);

  static const Color inputBgColor = Color(0xffF0F0F0);

  static const Color backgroundGrey = Color(0xffF8FAFB);
}
