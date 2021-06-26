import 'package:flutter/material.dart';

class ScreenSize {
  static double safeAreaHeight(context){
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    double screenHeight = _mediaQuery.size.height;
    double _safeAreaVerticalPadding =
        _mediaQuery.padding.top + _mediaQuery.padding.bottom;
    double safeAreaHeight = (screenHeight - _safeAreaVerticalPadding);
    return safeAreaHeight;
  }

  static double safeAreaWidth(context){
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    double screenWidth = _mediaQuery.size.width;
    double _safeAreaHorizontalPadding =
        _mediaQuery.padding.left + _mediaQuery.padding.right;
    double    safeAreaWidth = (screenWidth - _safeAreaHorizontalPadding);
    return safeAreaWidth;
  }
}
