import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/widgets/time_and_ingredients_text.dart';

class RecipeCardCustom extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width - 40,
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
            image: NetworkImage(cardImage),
            fit: imageFit,
          ),
        ),
        child: Stack(
          children: [
            // background image section
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
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                      size: calorieIconSize,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      calorieCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: calorieFontSize,
                      ),
                    )
                  ],
                ),
              ),
            ),

            // bookmark section
            const Positioned(
              right: 15,
              top: 20,
              child: Icon(
                CupertinoIcons.bookmark,
                size: 18,
                color: MyColors.grey,
              ),
            ),

            // recipe card title and ingredients and time required
            Positioned(
              bottom: 20,
              left: titleTimeLeftPosition,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardTitle,
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
                    ingredientsCount: ingredientsCount,
                    hoursCount: hoursCount,
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
