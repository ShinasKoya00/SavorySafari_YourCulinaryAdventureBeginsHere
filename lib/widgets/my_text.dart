import 'package:flutter/material.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart'; // Import SizeConfig

class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const MyText({
    Key? key,
    required this.text,
    this.fontSize = 22,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    double scaledFontSize = SizeConfig.getFontSize(fontSize); // Dynamic font size

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: TextStyle(
          fontSize: scaledFontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
