import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savory_safari/screens/homepage.dart';
import 'package:savory_safari/screens/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),

      home: const OnboardingPage(),
      // home: SearchPage(
      //   query: "juice",
      // ),
    );
  }
}
