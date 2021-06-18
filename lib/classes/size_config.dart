import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late EdgeInsets viewInsets;
  static late EdgeInsets viewPadding;
  static late EdgeInsets padding;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = _mediaQueryData.size.width / 100;
    blockSizeVertical = _mediaQueryData.size.height / 100;
    viewInsets = _mediaQueryData.viewInsets;
    viewPadding = _mediaQueryData.viewPadding;
    padding = _mediaQueryData.padding;
  }
}
