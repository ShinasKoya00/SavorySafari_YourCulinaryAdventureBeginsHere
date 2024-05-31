import 'package:flutter/material.dart';

class TimeAndIngredientsText extends StatelessWidget {
  final String ingredientsCount;
  final String hoursCount;

  const TimeAndIngredientsText({
    super.key,
    required this.ingredientsCount,
    required this.hoursCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              ingredientsCount,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "ingrediants",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          children: [
            Text(
              hoursCount,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "hours",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
