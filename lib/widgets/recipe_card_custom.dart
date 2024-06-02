import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savory_safari/models/recipe_model.dart';
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
    super.key,
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
  });

  @override
  State<RecipeCardCustom> createState() => _RecipeCardCustomState();
}

class _RecipeCardCustomState extends State<RecipeCardCustom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width - 40,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
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
                  borderRadius: BorderRadius.circular(25),
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
              top: 24,
              left: 13,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.7),
                  )
                ]),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.flame_fill,
                      color: Colors.white,
                      size: widget.calorieIconSize,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.calorieCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: widget.calorieFontSize,
                      ),
                    )
                  ],
                ),
              ),
            ),

            // bookmark section
            const Positioned(
              right: 8,
              top: 15,
              child: BookmarkState(),
            ),

            // recipe card title and ingredients and time required
            Positioned(
              bottom: 20,
              left: widget.titleTimeLeftPosition,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cardTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TimeAndIngredientsText(
                    ingredientsCount: widget.ingredientsCount,
                    hoursCount: widget.hoursCount,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
