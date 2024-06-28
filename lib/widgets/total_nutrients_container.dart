import 'package:flutter/material.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';
import 'package:savory_safari/widgets/calorie_carb_pro_fat.dart';

class TotalNutrientsContainer extends StatelessWidget {
  final double width;
  final RecipeModel recipe;

  const TotalNutrientsContainer({
    Key? key,
    required this.width,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig



    return Container(
      height: SizeConfig.getHeight(80),
      // Dynamic height
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
          SizedBox(width: SizeConfig.getWidth(15)), // Dynamic width
          CalorieCarbProteinFat(
            header: "Carbs",
            value: recipe.appCarbs,
          ),
          SizedBox(width: SizeConfig.getWidth(15)), // Dynamic width
          CalorieCarbProteinFat(
            header: "Protein",
            value: recipe.appProtein,
          ),
          SizedBox(width: SizeConfig.getWidth(15)), // Dynamic width
          CalorieCarbProteinFat(
            header: "Fat",
            value: recipe.appFat,
          ),
        ],
      ),
    );
  }
}
