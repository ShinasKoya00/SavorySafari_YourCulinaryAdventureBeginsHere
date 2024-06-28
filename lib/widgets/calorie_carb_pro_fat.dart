import 'package:flutter/material.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';

class CalorieCarbProteinFat extends StatelessWidget {
  final String header;
  final String value;

  const CalorieCarbProteinFat({
    super.key,
    required this.header,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          header,
          style: TextStyle(
            fontSize: SizeConfig.getFontSize(17), // Dynamic font size
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SizeConfig.getHeight(10)), // Dynamic spacing
        Text(
          value,
          style: TextStyle(
            fontSize: SizeConfig.getFontSize(17), // Dynamic font size
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
