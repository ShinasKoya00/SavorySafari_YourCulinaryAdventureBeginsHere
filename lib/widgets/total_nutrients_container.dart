import 'package:flutter/material.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/widgets/calorie_carb_pro_fat.dart';

class TotalNutrientsContainer extends StatelessWidget {
  final double width;
  final RecipeModel recipe;

  const TotalNutrientsContainer({super.key, required this.width, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CalorieCarbProteinFat(
            header: "Calories",
            value: recipe.appCalories,
          ),
          const SizedBox(width: 15),
          CalorieCarbProteinFat(
            header: "Carbs",
            value: recipe.appCarbs,
          ),
          const SizedBox(width: 15),
          CalorieCarbProteinFat(
            header: "Protein",
            value: recipe.appProtein,
          ),
          const SizedBox(width: 15),
          CalorieCarbProteinFat(
            header: "Fat",
            value: recipe.appFat,
          ),
        ],
      ),
    );
  }
}
