import 'package:flutter/material.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart'; // Import SizeConfig

class TimeAndIngredientsText extends StatelessWidget {
  final int ingredientsCount;
  final String hoursCount;
  final Color fontColor;
  final double heightBetweenRows;
  final Color fontColorBold;
  final double fontSize;

  const TimeAndIngredientsText({
    Key? key,
    required this.ingredientsCount,
    required this.hoursCount,
    this.fontColor = Colors.white,
    this.fontColorBold = Colors.white,
    this.heightBetweenRows = 2.0,
    this.fontSize = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    double scaledFontSize = SizeConfig.getFontSize(fontSize); // Dynamic font size

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              ingredientsCount.toString(),
              style: TextStyle(
                color: fontColorBold,
                fontSize: scaledFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "ingredients",
              style: TextStyle(
                color: fontColor,
                fontSize: scaledFontSize,
              ),
            )
          ],
        ),
        SizedBox(
          height: heightBetweenRows,
        ),
        Row(
          children: [
            Text(
              hoursCount.toString(),
              style: TextStyle(
                color: fontColorBold,
                fontSize: scaledFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "hours",
              style: TextStyle(
                color: fontColor,
                fontSize: scaledFontSize,
              ),
            )
          ],
        ),
      ],
    );
  }
}
