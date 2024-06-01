import 'package:flutter/material.dart';

class TimeAndIngredientsText extends StatelessWidget {
  final int ingredientsCount;
  final String hoursCount;
  final Color fontColor;
  final double heightBetweenRows;
  final Color fontColorBold;
  final double fontSize;

  const TimeAndIngredientsText({
    super.key,
    required this.ingredientsCount,
    required this.hoursCount,
    this.fontColor = Colors.white,
    this.fontColorBold = Colors.white,
    this.heightBetweenRows = 2.0,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              ingredientsCount.toString(),
              style: TextStyle(
                color: fontColorBold,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "ingrediants",
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
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
                fontSize: fontSize,
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
                fontSize: fontSize,
              ),
            )
          ],
        ),
      ],
    );
  }
}
