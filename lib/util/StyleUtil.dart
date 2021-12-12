import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';

class StyleUtil {
  static const textSearchStyle =
      TextStyle(color: Colors.black54, fontSize: Constant.APP_BAR_TEXT_FONT);
  static const textAddQuantityStyle =
      TextStyle(color: Pallete.textColor, fontSize: Constant.TEXT_FONT);
  static const textSearchHintStyle =
      TextStyle(color: Pallete.experimentFontColor, fontSize: Constant.APP_BAR_TEXT_FONT);

  static ThemeData themeData = ThemeData(
      // primarySwatch: ColorUtil.primarySwatch,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.black,
      accentColor: Colors.black,
      fontFamily: Constant.ROBOTO_REGULAR,
      buttonTheme: ButtonThemeData(minWidth: 1000, height: 50));
}
