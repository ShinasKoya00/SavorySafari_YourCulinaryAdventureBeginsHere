import 'package:flutter/material.dart';
import 'package:savory_safari/screens/homepage.dart';
import 'package:savory_safari/utils/colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/thumbnails/savory_onboard.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.55),
              BlendMode.multiply,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyText(text: "Cooking", fontWeight: FontWeight.w900, fontSize: 65, color: MyColors.grey),
            // Add some space between the texts
            MyText(text: "Like a", fontWeight: FontWeight.w900, fontSize: 65, color: MyColors.grey),

            MyText(text: "Chef", fontWeight: FontWeight.w900, fontSize: 65, color: MyColors.grey),
            SizedBox(height: 15),
            MyText(
                text: "Is a Piece of Cake!", fontSize: 25, fontWeight: FontWeight.w100, color: MyColors.grey),
            SizedBox(height: 40),
            Container(
              height: 60,
              width: 190,
              decoration: BoxDecoration(
                color: MyColors.darkGreen,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                  ),
                ],
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: MyText(text: "Get Started", color: MyColors.grey)),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const MyText({
    super.key,
    required this.text,
    this.fontSize = 22,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
