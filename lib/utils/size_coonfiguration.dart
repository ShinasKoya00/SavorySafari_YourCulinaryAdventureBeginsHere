import 'package:flutter/material.dart';

class SizeConfig {
  static double screenHeight = 0;
  static double screenWidth = 0;

  static double heightMultiplier = 0;
  static double widthMultiplier = 0;

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    heightMultiplier = screenHeight / 872.72;
    widthMultiplier = screenWidth / 392.72;
  }

  static double getHeight(double height) {
    return height * heightMultiplier;
  }

  static double getWidth(double width) {
    return width * widthMultiplier;
  }

  static double getFontSize(double fontSize) {
    return fontSize * heightMultiplier;
  }

  static double getIconSize(double iconSize) {
    return iconSize * heightMultiplier;
  }

  static double getRadius(double radius) {
    return radius * heightMultiplier;
  }

  static int getMaxLines(double containerHeight, double lineHeight) {
    // Calculate maximum lines based on available container height and line height
    int maxLines = (containerHeight / lineHeight).floor();
    return maxLines > 2 ? maxLines : 10; // Limit to a maximum of 8 lines
  }
}