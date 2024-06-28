import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:savory_safari/screens/search_page.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig for dynamic sizing

    return Container(
      height: SizeConfig.getHeight(50),
      // Dynamic height
      width: width / 1.45,
      // Dynamic width
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.getWidth(7), // Dynamic horizontal padding
        vertical: SizeConfig.getHeight(5), // Dynamic vertical padding
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.getWidth(10)), // Dynamic border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade800,
            offset: const Offset(0.0, 10.0),
            blurRadius: 10.0,
            spreadRadius: -5.0,
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MyColors.bottomNavTopBlack,
            MyColors.bottomNavBottomBlack,
          ],
        ),
      ),
      child: GNav(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 800),
        tabBorderRadius: SizeConfig.getWidth(10),
        // Dynamic tab border radius
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getWidth(30), // Dynamic tab horizontal padding
          vertical: SizeConfig.getHeight(10), // Dynamic tab vertical padding
        ),
        color: Colors.grey,
        tabBackgroundColor: MyColors.bottomNavGreenishYellow,
        tabs: [
          GButton(
            icon: CupertinoIcons.compass,
            onPressed: () {
              // Handle compass icon press
              log("Compass icon pressed");
              // Add navigation logic here if needed
            },
          ),
          GButton(
            icon: CupertinoIcons.search_circle,
            onPressed: () {
              // Handle search icon press
              log("Search icon pressed");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(query: "juice"),
                ),
              );
            },
          ),
          GButton(
            icon: CupertinoIcons.bookmark,
            onPressed: () {
              // Handle bookmark icon press
              log("Bookmark icon pressed");
              // Add navigation logic here if needed
            },
          ),
        ],
      ),
    );
  }
}
