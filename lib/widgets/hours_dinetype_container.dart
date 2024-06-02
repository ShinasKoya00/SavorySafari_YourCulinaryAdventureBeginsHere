import 'package:flutter/material.dart';
import 'package:savory_safari/screens/recipe_details.dart';

class HoursDineTypeContainer extends StatelessWidget {
  const HoursDineTypeContainer({
    super.key,
    required this.width,
    required this.widget,
  });

  final double width;
  final RecipeDetails widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(Icons.watch_later_outlined, size: 18),
              const SizedBox(width: 5),
              Text(widget.recipe.appPrepTime,
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade600)),
              const SizedBox(width: 3),
              Text("hours",
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade600))
            ],
          ),
          const SizedBox(width: 30),
          Row(
            children: [
              const Icon(Icons.restaurant_menu, size: 18),
              const SizedBox(width: 5),
              Text(widget.recipe.appMealType[0],
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade600)),
            ],
          ),
        ],
      ),
    );
  }
}