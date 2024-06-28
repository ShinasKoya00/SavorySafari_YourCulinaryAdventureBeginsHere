import 'package:flutter/material.dart';
import 'package:savory_safari/screens/recipe_details.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';

class HoursDineTypeContainer extends StatelessWidget {
  const HoursDineTypeContainer({
    super.key,
    required this.width,
    required this.recipe,
  });

  final double width;
  final RecipeDetails recipe;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    return SizedBox(
      height: SizeConfig.getHeight(20), // Dynamic height
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(Icons.watch_later_outlined, size: 18),
              SizedBox(width: SizeConfig.getWidth(2)), // Dynamic spacing
              Text(
                recipe.recipe.appPrepTime,
                style: TextStyle(
                  fontSize: SizeConfig.getFontSize(14), // Dynamic font size
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(width: SizeConfig.getWidth(1)), // Dynamic spacing
              Text(
                "hours",
                style: TextStyle(
                  fontSize: SizeConfig.getFontSize(14), // Dynamic font size
                  color: Colors.grey.shade600,
                ),
              )
            ],
          ),
          SizedBox(width: SizeConfig.getWidth(6)), // Dynamic spacing
          Row(
            children: [
              const Icon(Icons.restaurant_menu, size: 18),
              SizedBox(width: SizeConfig.getWidth(2)), // Dynamic spacing
              Text(
                recipe.recipe.appMealType[0],
                style: TextStyle(
                  fontSize: SizeConfig.getFontSize(14), // Dynamic font size
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
