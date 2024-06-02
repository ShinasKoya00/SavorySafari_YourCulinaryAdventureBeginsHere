import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:savory_safari/screens/search_page.dart';
import 'package:savory_safari/utils/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: width / 1.45,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        // color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
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
        // tab animation curves
        duration: const Duration(milliseconds: 800),
        tabBorderRadius: 10,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        color: Colors.grey,
        // activeColor: MyColors.bottomNavBottomBlack,

        tabBackgroundColor: MyColors.bottomNavGreenishYellow,
        tabs: [
          const GButton(
            icon: CupertinoIcons.compass,
          ),
          GButton(
            icon: CupertinoIcons.search_circle,
            onPressed: () {
              log("Bottom Navigation is pressed");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(query: "juice"),
                ),
              );
            },
          ),
          const GButton(
            icon: CupertinoIcons.bookmark,
          ),
        ],
      ),
    );
  }
}