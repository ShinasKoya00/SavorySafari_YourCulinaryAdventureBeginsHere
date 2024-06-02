import 'package:flutter/material.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}