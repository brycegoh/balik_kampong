import 'package:flutter/material.dart';

class ScreenSize {
  static late final MediaQueryData _mediaQuery;
  static late final double screenWidth;
  static late final double screenHeight;
  static late final double _safeAreaHorizontalPadding;
  static late final double _safeAreaVerticalPadding;
  static late final double safeAreaWidth;
  static late final double safeAreaHeight;

  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    screenWidth = _mediaQuery.size.width;
    screenHeight = _mediaQuery.size.height;
    _safeAreaHorizontalPadding =
        _mediaQuery.padding.left + _mediaQuery.padding.right;
    _safeAreaVerticalPadding =
        _mediaQuery.padding.top + _mediaQuery.padding.bottom;
    safeAreaWidth = (screenWidth - _safeAreaHorizontalPadding);
    safeAreaHeight = (screenHeight - _safeAreaVerticalPadding);
  }
}
