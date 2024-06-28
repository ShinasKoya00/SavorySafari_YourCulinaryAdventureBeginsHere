import 'package:flutter/material.dart';
import 'package:savory_safari/screens/homepage.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';
import 'package:savory_safari/widgets/container_shadow_box.dart';
import 'package:savory_safari/widgets/my_text.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;

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
            MyText(
              text: "Cooking",
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.getFontSize(65),
              color: MyColors.grey,
            ),
            // Add some space between the texts
            MyText(
              text: "Like a",
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.getFontSize(65),
              color: MyColors.grey,
            ),
            MyText(
              text: "Chef",
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.getFontSize(65),
              color: MyColors.grey,
            ),
            SizedBox(height: SizeConfig.getHeight(15)),
            MyText(
              text: "Is a Piece of Cake!",
              fontSize: SizeConfig.getFontSize(25),
              fontWeight: FontWeight.w100,
              color: MyColors.grey,
            ),
            SizedBox(height: SizeConfig.getHeight(40)),
            ContainerShadowBox(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              height: SizeConfig.getHeight(60),
              width: SizeConfig.getWidth(190),
              borderRadius: BorderRadius.circular(SizeConfig.getRadius(16)),
              color: MyColors.darkGreen,
              boxShadowColor: Colors.black,
              text: "Get Started",
              textSize: SizeConfig.getFontSize(18),
              textColor: MyColors.grey,
            ),
            SizedBox(height: SizeConfig.getHeight(70)),
          ],
        ),
      ),
    );
  }
}
