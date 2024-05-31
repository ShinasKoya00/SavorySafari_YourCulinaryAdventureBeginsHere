import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/widgets/time_and_ingredients_text.dart';

class RecipeCardCustom extends StatelessWidget {
  final double width;
  final List<RecipeModel> recipeList;
  final String cardImage;
  final String cardTitle;
  final String hoursCount;
  final String ingredientsCount;
  final BoxFit imageFit;
  final VoidCallback? onTap;

  const RecipeCardCustom({
    super.key,
    required this.width,
    required this.recipeList,
    required this.cardTitle,
    required this.cardImage,
    required this.hoursCount,
    required this.ingredientsCount,
    required this.imageFit,
    this.onTap,
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
            const Positioned(
              right: 15,
              top: 20,
              child: Icon(
                CupertinoIcons.bookmark,
                size: 18,
                color: MyColors.grey,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 25,
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
