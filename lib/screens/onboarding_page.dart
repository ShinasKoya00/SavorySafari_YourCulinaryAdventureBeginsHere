import 'package:flutter/material.dart';
import 'package:savory_safari/screens/homepage.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/widgets/my_text.dart';

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
            image: const AssetImage("assets/thumbnails/savory_onboard.jpg"),
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
            const MyText(text: "Cooking", fontWeight: FontWeight.w900, fontSize: 65, color: MyColors.grey),
            // Add some space between the texts
            const MyText(text: "Like a", fontWeight: FontWeight.w900, fontSize: 65, color: MyColors.grey),

            const MyText(text: "Chef", fontWeight: FontWeight.w900, fontSize: 65, color: MyColors.grey),
            const SizedBox(height: 15),
            const MyText(
                text: "Is a Piece of Cake!", fontSize: 25, fontWeight: FontWeight.w100, color: MyColors.grey),
            const SizedBox(height: 40),
            Container(
              height: 60,
              width: 190,
              decoration: BoxDecoration(
                color: MyColors.darkGreen,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                  ),
                ],
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  child: const MyText(text: "Get Started", color: MyColors.grey)),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
