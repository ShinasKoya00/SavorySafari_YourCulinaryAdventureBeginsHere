import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';
import 'package:savory_safari/widgets/bookmark_state.dart';
import 'package:savory_safari/widgets/time_and_ingredients_text.dart';

class RecipeCardCustom extends StatefulWidget {
  final double width;
  final List<RecipeModel> recipeList;
  final String cardImage;
  final String calorieCount;
  final String cardTitle;
  final String hoursCount;
  final int ingredientsCount;
  final BoxFit imageFit;
  final VoidCallback? onTap;
  final double calorieIconSize;
  final double calorieFontSize;
  final double titleTimeLeftPosition;

  const RecipeCardCustom({
    Key? key,
    required this.width,
    required this.recipeList,
    required this.cardTitle,
    required this.calorieCount,
    required this.cardImage,
    required this.hoursCount,
    required this.ingredientsCount,
    required this.imageFit,
    this.onTap,
    this.calorieIconSize = 17,
    this.calorieFontSize = 16,
    this.titleTimeLeftPosition = 25,
  }) : super(key: key);

  @override
  State<RecipeCardCustom> createState() => _RecipeCardCustomState();
}

class _RecipeCardCustomState extends State<RecipeCardCustom> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    double scaledWidth = SizeConfig.getWidth(widget.width); // Dynamic width
    double scaledFontSize = SizeConfig.getFontSize(widget.calorieFontSize); // Dynamic font size
    double scaledIconSize = SizeConfig.getFontSize(widget.calorieIconSize); // Dynamic icon size

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: scaledWidth - SizeConfig.getWidth(40), // Adjusted width
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.getWidth(25)), // Adjusted border radius
          color: Colors.black38,
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black,
              Colors.transparent,
            ],
          ),
          image: DecorationImage(
            image: NetworkImage(widget.cardImage),
            fit: widget.imageFit,
          ),
        ),
        child: Stack(
          children: [
            // foreground black overlay section
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.getWidth(25)), // Adjusted border radius
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: const Alignment(0, -0.5),
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            //calorie section
            Positioned(
              top: SizeConfig.getHeight(24), // Adjusted top position
              left: SizeConfig.getWidth(13), // Adjusted left position
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getWidth(5), // Adjusted horizontal padding
                  vertical: SizeConfig.getHeight(5), // Adjusted vertical padding
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.getWidth(5)), // Adjusted border radius
                  boxShadow: [
                    BoxShadow(
                      blurRadius: SizeConfig.getWidth(5), // Adjusted blur radius
                      spreadRadius: SizeConfig.getWidth(1), // Adjusted spread radius
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.flame_fill,
                      color: Colors.white,
                      size: scaledIconSize, // Dynamic icon size
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.calorieCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: scaledFontSize, // Dynamic font size
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // bookmark section
            Positioned(
              right: SizeConfig.getWidth(8), // Adjusted right position
              top: SizeConfig.getHeight(15), // Adjusted top position
              child: BookmarkState(),
            ),

            // recipe card title and ingredients and time required
            Positioned(
              bottom: SizeConfig.getHeight(20), // Adjusted bottom position
              left: widget.titleTimeLeftPosition,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cardTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.getFontSize(22), // Dynamic font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.getHeight(8), // Adjusted height
                  ),
                  TimeAndIngredientsText(
                    ingredientsCount: widget.ingredientsCount,
                    hoursCount: widget.hoursCount,
                  ),
                  SizedBox(
                    height: SizeConfig.getHeight(4), // Adjusted height
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
